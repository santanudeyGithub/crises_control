import 'dart:io';

import 'package:crises_control/src/core/errors/cc_error.dart';
import 'package:crises_control/src/core/errors/exceptions.dart';
import 'package:crises_control/src/core/services/url_launcher_service.dart';
import 'package:crises_control/src/help/help_rest_service.dart';
import 'package:crises_control/src/help/models/feedback_request_body.dart';
import 'package:crises_control/src/help/models/policy_response.dart';
import 'package:crises_control/src/login/services/authentication_database_service.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:dartz/dartz.dart';

class HelpRepository {
  HelpRepository(
    this._helpRestService,
    this._authenticationDatabaseService,
    this.urlLauncherService,
  );
  final HelpRestService _helpRestService;
  final AuthenticationDatabaseService _authenticationDatabaseService;
  final UrlLauncherService urlLauncherService;
  final deviceInfoPlugin = DeviceInfoPlugin();

  Future<Either<CCError, PolicyResponse>> getPolicy({
    required PolicyType policyType,
  }) async {
    final restCredentials =
        await _authenticationDatabaseService.retrieveRestCredentials();
    try {
      final result = await _helpRestService.getPolicy(
        accessToken: restCredentials.accessToken,
        policyType: policyType,
      );
      return Right(result!);
    } on UnauthorisedException {
      return const Left(CCError.unauthorisedError);
    } on SocketException {
      return const Left(CCError.noConnectivityError);
    } on ServerException {
      return const Left(CCError());
    } on Exception {
      return const Left(CCError());
    }
  }

  sendDeviceInfo() async {
    final userInfo =
        await _authenticationDatabaseService.retrieveRestCredentials();
    urlLauncherService.sendEmail(
      email: userInfo.loginData.primaryEmail,
      subject: 'Device Info',
      body: """
      User ID: ${userInfo.loginData.userId}
      User Device ID: ${userInfo.loginData.userDeviceId}
      Company Name: ${userInfo.loginData.companyName}
      """,
    );
  }

  Future<void> sendFeedback({required String feedback}) async {
    final restCredentials =
        await _authenticationDatabaseService.retrieveRestCredentials();
    String? model = '';

    if (Platform.isAndroid) {
      final androidInfo = await deviceInfoPlugin.androidInfo;
      model = androidInfo.model;
    } else if (Platform.isIOS) {
      final iosInfo = await deviceInfoPlugin.iosInfo;
      model = iosInfo.model;
    }

    final feedbackRequestBody = FeedbackRequestBody(
      deviceType: 1,
      deviceOs: Platform.operatingSystem,
      deviceModel: model,
      feedbackMessage: feedback,
      userEmail: restCredentials.loginData.primaryEmail,
    );

    _helpRestService.sendFeedback(
        accessToken: restCredentials.accessToken,
        feedbackRequestBody: feedbackRequestBody);
  }
}
