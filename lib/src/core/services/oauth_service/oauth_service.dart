import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_web_auth_2/flutter_web_auth_2.dart';
import 'package:pkce/pkce.dart';
import 'oauth_configurations.dart';

class OAuthSevrice {
  ///Authenticates a user using Azure AD
  ///Requires a client id as a [String]
  ///Returns a JWT as an optional future [Map]
  // ignore: body_might_complete_normally_nullable
  Future<Map<String, dynamic>?> authenticateWithMicrosoft({
    required String clientId,
  }) async {
    final url = Uri.https(
      'login.microsoftonline.com',
      OAuthConfigurations.azureAuthority,
      {
        'scope': 'User.Read',
        'response_type': 'code',
        'client_id': clientId,
        'redirect_uri': OAuthConfigurations.azureRedirect,
      },
    );

    try {
      //Authentication result
      final authResult = await FlutterWebAuth2.authenticate(
        url: url.toString(),
        callbackUrlScheme: OAuthConfigurations.azureRedirectScheme,
      );

      var token = Uri.parse(authResult).queryParameters['code'];
      //JWT Token
      if (token != null) {
        try {
          Map<String, dynamic> jwtToken = parseJwt(token);
          return jwtToken;
        } on FormatException {
          return null;
        }
      }
      //JWT
    } on PlatformException {
      //Occurs when a user cancells the authorisation process by dismissing the webview
      return null;
    }
  }

  ///Authenticates a user using Okta
  /// Requires a client id as a [String]
  ///Returns a JWT as an optional future [Map]
  Future<Map<String, dynamic>?> authenticateWithOkta({
    required String clientId,
  }) async {
    //Okta authorisation configurations
    final pkcePair = PkcePair.generate(length: 32);
    var organizationUrl = OAuthConfigurations.organizationUrl;
    var responseType = OAuthConfigurations.responseType;
    var callback = OAuthConfigurations.oktaCallback;
    var clientId = OAuthConfigurations.oktaClientId;
    var codeChallengeMethod = OAuthConfigurations.codeChallengeMethod;
    var oktaCallbackScheme = OAuthConfigurations.oktaCallbackScheme;

    //Authorisation url
    String authUrl =
        "https://$organizationUrl/oauth2/default/v1/authorize?response_type=$responseType&scope=openid%20profile&redirect_uri=$callback&client_id=$clientId&state=tate&code_challenge${pkcePair.codeChallenge}&code_challenge_method=$codeChallengeMethod&nonce=${pkcePair.codeVerifier}";

    try {
      //The authorisation result
      final authResult = await FlutterWebAuth2.authenticate(
        url: authUrl,
        callbackUrlScheme: oktaCallbackScheme,
      );

      var token = Uri.parse(authResult).queryParameters['id_token'];
      //JWT Token
      if (token != null) {
        try {
          Map<String, dynamic> jwtToken = parseJwt(token);
          return jwtToken;
        } on FormatException {
          return null;
        }
      }
    } on PlatformException {
      return null;
    }
    return null;
  }

  Map<String, dynamic> parseJwt(String token) {
    final parts = token.split('.');
    if (parts.length != 3) {
      throw Exception('invalid token');
    }

    final payload = _decodeBase64(parts[1]);
    final payloadMap = json.decode(payload);
    if (payloadMap is! Map<String, dynamic>) {
      throw Exception('invalid payload');
    }

    return payloadMap;
  }

  String _decodeBase64(String str) {
    String output = str.replaceAll('-', '+').replaceAll('_', '/');

    switch (output.length % 4) {
      case 0:
        break;
      case 2:
        output += '==';
        break;
      case 3:
        output += '=';
        break;
      default:
        throw Exception('Illegal base64url string!"');
    }

    return utf8.decode(base64Url.decode(output));
  }
}
