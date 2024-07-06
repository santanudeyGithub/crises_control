import 'package:crises_control/src/core/constants.dart';
import 'package:crises_control/src/core/services/base_rest_service.dart';
import 'package:crises_control/src/core/services/device_service.dart';
import 'package:crises_control/src/home/models/app_home.dart';
import 'package:crises_control/src/home/models/phone_number.dart';

class HomeRestService extends BaseRestService {
  static const appController = ApiContrtollers.app;

  /// API ENDPOINT - App Home
  ///retreieves the required data for the home page
  ///Requires the userDeviceId as a [String]
  ///Requires the companyId as a [String]
  Future<AppHome?> getAppHomeData(
      {required String userDeviceId,
      required String companyId,
      required String accessToken}) async {
    //Retrieve the access token
    const endPoint = AppApiEndPoints.appHome;

    var response = await sendHttpRequest(
      accessToken: accessToken,
      controller: appController,
      endPoint: '/$endPoint/$userDeviceId/$companyId',
      httpRequestMethod: HttpRequestMethod.get,
    );

    return AppHome.fromJson(response);
  }

  /// API ENDPOINT - CCPhoneNumbers
  /// Gets the crises control phone numbers as an optional List of [PhoneNumber]
  Future<List<String>?> getCrisesControlPhoneNumbers(
      {required String accessToken}) async {
    //Retrieve the access token`
    const endPoint = AppApiEndPoints.ccPhoneNumbers;

    var response = await sendHttpRequest(
      accessToken: accessToken,
      controller: appController,
      endPoint: '/$endPoint',
      httpRequestMethod: HttpRequestMethod.get,
    );

    var phoneNumbersResponse = PhoneNumberData.fromJson(response);
    return phoneNumbersResponse.phoneNumber;
  }

  Future<void> LaunchSOS({
        required String UserId,
    required int CallBackMethod,

  }) async {
       Map<String, dynamic> data = {
  "DeviceModel":"",//await _deviceService.getDeviceModel(),
  "DeviceType":DeviceService.deviceType(),
   "DeviceSerial":"", //await _deviceService.getDeviceSerial(),,
  "TOKEN": "",
  "CallBackMethod":CallBackMethod,
"UserId":UserId,
"Latitude":"",
"Longitude":"",
"UserDeviceID":"",
"UniqueKey":""

};

    final response = await sendHttpRequest(
      accessToken: "",
      controller: ApiContrtollers.messaging,
      endPoint: 'LaunchSOS',
      httpRequestMethod: HttpRequestMethod.post,
      requestBody: data,
    );

    //log(response.toString());
  }
}
