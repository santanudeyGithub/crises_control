import 'dart:developer';

import 'package:crises_control/src/core/constants.dart';
import 'package:crises_control/src/core/services/base_rest_service.dart';
import 'package:crises_control/src/ping/models/ping.dart';
import 'package:crises_control/src/ping/models/ping_info.dart';
import 'package:crises_control/src/ping/models/send_ping_body.dart';

class PingRestService extends BaseRestService {
  final controller = ApiEndPoints.messaging;

  Future<PingResponse?> getUsersPings({
    required int userId,
    required String accessToken,
  }) async {
    final response = await sendHttpRequest(
      accessToken: accessToken,
      controller: controller,
      endPoint: '/getMessages/$userId/Ping/0',
      httpRequestMethod: HttpRequestMethod.get,
    );

    return PingResponse.fromJson(response);
  }

  Future<PingInfoResponse?> getPingInfo({
    required int messageId,
    required String accessToken,
  }) async {
    final response = await sendHttpRequest(
      accessToken: accessToken,
      controller: controller,
      endPoint: '/getPingInfo/$messageId',
      httpRequestMethod: HttpRequestMethod.get,
    );

    return PingInfoResponse.fromJson(response);
  }

  Future<void> acknowledgePing({
    required int msgListId,
    required String accessToken,
    required int responseId,
  }) async {
    final requestBody = {
      "MsgListId": msgListId,
      "ResponseID": responseId,
      "AckMethod": "APP",
      "UserLocationLong": "",
      "UserLocationLat": "",
      "CompanyKey": ""
    };

    final response = await sendHttpRequest(
      accessToken: accessToken,
      controller: controller,
      endPoint: '/MessageAcknowledge/$msgListId',
      requestBody: requestBody,
      httpRequestMethod: HttpRequestMethod.post,
    );

    log(response.toString());
  }

  Future<dynamic> sendPing({
    required String accessToken,
    required SendPingBody sendPingBody,
  }) async {
    final response = await sendHttpRequest(
      accessToken: accessToken,
      controller: controller,
      endPoint: '/PingMessage',
      requestBody: sendPingBody.toJson(),
      httpRequestMethod: HttpRequestMethod.post,
    );
    return response;
  }
}
