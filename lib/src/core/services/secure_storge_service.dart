import 'dart:convert';
import 'dart:developer' as developer;
import 'package:crises_control/src/core/constants.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive/hive.dart';

enum AccessTokenProvider { crisesControl, azureAD, okta }

///This class is responsible for managing the Secure Storage
class SecureStorageService {
  late FlutterSecureStorage _secureStorage;
  static const String _secureStorageKey = 'encryptionKey';
  SecureStorageService() {
    AndroidOptions getAndroidOptions() => const AndroidOptions(
          encryptedSharedPreferences: true,
        );
    _secureStorage = FlutterSecureStorage(aOptions: getAndroidOptions());
  }

  ///This function creates an encryption key for the local encrypted hive database
  ///
  ///The key is stored using secure storage
  Future<void> createHiveSecureKey() async {
    //! BUG Contains key method in secure storage class always returns true
    //Use read method for now
    //https://github.com/mogol/flutter_secure_storage/issues/338 - change to use contains once stable fix has been released
    try {
      var containsEncryptionKey =
          (await _secureStorage.read(key: _secureStorageKey)) != null;

      //if the key does not exist in secure storage then create it and store it
      if (!containsEncryptionKey) {
        var key = Hive.generateSecureKey();
        await _secureStorage.write(
            key: _secureStorageKey, value: base64UrlEncode(key));
        developer.log('Hive secure key created');
      }
    } catch (e) {
      developer.log(e.toString());
    }
  }

  ///This method returns an optional [Uint8List] be sure to check for null when using
  Future<Uint8List?> retrieveEncryptionKey() async {
    try {
      var encryptionKey = await _secureStorage.read(key: _secureStorageKey);
      if (encryptionKey != null) {
        return base64Url.decode(encryptionKey);
      }
    } catch (e) {
      print(e);
    }

    return null;
  }

  ///Stores access token in secure storage
  ///A [AccessTokenProvider] is required as a parameter
  ///A [String] value is required as a parameter
  Future<void> storeAccessToken({
    required AccessTokenProvider accessTokenProvider,
    required String value,
  }) async {
    var key = '';
    //Set the correct value of the key depending on the accessTokenProvider value
    switch (accessTokenProvider) {
      case AccessTokenProvider.crisesControl:
        key = SecureStorageKeys.crisesControlAccessTokenKey;
        break;
      case AccessTokenProvider.azureAD:
        key = SecureStorageKeys.azureAdAccessTokenKey;
        break;
      case AccessTokenProvider.okta:
        key = SecureStorageKeys.oktaAccessTokenKey;
    }

    //Store the access token
    await _secureStorage.write(key: key, value: value);
  }

  ///Retrieves a access token in secure storage
  ///A [AccessTokenProvider] is required as a parameter
  ///Returns the access token as a [String]
  ///Returns 'NO ACCESS TOKEN' if there is no accessToken for the AccessTokenProvider
  Future<String> retrieveAccessToken({
    required AccessTokenProvider accessTokenProvider,
  }) async {
    var key = '';
    //Set the correct value of the key depending on the accessTokenProvider value
    switch (accessTokenProvider) {
      case AccessTokenProvider.crisesControl:
        key = SecureStorageKeys.crisesControlAccessTokenKey;
        break;
      case AccessTokenProvider.azureAD:
        key = SecureStorageKeys.azureAdAccessTokenKey;
        break;
      case AccessTokenProvider.okta:
        key = SecureStorageKeys.oktaAccessTokenKey;
    }

    //Store the access token
    var accessToken = await _secureStorage.read(key: key);

    if (accessToken != null) {
      //Return the retrieved access token
      return accessToken;
    }

    return 'NO ACCESS TOKEN';
  }
}
