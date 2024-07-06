//import 'dart:developer';
// ignore_for_file: unnecessary_null_comparison, deprecated_member_use

import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';

class DeviceService {
  DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();

  Future<String> getDeviceModel() async {
    String? model = '';
    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfoPlugin.androidInfo;
      model = androidInfo.model;
    } else if (Platform.isIOS) {
      IosDeviceInfo iosInfo = await deviceInfoPlugin.iosInfo;
      model = iosInfo.name;
    }

    if (model != null) return model;
    return 'NO DEVICE MODEL';
  }

  static String deviceType() {
    var type = 'NO TYPE';
    if (Platform.isAndroid) {
      type = 'ANDROID';
    } else if (Platform.isIOS) {
      type = 'IOS';
    }
    return type;
  }

  //Get device serial number
  Future<String> getDeviceSerial() async {
    final result = await deviceInfoPlugin.deviceInfo;
    var serial = 'NO SERIAL';
    var data = result.toMap();

    if (Platform.isAndroid) {
      // serial = data['androidId'] as String;
      serial = '123456789101112';
    } else if (Platform.isIOS) {
      serial = data['identifierForVendor'];
    }
    return serial;
  }
}
