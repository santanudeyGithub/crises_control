import 'package:crises_control/src/core/constants.dart';
import 'package:crises_control/src/core/services/base_rest_service.dart';

class LocationRestService extends BaseRestService {
  static const controller = ApiEndPoints.incident;

  Future<dynamic> captureUserLocation({
    required String accessToken,
    required double latitude,
    required double longitude,
    required int userDeviceId,
  }) async {
    var userLocations = [
      {
        "Latitude": latitude,
        "Longitude": longitude,
        "UserDeviceTime": DateTime.now().toIso8601String(),
      }
    ];
    final requestBody = <String, dynamic>{
      'UserLocations': userLocations,
      'UserDeviceId': userDeviceId,
    };
    return await sendHttpRequest(
      accessToken: accessToken,
      endPoint: '/${ApiEndPoints.captureUserLocation}',
      httpRequestMethod: HttpRequestMethod.post,
      controller: ApiContrtollers.app,
      requestBody: requestBody,
    );
  }

  Future<dynamic> updateTrackMe({
    required String accessToken,
    required bool enabled,
    required String trackType,
    required int activeIncidentId,
    required double? latitude,
    required double? longitude,
    required int userDeviceId,
    required int userId,
  }) async {
    final requestBody = <String, dynamic>{
      'Enabled': enabled,
      'TrackType': trackType,
      'ActiveIncidentID': activeIncidentId,
      'Latitude': latitude,
      'Longitude': longitude,
      'UserDeviceID': userDeviceId,
      'UserId': userId,
    };
    return await sendHttpRequest(
      accessToken: accessToken,
      endPoint: '/${ApiEndPoints.captureUserLocation}',
      httpRequestMethod: HttpRequestMethod.post,
      controller: ApiContrtollers.app,
      requestBody: requestBody,
    );
  }
}
