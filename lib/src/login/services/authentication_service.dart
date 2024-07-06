import 'dart:io';
import 'package:crises_control/src/core/constants.dart';
import 'package:crises_control/src/core/errors/exceptions.dart';
import 'package:crises_control/src/core/models/access_token.dart';
import 'package:crises_control/src/core/services/base_rest_service.dart';
import 'package:crises_control/src/core/utils/encryption.dart';
import 'package:crises_control/src/login/models/api_url.dart';
import 'package:http/http.dart' as http;

class AuthenticationService extends BaseRestService {
  AuthenticationService(this.client);
  final http.Client client;

  ///This method retrieves the correct API url for the given customer id.
  ///
  ///This method returns the API url as a string.
  Future<String> getSetApiUrl(String customerId) async {
    const baseUrl = RestServiceConstants.genericApiUrl;
    const endPoint = ApiEndPoints.getCompanyApi;

    EncryptionHelper.encryptAES(customerId);
    final encryptedCustomerId = EncryptionHelper.encrypted?.base64;

    final requestBody = <String, String?>{
      'CustomerId': "JCZUreaoL/OVUxilJgE30eqi3PwoNLihbrW9g2NJwIQ=",
      'ApiVersion': CrisesControlVersions.apiVersion,
      'AppVersion': CrisesControlVersions.appVersion,
      'Platform': Platform.operatingSystem.toUpperCase(),
      'ActionSource': 'LOGIN'
    };

    final response = await sendHttpRequest(
      accessToken: null,
      requiresAccessToken: false,
      baseUrl: baseUrl,
      controller: ApiContrtollers.company,
      endPoint: '/$endPoint',
      httpRequestMethod: HttpRequestMethod.post,
      requestBody: requestBody,
      contentType: RestContentType.applicationJson,
    );

    final apiUrlResponse = ApiUrl.fromJson(response);

    if (apiUrlResponse.apiUrl != null) {
      return apiUrlResponse.apiUrl!;
    }

    //decode json response as a string
    if (apiUrlResponse.message != null) {
      throw ApiException(
        errorCode: '',
        errorId: 0,
        message: apiUrlResponse.message!,
      );
    }
    throw Exception;
  }

  ///Authorises the user using email and password and returns a bearer token if successful
  Future<AccessToken?> authoriseUserWithPassword({
    required String email,
    required String password,
  }) async {
    final bodyFields = {
      'grant_type': 'password',
      'client_id': RestServiceConstants.clientId,
      'client_secret': RestServiceConstants.clientSecret,
      'username': email,
      'password': password
    };

    final response = await sendHttpRequest(
      requiresAccessToken: false,
      accessToken: null,
      baseUrl: RestServiceConstants.devauthUrl,
      controller: ApiContrtollers.connect,
      endPoint: '/token',
      httpRequestMethod: HttpRequestMethod.post,
      contentType: RestContentType.applicationFormUrlEncoded,
      requestBody: bodyFields,
    );

    return AccessToken.fromJson(response);
  }
}
