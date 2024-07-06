import 'dart:io';

import 'package:crises_control/src/core/errors/cc_error.dart';
import 'package:crises_control/src/core/services/location_rest_service.dart';
import 'package:crises_control/src/login/services/authentication_database_service.dart';
import 'package:dartz/dartz.dart';

class LocationRepository {
  LocationRepository(
    this._locationRestService,
    this._authenticationDatabaseService,
  );

  final LocationRestService _locationRestService;
  final AuthenticationDatabaseService _authenticationDatabaseService;

  Future<Either<CCError, dynamic>> captureUserLocation(
    double latitude,
    double longitude,
  ) async {
    try {
      final restCredentials =
          await _authenticationDatabaseService.retrieveRestCredentials();
      var response = await _locationRestService.captureUserLocation(
        accessToken: restCredentials.accessToken,
        latitude: latitude,
        longitude: longitude,
        userDeviceId: restCredentials.loginData.userDeviceId,
      );
      return Right(response);
    } on SocketException {
      return const Left(CCError.noConnectivityError);
    } on Exception {
      return const Left(CCError());
    }
  }

  Future<Either<CCError, dynamic>> updateTrackMe({
    required bool enabled,
    required String trackType,
    required double? latitude,
    required double? longitude,
    required int activeIncidentId,
  }) async {
    try {
      final restCredentials =
          await _authenticationDatabaseService.retrieveRestCredentials();
      var response = await _locationRestService.updateTrackMe(
        accessToken: restCredentials.accessToken,
        enabled: enabled,
        trackType: trackType,
        activeIncidentId: 0,
        latitude: latitude,
        longitude: longitude,
        userDeviceId: restCredentials.loginData.userDeviceId,
        userId: restCredentials.loginData.userId,
      );
      return Right(response);
    } on SocketException {
      return const Left(CCError.noConnectivityError);
    } on Exception {
      return const Left(CCError());
    }
  }
}
