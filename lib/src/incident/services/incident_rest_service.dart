import 'package:crises_control/src/core/constants.dart';
import 'package:crises_control/src/core/services/base_rest_service.dart';
import 'package:crises_control/src/incident/models/active_incident.dart';
import 'package:crises_control/src/incident/models/all_active_incident.dart';
import 'package:crises_control/src/incident/models/incident_detail.dart';
import 'package:crises_control/src/incident/models/incident_list_model.dart';
import 'package:crises_control/src/incident/models/incident_message_details.dart';
import 'package:crises_control/src/incident/models/launch_incident_request_body.dart';

class IncidentRestService extends BaseRestService {
  static const controller = ApiEndPoints.incident;

  Future<IncidentListModel?> getAllCompanyIncident({
    required int userId,
    required String accessToken,
  }) async {
    const endPoint = ApiEndPoints.getAllCompanyIncident;
    var response = await sendHttpRequest(
      accessToken: accessToken,
      endPoint: '/$endPoint/$userId',
      httpRequestMethod: HttpRequestMethod.get,
      controller: controller,
    );
    return IncidentListModel.fromJson(response);
  }

  Future<AllActiveIncidentsResponse?> getAllCompanyActiveIncident(
    IncidentStatus status, {
    required String accessToken,
  }) async {
    const endPoint = ApiEndPoints.getAllActiveCompanyIncident;
    var incidentStatus = status == IncidentStatus.AwaitingLaunch ? '1' : '2';

    var response = await sendHttpRequest(
      accessToken: accessToken,
      endPoint: '/$endPoint/$incidentStatus',
      controller: controller,
      httpRequestMethod: HttpRequestMethod.get,
    );

    return AllActiveIncidentsResponse.fromJson(response);
  }

  ///Returns the incident detail for the given incident id
  Future<IncidentDetail?> getCompanyIncidentById({
    required int incidentId,
    required String userStatus,
    required String accessToken,
  }) async {
    const controller = ApiEndPoints.incident;
    const endPoint = ApiEndPoints.getCompanyIncidentById;

    var response = await sendHttpRequest(
      accessToken: accessToken,
      endPoint: '/$endPoint/$incidentId/$userStatus',
      controller: controller,
      httpRequestMethod: HttpRequestMethod.get,
    );

    return IncidentDetail.fromJson(response);
  }

  Future<MessageDetailsResponse?> getIncidentMessages({
    required String accessToken,
    required int incidentId,
    required int userId,
  }) async {
    const messageController = ApiContrtollers.messaging;
    const endPoint = ApiEndPoints.getMessages;

    var response = await sendHttpRequest(
      accessToken: accessToken,
      endPoint: '/$endPoint/$userId/Incident/$incidentId',
      controller: messageController,
      httpRequestMethod: HttpRequestMethod.get,
    );

    return MessageDetailsResponse.fromJson(response);
  }

  Future<ActiveIncident?> getActiveIncidentForUsers({
    required String accessToken,
  }) async {
    var response = await sendHttpRequest(
      accessToken: accessToken,
      endPoint: '/GetAllActiveIncidentForUser',
      controller: controller,
      httpRequestMethod: HttpRequestMethod.get,
    );

    return ActiveIncident.fromJson(response);
  }

  Future<dynamic> initiateAndLaunchIncident({
    required String accessToken,
    required LaunchIncidentRequestBody launchIncidentBody,
  }) async {
    final response = await sendHttpRequest(
      accessToken: accessToken,
      controller: controller,
      endPoint: '/InitiateAndLaunchIncident',
      requestBody: launchIncidentBody.toJson(),
      httpRequestMethod: HttpRequestMethod.post,
    );
    return response;
  }
}
