// ignore_for_file: deprecated_member_use

import 'dart:developer';
import 'dart:io';

import 'package:crises_control/src/core/constants.dart';
import 'package:crises_control/src/core/errors/cc_error.dart';
import 'package:crises_control/src/core/errors/exception_handler.dart';
import 'package:crises_control/src/core/errors/exceptions.dart';
import 'package:crises_control/src/core/models/authentication_credentials.dart';
import 'package:crises_control/src/core/models/login_data.dart';
import 'package:crises_control/src/core/services/oauth_service/oauth_configurations.dart';
import 'package:crises_control/src/core/services/oauth_service/oauth_service.dart';
import 'package:crises_control/src/core/services/secure_storge_service.dart';
import 'package:crises_control/src/login/services/authentication_database_service.dart';
import 'package:crises_control/src/login/services/authentication_service.dart';
import 'package:crises_control/src/login/services/login_rest_service.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginRepository {
  LoginRepository(
    this._authenticationService,
    this._authenticationDatabase,
    this._oAuthSevrice,
    this._secureStorageService,
    this._loginRestService,
  );
  final SecureStorageService _secureStorageService;
  final AuthenticationService _authenticationService;
  final AuthenticationDatabaseService _authenticationDatabase;
  final OAuthSevrice _oAuthSevrice;
  final LoginRestService _loginRestService;

  ///This function sets the API url for the given customer id
  ///
  ///This function returns a [CCError] if not successful.
  Future<Either<CCError, String>> setApiUrl(String customerId) async {
    try {
      final apiUrl = await _authenticationService.getSetApiUrl(customerId);
      await _authenticationDatabase.addApiUrl(apiUrl);
      return right(apiUrl);
    } on Exception catch (e) {
      final error = ExcepetionHandler.handleException(exception: e);
      return left(error);
    }
  }

  ///This function authorises the user using their email and password.
  ///
  ///This function either returns the customer id to indicate successful authorisation
  /// or [CCError] to indicate an that an error had occured during execution.
  Future<Either<CCError, LoginData>> loginUserWithPassword(
    String email,
    String password,
    bool rememberMe,
    String customerId,
  ) async {
    // if (kDebugMode) return right(true);
    try {
      //Retrieve the access token from the server
      final accessToken = await _authenticationService
          .authoriseUserWithPassword(email: email, password: password);

      //Return an error if the access token is null
      if (accessToken == null) return const Left(CCError());

      //Save access token to secure storage for later use
      await _secureStorageService.storeAccessToken(
        accessTokenProvider: AccessTokenProvider.crisesControl,
        value: accessToken.accessToken,
      );

      var verifyResult = await verifyLogin();
      //If user has enabled remeber me save credentials in local encrypted database
      if (rememberMe) {
        verifyResult.fold(
          (error) async {
            var authenticationCredentials = AuthenticationCredentials(
              email,
              password,
              customerId.toLowerCase(),
              true,
              '',
              '',
            );
            await _authenticationDatabase
                .addAuthenticationCredentials(authenticationCredentials);
          },
          (companyData) async {
            var authenticationCredentials = AuthenticationCredentials(
              email,
              password,
              customerId.toLowerCase(),
              true,
              companyData.companyName,
              companyData.companyLoginLogo,
            );
            await _authenticationDatabase
                .addAuthenticationCredentials(authenticationCredentials);
          },
        );
      } else {
        _authenticationDatabase.removeAuthenticationCredentials(
          customerId,
          email,
        );
      }
      await setLoggedInFlag();
      return verifyResult;
    } on DioError catch (e) {
      if (e.response != null) {
        if (e.response?.statusCode == 401) {
          return const Left(CCError.incorrectCredentials);
        }
      }
      return const Left(CCError());
    } on ServerException {
      //If the authentication service does not an successfull response
      return const Left(CCError());
    } on SocketException {
      //If the user has no connection to the internet
      //prefer this way of checking for no connectivity
      // as packages,only provides information if there is a network connection,
      // but not if the network is connected to the Internet
      return const Left((CCError.noConnectivityError));
    } on Exception catch (e) {
      log(e.toString());
      //Handle generic excepetions
      return const Left(CCError());
    }
  }

  Future<void> setLoggedInFlag() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(SharedPrefencesKey.loggedIn, true);
  }

  Future<Either<CCError, LoginData>> verifyLogin() async {
    try {
      final loginVerifyResponse = await _loginRestService.verifyLogin();
      if (loginVerifyResponse?.data != null &&
          loginVerifyResponse?.statusCode == 'OK') {
        await _authenticationDatabase.saveloginData(loginVerifyResponse!.data);
        final userInfoResult = await addUserInfo();
        if (userInfoResult != null) return Left(userInfoResult);

        return Right(loginVerifyResponse.data);
      } else {
        return const Left(CCError());
      }
      //Returns true as the operation was succesful
    } on UnauthorisedException catch (e) {
      //If the authentication service returned 401 (Unauthorised)
      return Left(CCError(errorTitle: e.errorTitle, errorId: e.errorId));
    } on ServerException {
      //If the authentication service does not an successfull response
      return const Left(CCError());
    } on SocketException {
      //If the user has no connection to the internet
      //prefer this way of checking for no connectivity
      // as packages,only provides information if there is a network connection,
      // but not if the network is connected to the Internet
      return const Left((CCError.noConnectivityError));
    } on Exception {
      //Handle generic excepetions

      return const Left(CCError());
    }
  }

  Future<Either<CCError, String?>> requestOTPForPasswordReset(
      String oldPassword, String newPassword) async {
    // if (kDebugMode) return right(true);
    try {
      final restCredentials =
          await _authenticationDatabase.retrieveRestCredentials();
      final response = await _loginRestService.requestOTPForPasswordReset(
        accessToken: restCredentials.accessToken,
        userId: restCredentials.loginData.userId,
        oldPassword: oldPassword,
        newPassword: newPassword,
      );
      if (response != null) {
        return Right(response.message);
      }
      return const Left(CCError());
      //Returns true as the operation was succesful
    } on UnauthorisedException catch (e) {
      //If the authentication service returned 401 (Unauthorised)
      return Left(CCError(errorTitle: e.errorTitle, errorId: e.errorId));
    } on ServerException {
      //If the authentication service does not an successfull response
      return const Left(CCError());
    } on SocketException {
      //If the user has no connection to the internet
      //prefer this way of checking for no connectivity
      // as packages,only provides information if there is a network connection,
      // but not if the network is connected to the Internet
      return const Left((CCError.noConnectivityError));
    } on Exception {
      //Handle generic excepetions
      return const Left(CCError());
    }
  }


  Future<Either<CCError, String>> forgotPassword( 
    String customerId, String email) async {
    var restCredentials =
        await _authenticationDatabase.retrieveRestCredentials();

    try {
      Map<String, dynamic> data = {
  "customerid": customerId,
  "email": email,
};

      final response = await _loginRestService.forgot_password(
        accessToken: restCredentials.accessToken,
       customerid:customerId,
       email:email
      );

      return const Right('test');
    } on UnauthorisedException {
      return const Left(CCError.unauthorisedError);
    } on SocketException {
      //If the user has not got a connection to the internet
      return const Left(CCError.noConnectivityError);
    } on ServerException {
      return const Left(CCError());
    } on Exception {
      return const Left(CCError());
    }
  }


  Future<Either<CCError, String?>> useOTPForPasswordReset(
      String oldPassword, String newPassword, String oTPCode) async {
    // if (kDebugMode) return right(true);
    try {
      final restCredentials =
          await _authenticationDatabase.retrieveRestCredentials();
      final response = await _loginRestService.useOTPForPasswordReset(
        accessToken: restCredentials.accessToken,
        userId: restCredentials.loginData.userId,
        oldPassword: oldPassword,
        newPassword: newPassword,
        oTPCode: oTPCode,
      );
      if (response != null) {
        return Right(response.message);
      }
      return const Left(CCError());
      //Returns true as the operation was succesful
    } on UnauthorisedException catch (e) {
      //If the authentication service returned 401 (Unauthorised)
      return Left(CCError(errorTitle: e.errorTitle, errorId: e.errorId));
    } on ServerException {
      //If the authentication service does not an successfull response
      return const Left(CCError());
    } on SocketException {
      //If the user has no connection to the internet
      //prefer this way of checking for no connectivity
      // as packages,only provides information if there is a network connection,
      // but not if the network is connected to the Internet
      return const Left((CCError.noConnectivityError));
    } on Exception {
      //Handle generic excepetions
      return const Left(CCError());
    }
  }

  Future<Either<CCError, String?>> resendOTPForPasswordReset(
      String oldPassword, String newPassword, String oTPCode) async {
    // if (kDebugMode) return right(true);
    try {
      final restCredentials =
          await _authenticationDatabase.retrieveRestCredentials();
      final response = await _loginRestService.resendOTPForPasswordReset(
        accessToken: restCredentials.accessToken,
        userId: restCredentials.loginData.userId,
        oldPassword: oldPassword,
        newPassword: newPassword,
        oTPCode: oTPCode,
      );
      if (response != null) {
        return Right(response.message);
      }
      return const Left(CCError());
      //Returns true as the operation was succesful
    } on UnauthorisedException catch (e) {
      //If the authentication service returned 401 (Unauthorised)
      return Left(CCError(errorTitle: e.errorTitle, errorId: e.errorId));
    } on ServerException {
      //If the authentication service does not an successfull response
      return const Left(CCError());
    } on SocketException {
      //If the user has no connection to the internet
      //prefer this way of checking for no connectivity
      // as packages,only provides information if there is a network connection,
      // but not if the network is connected to the Internet
      return const Left((CCError.noConnectivityError));
    } on Exception {
      //Handle generic excepetions
      return const Left(CCError());
    }
  }

  Future<Either<CCError, String?>> useOTPFor2FA(
      String oldPassword, String newPassword, String oTPCode) async {
    // if (kDebugMode) return right(true);
    try {
      final restCredentials =
          await _authenticationDatabase.retrieveRestCredentials();
      final response = await _loginRestService.useOTPFor2FA(
        accessToken: restCredentials.accessToken,
        userId: restCredentials.loginData.userId,
        oldPassword: oldPassword,
        newPassword: newPassword,
        oTPCode: oTPCode,
      );
      if (response != null) {
        return Right(response.message);
      } else {
        return const Left(CCError());
      }
      //Returns true as the operation was succesful
    } on UnauthorisedException catch (e) {
      //If the authentication service returned 401 (Unauthorised)
      return Left(CCError(errorTitle: e.errorTitle, errorId: e.errorId));
    } on ServerException {
      //If the authentication service does not an successfull response
      return const Left(CCError());
    } on SocketException {
      //If the user has no connection to the internet
      //prefer this way of checking for no connectivity
      // as packages,only provides information if there is a network connection,
      // but not if the network is connected to the Internet
      return const Left((CCError.noConnectivityError));
    } on Exception {
      //Handle generic excepetions
      return const Left(CCError());
    }
  }

  Future<CCError?> addUserInfo() async {
    var platform = Platform.isIOS ? 'IOS' : 'Android';
    final restCredentials =
        await _authenticationDatabase.retrieveRestCredentials();

    try {
      final userInfo = await _loginRestService.getUserInfo(
        accessToken: restCredentials.accessToken,
        language: restCredentials.loginData.userLanguage,
        deviceType: platform,
      );
      if (userInfo != null) {
        await _authenticationDatabase.saveUserInfo(userInfo);
        return null;
      } else {
        return const CCError();
      }
    } on UnauthorisedException {
      return CCError.unauthorisedError;
    } on ServerException {
      return const CCError();
    } on SocketException {
      return CCError.noConnectivityError;
    } on Exception catch (e) {
      log(e.toString());
      return const CCError();
    }
  }

  AuthenticationCredentials getAuthenticationCredentials(String customerId) {
    try {
      return _authenticationDatabase
          .retrieveAuthenticationCredentials(customerId.toLowerCase())
          .first;
    } on StateError {
      return AuthenticationCredentials('', '', '', false, '', '');
    }
  }

  List<AuthenticationCredentials> getAuthenticationCredentialsBiometrics() {
    return _authenticationDatabase
        .retrieveAuthenticationCredentials()
        .where((x) => x.rememberMe)
        .toList();
  }

  authenticateWithOkta() async {
    //JWT token
    var token = await _oAuthSevrice.authenticateWithOkta(
      clientId: OAuthConfigurations.oktaClientId,
    );
    if (kDebugMode) {
      print(token);
    }
  }

  authenticateWithMicrosoft() async {
    //JWT token
    var token = await _oAuthSevrice.authenticateWithMicrosoft(
      clientId: OAuthConfigurations.azureClientId,
    );
    if (kDebugMode) {
      print(token);
    }
  }
}
