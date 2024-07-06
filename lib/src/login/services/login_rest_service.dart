// ignore_for_file: unused_field

import 'dart:convert';

import 'package:crises_control/src/core/constants.dart';
import 'package:crises_control/src/core/errors/exceptions.dart';
import 'package:crises_control/src/core/models/user_info.dart';
import 'package:crises_control/src/core/services/base_rest_service.dart';
import 'package:crises_control/src/core/services/secure_storge_service.dart';
import 'package:crises_control/src/login/models/login_verify_response.dart';
import 'package:crises_control/src/core/services/device_service.dart';
import 'package:crises_control/src/login/models/password_otp_response.dart';
import 'package:crises_control/src/login/services/authentication_database_service.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;

//import 'package:crises_control/src/core/constants.dart';
//import 'package:crises_control/src/core/errors/exceptions.dart';
//import 'package:crises_control/src/core/services/secure_storge_service.dart';
//import 'package:crises_control/src/login/models/login_verify_response.dart';

class LoginRestService extends BaseRestService {
  LoginRestService(this._client, this._secureStorageService,
      this._authenticationDatabaseService, this._deviceService);
  final http.Client _client;
  final SecureStorageService _secureStorageService;
  final AuthenticationDatabaseService _authenticationDatabaseService;
  final DeviceService _deviceService;

  Future<LoginVerifyResponse?> verifyLogin() async {
    const baseUrl = RestServiceConstants.devappsAppUrl;
    const endPoint = ApiEndPoints.verifyLogin;

    Uri url = Uri.parse("$baseUrl/$endPoint");

    var accessToken = await _secureStorageService.retrieveAccessToken(
      accessTokenProvider: AccessTokenProvider.crisesControl,
    );

    //Sets the access token in the request header
    var requestHeaders = {
      'Authorization': 'Bearer $accessToken',
      'Content-Type': 'application/json'
    };

    var requestBody = jsonEncode(<String, String>{
      'DeviceModel': await _deviceService.getDeviceModel(),
      'DeviceType': DeviceService.deviceType(),
      'DeviceSerial': await _deviceService.getDeviceSerial(),
      'PushToken':
          '463ce90cff117364c0875eb71c7777bc5024ba6e022b92d190dbc344cfcc3483',
      'DeviceOs': '9.3.2',
      'Latitude': '',
      'Longitude': '',
    });

    final response = await _client.post(
      url,
      headers: requestHeaders,
      body: requestBody,
    );

    if (response.statusCode == 200) {
      //Parses the response into a list of user
      var json = jsonDecode(response.body);
      return LoginVerifyResponse.fromJson(json);
    }

    //The API has returned 401 meaning that the user is unauthorised
    //Check validity for access token and if invalid request the user to relogin
    if (response.statusCode == 401) {
      throw UnauthorisedException();
    }

    return null;
  }

  Future<void> forgot_password({
    required String accessToken,
    required String customerid,
    required String email,
  }) async {
    Map<String, dynamic> data = {
      "CustomerId": customerid,
      "EmailId": email,
      "Return": "",
      "OTPMessage": ""
    };
    final response = await sendHttpRequest(
      accessToken: accessToken,
      controller: ApiContrtollers.user,
      endPoint: '/ForgotPassword',
      httpRequestMethod: HttpRequestMethod.post,
      requestBody: data,
    );

    //log(response.toString());
  }

  Future<PasswordOtpResponse?> requestOTPForPasswordReset({
    required String accessToken,
    required int userId,
    required String oldPassword,
    required String newPassword,
  }) async {
    return sendPasswordOTP(
      accessToken: accessToken,
      userId: userId,
      oldPassword: oldPassword,
      newPassword: newPassword,
      action: "confirm",
      source: "RESET",
    );
  }

  Future<PasswordOtpResponse?> useOTPForPasswordReset({
    required String accessToken,
    required int userId,
    required String oldPassword,
    required String newPassword,
    required String oTPCode,
  }) async {
    return sendPasswordOTP(
      accessToken: accessToken,
      userId: userId,
      oldPassword: oldPassword,
      newPassword: newPassword,
      oTPCode: oTPCode,
      action: "otpcheck",
      source: "RESET",
    );
  }

  Future<PasswordOtpResponse?> resendOTPForPasswordReset({
    required String accessToken,
    required int userId,
    required String oldPassword,
    required String newPassword,
    required String oTPCode,
  }) async {
    return sendPasswordOTP(
      accessToken: accessToken,
      userId: userId,
      oldPassword: oldPassword,
      newPassword: newPassword,
      oTPCode: oTPCode,
      action: "otpresend",
      source: "RESET",
    );
  }

  Future<PasswordOtpResponse?> useOTPFor2FA({
    required String accessToken,
    required int userId,
    required String oldPassword,
    required String newPassword,
    required String oTPCode,
  }) async {
    return sendPasswordOTP(
      accessToken: accessToken,
      userId: userId,
      oldPassword: oldPassword,
      newPassword: newPassword,
      oTPCode: oTPCode,
      action: "VERIFYCODE",
      source: "LOGIN",
    );
  }

  Future<PasswordOtpResponse?> sendPasswordOTP({
    required String accessToken,
    required int userId,
    required String oldPassword,
    required String newPassword,
    String oTPCode = "",
    required String action,
    required String source,
  }) async {
    var requestBody = jsonEncode(<String, dynamic>{
      "Action": action,
      "UserID": userId,
      "OldPassword": oldPassword,
      "Password": newPassword,
      "OTPCode": oTPCode,
      "Return": "bool",
      "OTPMessage": "",
      "Source": source,
      "Method": "TEXT", //RESET/LOGIN
    });
    var response = await sendHttpRequest(
      accessToken: accessToken,
      endPoint: ApiEndPoints.sendPasswordOTP,
      httpRequestMethod: HttpRequestMethod.post,
      requestBody: requestBody,
    );
    return PasswordOtpResponse.fromJson(response);
  }

  Future<UserInfo?> getUserInfo({
    required String accessToken,
    required String language,
    required String deviceType,
  }) async {
    var requestBody = FormData.fromMap({
      'IPAddress': '1',
      'Language': language,
      'DeviceType': deviceType,
    });

    final response = await sendHttpRequest(
      accessToken: accessToken,
      controller: ApiContrtollers.user,
      endPoint: '/GetLoggedinUserInfo',
      requestBody: requestBody,
      httpRequestMethod: HttpRequestMethod.post,
      contentType: 'multipart/form-data',
    );

    return UserInfo.fromJson(response);
  }
}
