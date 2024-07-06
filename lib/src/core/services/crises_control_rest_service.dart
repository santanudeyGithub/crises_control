import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:crises_control/src/core/constants.dart';
import 'package:crises_control/src/core/errors/exceptions.dart';
import 'package:crises_control/src/core/models/acknowledge_message_body.dart';
import 'package:crises_control/src/core/models/communication_models/cascading_plan_response.dart';
import 'package:crises_control/src/core/models/communication_models/company_comms_response.dart';
import 'package:crises_control/src/core/models/communication_models/message_response.dart';
import 'package:crises_control/src/core/models/department.dart';
import 'package:crises_control/src/core/models/list_models/affected_locations.dart';
import 'package:crises_control/src/core/models/list_models/departments.dart';
import 'package:crises_control/src/core/models/list_models/groups.dart';
import 'package:crises_control/src/core/models/list_models/locations.dart';
import 'package:crises_control/src/core/models/list_models/users.dart';
import 'package:crises_control/src/core/models/message_acknowledge_status_response.dart';
import 'package:crises_control/src/core/models/message_reply_body.dart';
import 'package:crises_control/src/core/models/replies.dart';
import 'package:crises_control/src/core/models/reply_message_response.dart';
import 'package:crises_control/src/core/models/user.dart';
import 'package:crises_control/src/core/services/base_rest_service.dart';
import 'package:crises_control/src/core/utils/enum_helpers.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import 'secure_storge_service.dart';

enum ListApi { location, department, group }

enum DetailApi { user, department }

enum CascadingPlanType { all, ping, incident }

///This service is responsible for common API calls to the Crises Control Core API
class CrisesControlRestService extends BaseRestService {
  CrisesControlRestService(this._client, this._secureStorageService);
  final http.Client _client;
  final SecureStorageService _secureStorageService;

  ///Constructs a url depending on the ListApi supplied
  ///
  ///ListApi - location, department, group
  ///
  ///companyId - The company you want to query the list for
  Uri constructUrlForListAPI({
    required ListApi listApi,
    required int companyId,
  }) {
    const baseUrl = RestServiceConstants.devappsbaseUrl;
    const path = RestServiceConstants.coreApiPath;
    var endPoint = '';

    //Set the endPoint depending on the ListApi supplied
    switch (listApi) {
      case ListApi.location:
        endPoint = ApiEndPoints.location;
        break;
      case ListApi.department:
        endPoint = ApiEndPoints.department;
        break;
      case ListApi.group:
        endPoint = ApiEndPoints.group;
        break;
    }

    //Construct the Url and return it
    return listApi == ListApi.group
        ? Uri.https(baseUrl, '$path/$endPoint/$companyId/0/false')
        : Uri.https(baseUrl, '$path/$endPoint/$companyId/false');
  }

  ///Constructs a url depending on the DetailAPI supplied
  ///
  ///ListApi - location, department, group
  ///
  ///companyId - The company you want to query the list for
  Uri constructUrlForDetailAPI({
    required DetailApi detailApi,
    required int companyId,
    required int id,
  }) {
    const baseUrl = RestServiceConstants.devappsbaseUrl;
    const path = RestServiceConstants.coreApiPath;
    var idParameter = '';
    var endPoint = '';

    //Set the endPoint depending on the ListApi supplied
    switch (detailApi) {
      // case ListApi.location:
      //   endPoint = ApiEndPoints.location;
      //   break;
      // case ListApi.department:
      //   endPoint = ApiEndPoints.department;
      //   break;
      // case ListApi.group:
      //   endPoint = ApiEndPoints.group;
      //   break;
      case DetailApi.user:
        endPoint = ApiEndPoints.user;
        idParameter = 'UserId';
        break;
      case DetailApi.department:
        endPoint = ApiEndPoints.user;
        idParameter = 'DepartmentId';
        break;
    }

    //Set the required id parameter
    Map<String, int> queryParameters = {
      idParameter: id,
      'CompanyId': companyId
    };

    //Construct the Url and return it
    return Uri.https(baseUrl, '$path/$endPoint', queryParameters);
  }

  dynamic parseJsonToList({
    required ListApi listApi,
    required String json,
  }) {
    switch (listApi) {
      case ListApi.location:
        return Locations.fromJson(jsonDecode(json));
      case ListApi.department:
        return Departments.fromJson(jsonDecode(json));
      case ListApi.group:
        return Groups.fromJson(jsonDecode(json));
    }
  }

  dynamic parseJsonToDetail({
    required DetailApi detailApi,
    required String json,
  }) {
    switch (detailApi) {
      case DetailApi.user:
        return (jsonDecode(json) as User);
      case DetailApi.department:
        return (jsonDecode(json) as Department);
    }
  }

  ///ListApi - location, department, group
  ///
  ///companyId - The company you want to query the list for
  ///
  ///Throws [UnauthorisedException] in the case of 401 being returned from API
  ///
  ///Example of how to use:
  /// {@tool snippet}
  /// ```dart
  ///var locations = await getList(12, listApi: ListApi.location, companyId: 1) as List<Location>;
  /// ```
  /// {@end-tool}
  Future<dynamic> getList({
    required ListApi listApi,
    required int companyId,
  }) async {
    Uri url = constructUrlForListAPI(
      listApi: listApi,
      companyId: companyId,
    );

    var accessToken = await _secureStorageService.retrieveAccessToken(
      accessTokenProvider: AccessTokenProvider.crisesControl,
    );

    var requestHeaders = {
      'Authorization': 'Bearer $accessToken',
      'Content-Type': 'application/json'
    };

    final response = await _client.get(
      url,
      headers: requestHeaders,
    );

    if (kDebugMode) print(response);
    if (response.statusCode == 200) {
      //Parse the response into a list depending on the ListApi supplied and the return it
      return parseJsonToList(listApi: listApi, json: response.body);
    }

    if (response.statusCode == 401) {
      throw UnauthorisedException();
    }

    return null;
  }

  ///Retrieves all users for the specified required company id
  ///Returns an optional list of [User]
  Future<Users?> getAllUsers({
    required int companyId,
    bool activeOnly = true,
    bool skipInactive = true,
    bool skipDeleted = true,
    bool keyHolderOnly = false,
  }) async {
    const baseUrl = RestServiceConstants.devappsbaseUrl;
    const path = RestServiceConstants.coreApiPath;
    const endPoint = ApiEndPoints.user;

    //Constructs the url
    Uri url = Uri.https(
      baseUrl,
      '$path/$endPoint/$companyId/$skipDeleted/$activeOnly/$skipInactive/$keyHolderOnly',
    );

    //Retrieves crises control access token from secure storage
    var accessToken = await _secureStorageService.retrieveAccessToken(
      accessTokenProvider: AccessTokenProvider.crisesControl,
    );

    //Sets the access token in the request header
    var requestHeaders = {
      'Authorization': 'Bearer $accessToken',
      'Content-Type': 'application/json'
    };

    //Performs http get request
    final response = await _client.get(
      url,
      headers: requestHeaders,
    );

    if (kDebugMode) print(response);
    if (response.statusCode == 200) {
      //Parses the response into a list of user
      return Users.fromJson(jsonDecode(response.body));
    }

    //The API has returned 401 meaning that the user is unauthorised
    //Check validity for access token and if invalid request the user to relogin
    if (response.statusCode == 401) {
      throw UnauthorisedException();
    }

    //Return null in the case of not retriving any users from the api
    return null;
  }

  ///Retrieves details for specified Detail Api
  ///
  ///DetailApi - user, department
  ///
  ///Example of how to use:
  /// {@tool snippet}
  /// ```dart
  ///var userDetails = await getDetails(DetailApi.user, 12, companyId: 1) as UserDetail;
  /// ```
  /// {@end-tool}
  Future<dynamic> getDetails({
    required DetailApi detailApi,
    required int companyId,
    required int id,
  }) async {
    Uri url = constructUrlForDetailAPI(
      detailApi: detailApi,
      id: id,
      companyId: companyId,
    );

    var accessToken = _secureStorageService.retrieveAccessToken(
      accessTokenProvider: AccessTokenProvider.crisesControl,
    );

    var requestHeaders = {
      'Authorization': 'Bearer $accessToken',
      'Content-Type': 'application/json'
    };

    final response = await _client.get(
      url,
      headers: requestHeaders,
    );

    if (kDebugMode) print(response);
    if (response.statusCode == 200) {
      return parseJsonToDetail(detailApi: detailApi, json: response.body);
    }

    if (response.statusCode == 401) {
      throw UnauthorisedException();
    }

    return null;
  }

  //Reply to message
  Future<ReplyMessageResponse?> replyToMessage({
    required String accessToken,
    required MessageReplyBody messageReplyBody,
  }) async {
    final response = await sendHttpRequest(
      accessToken: accessToken,
      controller: ApiContrtollers.messaging,
      endPoint: '/ReplyToMessage',
      requestBody: messageReplyBody.toJson(),
      httpRequestMethod: HttpRequestMethod.post,
    );
    return ReplyMessageResponse.fromJson(response);
  }

  Future<MessageAcknowledgeStatusResponse?> getAcknowledgeStatusForMessage({
    required String accessToken,
    required int messageId,
    int messageAckStatus = 1,
  }) async {
    final response = await sendHttpRequest(
      accessToken: accessToken,
      controller: ApiContrtollers.reporting,
      endPoint: '/GetIncidentMessageAck/$messageId/$messageAckStatus/1/APP',
      httpRequestMethod: HttpRequestMethod.get,
    );

    return MessageAcknowledgeStatusResponse.fromJson(response);
  }

  Future<void> renotifyUnacknowledgedUsers({
    required String accessToken,
    required MessageReplyBody messageReplyBody,
  }) async {
    final response = sendHttpRequest(
      accessToken: accessToken,
      controller: ApiContrtollers.messaging,
      endPoint: '/Renotify',
      requestBody: messageReplyBody.toJson(),
      httpRequestMethod: HttpRequestMethod.post,
    );

    log(response.toString());
  }

  Future<void> getMessageAttachment({
    required int messageAttachmentId,
    required String accessToken,
  }) async {
    final response = sendHttpRequest(
      accessToken: accessToken,
      endPoint: '/GetAttachment/$messageAttachmentId',
      httpRequestMethod: HttpRequestMethod.get,
    );

    log(response.toString());
  }

  Future<void> acknowledgeMessage({
    required int msgListId,
    required String accessToken,
    required AcknowledgeMessageBody acknowledgeMessageBody,
  }) async {
    final response = await sendHttpRequest(
      accessToken: accessToken,
      controller: ApiContrtollers.messaging,
      endPoint: '/MessageAcknowledge/$msgListId',
      httpRequestMethod: HttpRequestMethod.post,
      requestBody: acknowledgeMessageBody.toJson(),
    );

    log(response.toString());
  }

  ///Retrieves all affected location
  ///Returns [AffectedLocations]
  Future<AffectedLocations> getGetAffectedLocations() async {
    var accessToken = await _secureStorageService.retrieveAccessToken(
      accessTokenProvider: AccessTokenProvider.crisesControl,
    );

    var data = await sendHttpRequest(
      accessToken: accessToken,
      controller: ApiEndPoints.incident,
      endPoint: '/GetAffectedLocations/AFFECTED',
      httpRequestMethod: HttpRequestMethod.get,
    );
    return AffectedLocations.fromJson(data);
  }

  Future<RepliesResponse?> getRepliesForMessage({
    required int parentId,
    required String accessToken,
  }) async {
    final response = await sendHttpRequest(
      accessToken: accessToken,
      controller: ApiContrtollers.messaging,
      endPoint: '/GetReplies/$parentId',
      httpRequestMethod: HttpRequestMethod.get,
    );

    return RepliesResponse.fromJson(response);
  }

  Future<CompanyCommsResponse?> getCompanyComms({
    required String accessToken,
    required int companyId,
  }) async {
    final response = await sendHttpRequest(
      accessToken: accessToken,
      controller: ApiContrtollers.company,
      endPoint: '/${ApiEndPoints.getCompanyComms}/$companyId',
      httpRequestMethod: HttpRequestMethod.get,
    );

    return CompanyCommsResponse.fromJson(response);
  }

  Future<CascadingPlanResponse?> getCascadingPlans({
    required String accessToken,
    required CascadingPlanType cascadingPlanType,
  }) async {
    var cascadingPlan =
        EnumHelpers.cascadingPlanTypeToString(cascadingPlanType);

    final response = await sendHttpRequest(
      accessToken: accessToken,
      controller: ApiContrtollers.companyParameters,
      endPoint: '/${ApiEndPoints.getCascading}/0/$cascadingPlan',
      httpRequestMethod: HttpRequestMethod.get,
    );

    return CascadingPlanResponse.fromJson(response);
  }

  Future<MessageResponse?> getMessageResponses({
    required String accessToken,
    required String messageType,
    required int status,
  }) async {
    final response = await sendHttpRequest(
      accessToken: accessToken,
      controller: ApiContrtollers.messaging,
      endPoint: '/GetMessageResponses/$messageType/$status',
      httpRequestMethod: HttpRequestMethod.get,
    );

    return MessageResponse.fromJson(response);
  }

  Future<void> uploadAttachment({
    required File attachment,
    required String accessToken,
  }) async {
    final response = sendFileHttpRequest(
      accessToken: accessToken,
      endPoint: '/UploadAttachment',
      httpRequestMethod: HttpRequestMethod.post,
      file: attachment,
    );

    log(response.toString());
  }

  //Retrieves social intergration for the users company
  Future<dynamic> getSocialIntergration({
    required String accessToken,
    required int companyId,
  }) async {
    final response = sendHttpRequest(
      accessToken: accessToken,
      controller: ApiContrtollers.company,
      endPoint: '${ApiEndPoints.getSocialIntegration}/$companyId',
      httpRequestMethod: HttpRequestMethod.get,
    );

    log(response.toString());
  }
}
