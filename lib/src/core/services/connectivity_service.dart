// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectivityService {
  ConnectivityService();
  late ConnectivityResult _connectivityResult;
  ConnectivityResult get isLoading => _connectivityResult;

  Future<bool> hasConnectivity() async {
    _connectivityResult = (await Connectivity().checkConnectivity()) as ConnectivityResult;
    switch (_connectivityResult) {
      case ConnectivityResult.wifi:
        return true;
      case ConnectivityResult.mobile:
        return true;
      case ConnectivityResult.ethernet:
        return true;
      case ConnectivityResult.bluetooth:
        return false;
      case ConnectivityResult.none:
        return false;
      case ConnectivityResult.vpn:
        return false;
      case ConnectivityResult.other:
        return false;
        //break;
    }
  }
}
