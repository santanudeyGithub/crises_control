import 'dart:developer' as developer;

import 'package:crises_control/src/companies/models/company.dart';
import 'package:crises_control/src/core/errors/exception_handler.dart';
import 'package:crises_control/src/core/models/access_token.dart';
import 'package:crises_control/src/core/models/authentication_credentials.dart';
import 'package:crises_control/src/core/models/login_data.dart';
import 'package:crises_control/src/core/models/rest_credentials.dart';
import 'package:crises_control/src/core/models/user_info.dart';
import 'package:crises_control/src/core/services/secure_storge_service.dart';
import 'package:crises_control/src/home/models/app_home.dart';
import 'package:dartz/dartz.dart';
import 'package:hive/hive.dart';

///This class is responsible for storing all the properties related to authentication and login
class AuthenticationDatabaseService {
  AuthenticationDatabaseService(this._secureStorageService) {
    init();
  }
  final SecureStorageService _secureStorageService;
  final RestCredentials? _restCredentials = null;
  //This box is encrypted using AES 256.
  late Box _authenticationBox;
  //This box is encrypted using AES 256 and for storing user credentials
  late Box<AuthenticationCredentials> _authenticationCredentialsBox;
  late Box<UserInfo> _userInfoBox;
  //This box is encrypted using AES 256 and for storing login data
  //Key for the authentication box.
  static const _authenticationBoxKey = 'authentication';
  static const _userInfoBoxKey = 'userInfoBoxKey';
  static const _authenticationCredentialsBoxKey = 'authenticationCredentials';
  //Keys for the local hive database.
  static const _apiUrlKey = 'apiUrl';
  static const _loginDataKey = 'loginData';
  static const _homeDataKey = 'homeData';
  // static const _authenticationCredentials = 'authenticationCredentials';
  //Initialse the hive database for authentication.
  Future<void> init() async {
    //This register custom dart objects so you can store them in hive db.
    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(AccessTokenAdapter());
    }

    if (!Hive.isAdapterRegistered(1)) {
      Hive.registerAdapter(AuthenticationCredentialsAdapter());
    }

    if (!Hive.isAdapterRegistered(4)) {
      Hive.registerAdapter(LoginDataAdapter());
    }

    //Register security items first as it is a child of the user info.
    if (!Hive.isAdapterRegistered(7)) {
      Hive.registerAdapter(SecurityItemAdapter());
    }

    if (!Hive.isAdapterRegistered(6)) {
      Hive.registerAdapter(UserInfoAdapter());
    }

    //AppHome related adapters
    if (!Hive.isAdapterRegistered(15)) {
      Hive.registerAdapter(UsefulTextAdapter());
    }

    if (!Hive.isAdapterRegistered(14)) {
      Hive.registerAdapter(CompanyParamAdapter());
    }

    if (!Hive.isAdapterRegistered(13)) {
      Hive.registerAdapter(PlatformAdapter());
    }

    if (!Hive.isAdapterRegistered(12)) {
      Hive.registerAdapter(AppIconUrlAdapter());
    }

    if (!Hive.isAdapterRegistered(11)) {
      Hive.registerAdapter(AppDataAdapter());
    }

    if (!Hive.isAdapterRegistered(10)) {
      Hive.registerAdapter(AppHomeAdapter());
    }
    await _secureStorageService.createHiveSecureKey();

    //retrieves the key from the secure storage service.
    var encryptionKey = await _secureStorageService.retrieveEncryptionKey();

    //check the encryption key is not null before opening the box with it.
    if (encryptionKey != null) {
      _authenticationBox = await Hive.openBox(
        _authenticationBoxKey,
        encryptionCipher: HiveAesCipher(encryptionKey),
      );
      _authenticationCredentialsBox =
          await Hive.openBox<AuthenticationCredentials>(
        _authenticationCredentialsBoxKey,
        encryptionCipher: HiveAesCipher(encryptionKey),
      );

      _userInfoBox = await Hive.openBox(
        _userInfoBoxKey,
        encryptionCipher: HiveAesCipher(encryptionKey),
      );
    }
    developer.log('Authentication database initialsed');
  }

  ///Adds the login data to hive databsase.
  Future saveloginData(LoginData loginData) async {
    await _authenticationBox.put(_loginDataKey, loginData);
  }

  ///Get the login data from hive databsase.
  LoginData retrieveloginData() {
    return _authenticationBox.get(_loginDataKey);
  }

  Future saveHomeData(AppHome homeData) async {
    await _authenticationBox.put(_homeDataKey, homeData);
  }

  AppHome? retrieveHomeData() {
    return _authenticationBox.get(_homeDataKey);
  }

  Future removeHomeData() async {
    await _authenticationBox.delete(_homeDataKey);
  }

  ///Retrieves the companyId
  int retrieveCompanyId() {
    var loginData = retrieveloginData();
    return loginData.companyId;
  }

  ///Retrieve the user id
  int retrieveUserId() {
    var loginData = retrieveloginData();
    return loginData.userId;
  }

  ///Remove the login data from hive databsase.
  Future removeLoginData() async {
    await _authenticationBox.delete(_loginDataKey);
  }

  ///Adds the api url to the hive databsase.
  addApiUrl(String apiUrl) async {
    //The first parameter is the key, the second parameter is the value

    await _authenticationBox.put(_apiUrlKey, apiUrl);
  }

  ///Returns the api url as a string which  is stored in the hive database.
  ///
  ///If there is no api url in the hive database it will return an empty string.
  String retrieveApiUrl() {
    final String apiUrl = _authenticationBox.get(_apiUrlKey);
    if (apiUrl.isEmpty) return '';
    return apiUrl;
  }

  ///Adds the users authentication credentials to the local encrypted hive database
  addAuthenticationCredentials(
    AuthenticationCredentials authenticationCredentials,
  ) async {
    //Deletes any old credentials that match the same customer id
    removeAuthenticationCredentials(
      authenticationCredentials.customerId,
      authenticationCredentials.email,
    );

    await _authenticationCredentialsBox.add(
      authenticationCredentials,
    );
  }

  ///Removes the saved authorisation credentials given the customer id and email
  removeAuthenticationCredentials(String customerId, String email) {
    var credentials = _authenticationCredentialsBox.toMap();
    credentials.forEach(
      (key, value) async {
        if (value.customerId.toLowerCase() == customerId.toLowerCase() &&
            value.email.toLowerCase() == email.toLowerCase()) {
          await _authenticationCredentialsBox.delete(key);
        }
      },
    );
  }

  Future<void> saveUserInfo(UserInfo userInfo) async {
    await _userInfoBox.clear();
    await _userInfoBox.add(userInfo);
  }

  UserInfo? retrieveUserInfo() {
    try {
      var userInfo = _userInfoBox.getAt(0);
      if (userInfo != null) return userInfo;
    } on Exception catch (e) {
      developer.log(e.toString());
    }
    return null;
  }

  ///Retrieves the authentication credentials and returns them in a List.
  ///
  ///If a customer id is specified it will return the first credentials that match that customer id.
  ///If No customer id is passed as a parameter then it will return all authentication credentials.
  List<AuthenticationCredentials> retrieveAuthenticationCredentials([
    String? customerId,
  ]) {
    if (customerId != null) {
      final List<AuthenticationCredentials> authenticationCredentials = [];
      try {
        authenticationCredentials.add(
          _authenticationCredentialsBox.values.firstWhere(
            (element) => element.customerId == customerId,
          ),
        );
      } on StateError {
        return authenticationCredentials;
      }

      return authenticationCredentials;
    }

    try {
      final authenticationCredentials = _authenticationCredentialsBox.values;
      return authenticationCredentials.toList();
    } on StateError {
      return [];
    }
  }

  //Retrieve users companies
  List<Company> retrieveUserCompanies() {
    List<Company> companies = [];
    var data = retrieveAuthenticationCredentials(null);

    for (var item in data) {
      companies.add(
        Company(
          item.companyName,
          item.customerId,
          item.companyLogo,
        ),
      );
    }

    return companies;
  }

  Future<RestCredentials> retrieveRestCredentials() async {
    if (_restCredentials != null) {
      return _restCredentials!;
    }

    var loginData = retrieveloginData();
    var accessToken = await _secureStorageService.retrieveAccessToken(
      accessTokenProvider: AccessTokenProvider.crisesControl,
    );
    return RestCredentials(accessToken, loginData);
  }

  clearDatabase() async {
    //! DO NOT CLEAR THE AUTHENTICATION CREDETIALS BOX
    await _authenticationBox.clear();
    await _userInfoBox.clear();
  }
}
