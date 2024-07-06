import 'package:crises_control/src/core/constants.dart';
import 'package:crises_control/src/core/services/base_rest_service.dart';
import 'package:sprintf/sprintf.dart';

class GoogleMapsRestService extends BaseRestService {
  Future<dynamic> googleMapGeocode(double lat, double lng) async {
    String url = sprintf(GoogleMaps.googlePlacesApiGeocode, [
      GoogleMaps.googlePlacesApiKey,
      Uri.encodeFull('$lat,$lng'),
    ]);

    var response = await sendHttpRequest(
        requiresAccessToken: false,
        accessToken: null,
        fullUrl: url,
        httpRequestMethod: HttpRequestMethod.get);

    if (response["status"] == "OK" || response["status"] == "ZERO_RESULTS") {
      return response;
    }
    throw Exception();
  }

  Future<dynamic> googleMapPlaceAutocomplete(String searchInput) async {
    String url = sprintf(GoogleMaps.googlePlacesApiAutoCompletePath, [
      GoogleMaps.googlePlacesApiKey,
      Uri.encodeFull(searchInput),
    ]);

    var response = await sendHttpRequest(
        requiresAccessToken: false,
        accessToken: null,
        fullUrl: url,
        httpRequestMethod: HttpRequestMethod.get);
    return response;
  }

  Future<dynamic> googleMapPlaceDetail(String placeId) async {
    String url = sprintf(GoogleMaps.googlePlacesApiDetail, [
      GoogleMaps.googlePlacesApiKey,
      Uri.encodeFull(placeId),
    ]);

    var response = await sendHttpRequest(
        requiresAccessToken: false,
        accessToken: null,
        fullUrl: url,
        httpRequestMethod: HttpRequestMethod.get);
    return response;
  }
}
