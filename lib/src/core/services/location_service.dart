import 'dart:async';
import 'dart:developer';

import 'package:crises_control/src/core/repository/location_repository.dart';
import 'package:location/location.dart';

class LocationService {
  LocationService(
    this._locationRepository,
  ) {
    init();
  }
  final LocationRepository _locationRepository;
  static final Location _locationHandler = Location();
  static StreamSubscription<LocationData>? _onLocationChangedStreamSubscription;

  void init() {
    changeSettings(
      accuracy: LocationAccuracy.high,
      interval: 1000 * 60, //1 minute
      distanceFilter: 5, //5 meters
    );
  }

  Future<bool> hasLocationPermission() async {
    bool serviceEnabled;
    serviceEnabled = await _locationHandler.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await _locationHandler.requestService();
      if (!serviceEnabled) {
        return false;
      }
    }

    PermissionStatus permissionGranted;
    permissionGranted = await _locationHandler.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await _locationHandler.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return false;
      }
    }
    return true;
  }

  Future<LocationData?> getCurrentLocation() async {
    if (!await hasLocationPermission()) return null;
    try {
      return await _locationHandler.getLocation();
    } on Exception {
      return null;
    }
  }

  void startTracking() {
    _locationHandler.enableBackgroundMode(enable: true);
    _onLocationChangedStreamSubscription = _locationHandler.onLocationChanged
        .listen((LocationData currentLocation) async {
      var latitude = currentLocation.latitude;
      var longitude = currentLocation.longitude;
      log('onLocationChanged: $latitude,$longitude');
      if (latitude != null && longitude != null) {
        try {
          await _locationRepository.captureUserLocation(latitude, longitude);
          // ignore: empty_catches
        } on Exception {}
      }
    });
  }

  void stopTracking() {
    _locationHandler.enableBackgroundMode(enable: false);
    if (_onLocationChangedStreamSubscription != null) {
      log('onLocationChanged: cancelled');
      _onLocationChangedStreamSubscription!.cancel();
    }
  }

  /// Change settings of the location request.
  ///
  /// The [accuracy] argument is controlling the precision of the
  /// [LocationData]. The [interval] and [distanceFilter] are controlling how
  /// often a new location is sent through [onLocationChanged].
  ///
  /// [interval] and [distanceFilter] are not used on web.
  ///
  /// [interval] will set the desired interval for active location updates, in milliseconds (only affects Android).
  ///
  /// [distanceFilter] set the minimum displacement between location updates in meters.
  Future<bool> changeSettings({
    LocationAccuracy? accuracy = LocationAccuracy.high,
    int? interval = 1000,
    double? distanceFilter = 500,
  }) async {
    return await _locationHandler.changeSettings(
      accuracy: accuracy,
      interval: interval,
      distanceFilter: distanceFilter,
    );
  }

  // Future<void> updateTrackMe({
  //   required bool enabled,
  //   required String trackType,
  //   required int activeIncidentId,
  // }) async {
  //   var currentLocation = await getCurrentLocation();
  //   await _locationRepository.updateTrackMe(
  //     enabled: enabled,
  //     trackType: trackType,
  //     latitude: currentLocation?.latitude,
  //     longitude: currentLocation?.longitude,
  //     activeIncidentId: activeIncidentId,
  //   );
  // }
}
