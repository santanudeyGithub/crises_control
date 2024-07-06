// ignore_for_file: prefer_const_literals_to_create_immutables

import 'dart:io';

import 'package:crises_control/src/core/errors/cc_error.dart';
import 'package:crises_control/src/core/errors/exception_handler.dart';
import 'package:crises_control/src/core/errors/exceptions.dart';
import 'package:crises_control/src/core/models/communication_models/message_response.dart';
import 'package:crises_control/src/core/models/communication_models/selected_communication.dart';
import 'package:crises_control/src/core/models/list_models/departments.dart';
import 'package:crises_control/src/core/models/list_models/groups.dart';
import 'package:crises_control/src/core/models/list_models/locations.dart';
import 'package:crises_control/src/core/models/list_models/request/request_models.dart';
import 'package:crises_control/src/core/presentation/pages/lists/user_list_page.dart';
import 'package:crises_control/src/incident/models/active_incident.dart';
import 'package:crises_control/src/incident/models/incident_detail.dart';
import 'package:crises_control/src/incident/models/incident_list_model.dart';
import 'package:crises_control/src/incident/models/incident_message_details.dart';
import 'package:crises_control/src/incident/models/launch_incident_request_body.dart';
import 'package:crises_control/src/incident/services/incident_rest_service.dart';
import 'package:crises_control/src/login/services/authentication_database_service.dart';
import 'package:dartz/dartz.dart';

import 'models/all_active_incident.dart';

class IncidentRepository {
  IncidentRepository(
    this._incidentRestService,
    this._authenticationDatabaseService,
  );
  final IncidentRestService _incidentRestService;
  final AuthenticationDatabaseService _authenticationDatabaseService;

  Future<Either<CCError, IncidentListModel>> getAllCompanyIncident() async {
    try {
      final restCredentials =
          await _authenticationDatabaseService.retrieveRestCredentials();

      var incidents = await _incidentRestService.getAllCompanyIncident(
        userId: restCredentials.loginData.userId,
        accessToken: restCredentials.accessToken,
      );

      if (incidents != null) {
        return Right(
          incidents,
        );
      }
      // return empty data
      return const Left(CCError());
    } on Exception catch (e) {
      final error = ExcepetionHandler.handleException(exception: e);
      return Left(error);
    }
  }

  Future<Either<CCError, AllActiveIncidentsResponse>>
      getAllCompanyActiveIncident(
    IncidentStatus status,
  ) async {
    try {
      final restCredentials =
          await _authenticationDatabaseService.retrieveRestCredentials();
      var incidents = await _incidentRestService.getAllCompanyActiveIncident(
        status,
        accessToken: restCredentials.accessToken,
      );

      if (incidents != null) {
        return Right(
          incidents,
        );
      }

      return const Left(CCError(errorTitle: 'No active incidents'));
    } on Exception catch (e) {
      final error = ExcepetionHandler.handleException(exception: e);
      return Left(error);
    }
  }

  Future<Either<CCError, IncidentDetail>> getCompanyIncidentById({
    required int incidentId,
  }) async {
    try {
      final restCredentials =
          await _authenticationDatabaseService.retrieveRestCredentials();
      var incidents = await _incidentRestService.getCompanyIncidentById(
        incidentId: incidentId,
        userStatus: restCredentials.loginData.userRole,
        accessToken: restCredentials.accessToken,
      );

      if (incidents != null) {
        return Right(incidents);
      }

      // return empty data
      return const Left(CCError(errorTitle: 'No incident detail'));
    } on Exception catch (e) {
      final error = ExcepetionHandler.handleException(exception: e);
      return Left(error);
    }
  }

  Future<Either<CCError, List<MessageDetails>>> getIncidentMessages({
    required int incidentId,
  }) async {
    try {
      final restCredentials =
          await _authenticationDatabaseService.retrieveRestCredentials();
      var incidentMessages = await _incidentRestService.getIncidentMessages(
        userId: restCredentials.loginData.userId,
        incidentId: incidentId,
        accessToken: restCredentials.accessToken,
      );

      if (incidentMessages != null && incidentMessages.data.isNotEmpty) {
        return Right(incidentMessages.data);
      }
      // return empty data
      return const Left(CCError());
    } on Exception catch (e) {
      final error = ExcepetionHandler.handleException(exception: e);
      return Left(error);
    }
  }

  Future<Either<CCError, ActiveIncident>> getAllActiveIncidentForUser() async {
    try {
      final restCredentials =
          await _authenticationDatabaseService.retrieveRestCredentials();

      final incidents = await _incidentRestService.getActiveIncidentForUsers(
        accessToken: restCredentials.accessToken,
      );

      if (incidents != null) {
        return Right(incidents);
      }
      return const Left(CCError());
    } on Exception catch (e) {
      final error = ExcepetionHandler.handleException(exception: e);
      return Left(error);
    }
  }

  Future<Either<CCError, dynamic>> initiateAndLaunchIncident({
    required int incidentId,
    required String message,
    required List<LocationsData> locationsToNotify,
    required List<GroupData> groups,
    required List<DepartmentsData> departments,
    required List<SelectedUser> usersToNotify,
    required List<SelectedUser> keyContacts,
    required List<LocationsData> impactedLocations,
    required List<SelectedCommunication> messageMethods,
    required List<LocationsData> affectedLocations,
    required List<AcknowledgeOption> ackOptions,
    required bool isSlientMessage,
    required bool trackUser,
    required int severity,
    required int cascadingPlanId,
    required bool isSimulation, //launchMode 4 for simulation
  }) async {
    var restCredentials =
        await _authenticationDatabaseService.retrieveRestCredentials();

    try {
      //Groups, Departments, Locations
      List<MessageObjRq> messageObjs = [];
      messageObjs.addAll(groups.map((g) => g.toAcknowledgeOptionRq()).toList());
      messageObjs
          .addAll(departments.map((d) => d.toAcknowledgeOptionRq()).toList());
      messageObjs.addAll(
          locationsToNotify.map((l) => l.toAcknowledgeOptionRq()).toList());

      //AckOptions
      List<AcknowledgeOptionRq> ackOptionsRq = [];
      for (var i = 0; i < ackOptions.length; i++) {
        ackOptionsRq.add(ackOptions[i].toAcknowledgeOptionRq(i));
      }

      final launchIncidentBody = LaunchIncidentRequestBody(
        incidentId: incidentId,
        incidentActivationId: 0,
        description: message,
        severity: severity,
        multiResponse: ackOptionsRq.isNotEmpty,
        ackOptions: ackOptionsRq,
        impactedLocations:
            impactedLocations.map((il) => il.locationId).toList(),
        userRole: restCredentials.loginData.userRole,
        audioAssetId: 0, 
        trackUser: trackUser,
        silentMessage: isSlientMessage,
        messageMethod: messageMethods.map((mm) => mm.id).toList(),
        numberOfKeyHolder: 1, 
        initiateIncidentActionLst: [],
        initiateIncidentKeyHldLst: keyContacts,
        initiateIncidentNotificationObjLst: messageObjs,
        affectedLocations: affectedLocations,
        usersToNotify: usersToNotify.map((u) => u.userId).toList(),
        launchMode: isSimulation ? 4 : 0,
        socialHandle: const [], 
        source: "App",
        cascadePlanId: cascadingPlanId,
        incidentKeyholder: [],
      );

      final response = await _incidentRestService.initiateAndLaunchIncident(
        accessToken: restCredentials.accessToken,
        launchIncidentBody: launchIncidentBody,
      );

      return Right(response);
    } on UnauthorisedException {
      return const Left(CCError.unauthorisedError);
    } on SocketException {
      //If the user has not got a connection to the internet
      return const Left(CCError.noConnectivityError);
    } on ServerException {
      return const Left(CCError());
    } on Exception {
      return const Left(CCError());
    }
  }
}
