import 'dart:io';

import 'package:collection/collection.dart';
import 'package:crises_control/src/core/core.dart';
import 'package:crises_control/src/core/errors/cc_error.dart';
import 'package:crises_control/src/core/errors/exceptions.dart';
import 'package:crises_control/src/core/models/communication_models/cascading_plan_response.dart';
import 'package:crises_control/src/core/models/communication_models/company_comms_response.dart';
import 'package:crises_control/src/core/models/communication_models/message_response.dart';
import 'package:crises_control/src/core/models/list_models/affected_locations.dart';
import 'package:crises_control/src/core/models/list_models/departments.dart';
import 'package:crises_control/src/core/models/list_models/groups.dart';
import 'package:crises_control/src/core/models/list_models/locations.dart';
import 'package:crises_control/src/core/models/list_models/users.dart';
import 'package:crises_control/src/core/models/message_acknowledge_status_response.dart';
import 'package:crises_control/src/core/services/crises_control_rest_service.dart';
import 'package:crises_control/src/home/models/app_home.dart';
import 'package:crises_control/src/login/services/authentication_database_service.dart';
import 'package:dartz/dartz.dart';

class CrisesControlCoreRepository {
  CrisesControlCoreRepository(
    this._crisesControlRestService,
    this._authenticationDatabaseService,
  );

  final CrisesControlRestService _crisesControlRestService;
  final AuthenticationDatabaseService _authenticationDatabaseService;
  int companyId = 0;

  int get _companyId {
    if (companyId == 0) {
      companyId = getCompanyId();
    }
    return companyId;
  }

  int getCompanyId() {
    return _authenticationDatabaseService.retrieveCompanyId();
  }

  Future<Either<CCError, Locations>> getLocations() async {
    try {
      var locations = await _crisesControlRestService.getList(
        listApi: ListApi.location,
        companyId: _companyId,
      ) as Locations?;

      //sort the locations alphabetically
      locations?.data.sort((a, b) => a.locationName.compareTo(b.locationName));

      if (locations != null) {
        return Right(
          locations,
        );
      }
      return const Left(CCError(errorTitle: 'No locations'));
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

  Future<Either<CCError, Departments>> getDepartments() async {
    try {
      var departments = await _crisesControlRestService.getList(
        listApi: ListApi.department,
        companyId: _companyId,
      ) as Departments?;

      //sort departments alaphabetically
      departments?.data.sort(
        (a, b) => a.departmentName.compareTo(b.departmentName),
      );

      if (departments != null) {
        return Right(
          departments,
        );
      }
      return const Left(CCError(errorTitle: 'No departments'));
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

  Future<Either<CCError, Groups>> getGroups() async {
    try {
      var groups = await _crisesControlRestService.getList(
        listApi: ListApi.group,
        companyId: _companyId,
      ) as Groups?;

      //sort groups alphabetically
      groups?.data.sort((a, b) => a.groupName.compareTo(b.groupName));

      if (groups != null) {
        return Right(
          groups,
        );
      }
      return const Left(CCError(errorTitle: 'No groups'));
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

  //get all Users
  Future<Either<CCError, Users>> getUsers() async {
    try {
      var users = await _crisesControlRestService.getAllUsers(
        companyId: _companyId,
      );

      //sort users alphabetically
      users?.data.data.sort((a, b) => a.firstName.compareTo(b.firstName));

      if (users != null) {
        return Right(
          users,
        );
      }
      return const Left(CCError(errorTitle: 'No users'));
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

  //get all Affected Locations
  Future<Either<CCError, AffectedLocations>> getAffectedLocations() async {
    try {
      var affectedLocations =
          await _crisesControlRestService.getGetAffectedLocations();

      //sort affectedLocations alphabetically
      affectedLocations.data
          .sort((a, b) => a.locationName.compareTo(b.locationName));

      return Right(
        affectedLocations,
      );
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

  Future<Either<CCError, CompanyCommsResponse>> getCompanyComms() async {
    final restCredentials =
        await _authenticationDatabaseService.retrieveRestCredentials();

    try {
      final response = await _crisesControlRestService.getCompanyComms(
        accessToken: restCredentials.accessToken,
        companyId: restCredentials.loginData.companyId,
      );

      if (response != null) {
        return Right(response);
      }
      return const Left(CCError(errorTitle: 'No company comms'));
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

  Future<Either<CCError, CascadingPlanResponse>> getCascadingPlans({
    required CascadingPlanType cascadingPlanType,
  }) async {
    final restCredentials =
        await _authenticationDatabaseService.retrieveRestCredentials();

    try {
      final response = await _crisesControlRestService.getCascadingPlans(
        accessToken: restCredentials.accessToken,
        cascadingPlanType: cascadingPlanType,
      );

      if (response != null) {
        return Right(response);
      }
      return const Left(CCError(errorTitle: 'No company comms'));
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

  Future<Either<CCError, MessageResponse>> getMessageResponse({
    required String messageType,
    required int status,
  }) async {
    final restCredentials =
        await _authenticationDatabaseService.retrieveRestCredentials();

    try {
      final response = await _crisesControlRestService.getMessageResponses(
        accessToken: restCredentials.accessToken,
        messageType: 'Ping',
        status: status,
      );

      if (response != null) {
        return Right(response);
      }
      return const Left(CCError(errorTitle: 'No message responses'));
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

  Future<Either<CCError, MessageAcknowledgeStatusResponse>>
      getMessageAcknowledgeStatus({
    required int messageId,
  }) async {
    final restCredentials =
        await _authenticationDatabaseService.retrieveRestCredentials();

    try {
      final response =
          await _crisesControlRestService.getAcknowledgeStatusForMessage(
        accessToken: restCredentials.accessToken,
        messageId: messageId,
      );

      if (response != null) {
        return Right(response);
      }
      return const Left(CCError(errorTitle: 'No message acknowledge status'));
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

  Future<Either<CCError, List<String>>> getSocialIntergrations() async {
    var restCredentials =
        await _authenticationDatabaseService.retrieveRestCredentials();
    try {
      final response = await _crisesControlRestService.getSocialIntergration(
        accessToken: restCredentials.accessToken,
        companyId: restCredentials.loginData.companyId,
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

  AppHome? retrieveHomeData() {
    return _authenticationDatabaseService.retrieveHomeData();
  }

  void saveHomeData(AppHome homeData) {
    _authenticationDatabaseService.saveHomeData(homeData);
  }

  String? getCompanyParamValue(String key) {
    var appHome = retrieveHomeData();
    return appHome?.data.companyParams
        .firstWhereOrNull((cp) => cp.name == key)
        ?.value;
  }

  bool checkMenuAccess(String key) {
    var userInfo = _authenticationDatabaseService.retrieveUserInfo();
    return (userInfo?.secItems
                .firstWhereOrNull((si) => si.securityKey == key)
                ?.hasAccess ??
            "false")
        .toBool();
  }

  Future<bool> isLoggedInUserAdmin() async {
    var restCredentials =
        await _authenticationDatabaseService.retrieveRestCredentials();
    String userRole = restCredentials.loginData.userRole.toLowerCase();
    if (userRole == UserRoleString.admin ||
        userRole == UserRoleString.superAdmin) {
      return true;
    } else {
      return false;
    }
  }
}
