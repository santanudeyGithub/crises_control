// ignore_for_file: prefer_const_constructors

import 'package:bloc/bloc.dart';
import 'package:crises_control/src/core/core.dart';
import 'package:crises_control/src/core/errors/cc_error.dart';
import 'package:crises_control/src/core/models/communication_models/cascading_plan_response.dart';
import 'package:crises_control/src/core/models/communication_models/company_comms_response.dart';
import 'package:crises_control/src/core/models/communication_models/message_response.dart';
import 'package:crises_control/src/core/models/communication_models/selected_communication.dart';
import 'package:crises_control/src/core/models/list_models/departments.dart';
import 'package:crises_control/src/core/models/list_models/groups.dart';
import 'package:crises_control/src/core/models/list_models/locations.dart';
import 'package:crises_control/src/core/presentation/pages/lists/user_list_page.dart';
import 'package:crises_control/src/core/repository/crises_control_core_repository.dart';
import 'package:crises_control/src/core/services/crises_control_rest_service.dart';
import 'package:crises_control/src/core/utils/common.dart';
import 'package:crises_control/src/incident/incident_repository.dart';
import 'package:crises_control/src/incident/models/incident_detail.dart';
import 'package:equatable/equatable.dart';

part 'launch_incident_state.dart';

class LaunchIncidentCubit extends Cubit<LaunchIncidentState> {
  LaunchIncidentCubit(
      this._incidentRepository, this._crisesControlCoreRepository)
      : super(const LaunchIncidentInitial());
  final IncidentRepository _incidentRepository;
  final CrisesControlCoreRepository _crisesControlCoreRepository;

  void getIncidentDetails({required int incidentId}) async {
    await Future.delayed(const Duration(milliseconds: 1));
    emit(const LaunchIncidentLoading());

    List<SelectedCommunication> severityCommChannels1 = [];
    List<SelectedCommunication> severityCommChannels2 = [];
    List<SelectedCommunication> severityCommChannels3 = [];
    List<SelectedCommunication> severityCommChannels4 = [];
    List<SelectedCommunication> severityCommChannels5 = [];
    List<MessageMethod> allCommunicationChannels = [];
    List<CascadingPlan> allCascadingChannels = [];
    String? hasLowBalance;
    IncidentDetailData? incidentDetailData;

    //Incident Details
    final responseIncidentDetail =
        await _incidentRepository.getCompanyIncidentById(
      incidentId: incidentId,
    );
    responseIncidentDetail.fold(
      (error) => emit(
        LaunchIncidentErrorPop(error),
      ),
      (data) {
        incidentDetailData = data.data;
      },
    );

    //Comms
    final responseComms = await _crisesControlCoreRepository.getCompanyComms();
    if (isClosed) return;
    responseComms.fold(
      (error) => emit(LaunchIncidentErrorPop(error)),
      (data) {
        allCommunicationChannels =
            data.data.objectInfo.where((m) => m.status == 1).toList();
        severityCommChannels1 = ListHelpers.getCommsForPriority(
            data: data,
            priorityLevel: 1,
            messageType: BackendConstants.messageTypeIncidentSeverity);
        severityCommChannels2 = ListHelpers.getCommsForPriority(
            data: data,
            priorityLevel: 2,
            messageType: BackendConstants.messageTypeIncidentSeverity);
        severityCommChannels3 = ListHelpers.getCommsForPriority(
            data: data,
            priorityLevel: 3,
            messageType: BackendConstants.messageTypeIncidentSeverity);
        severityCommChannels4 = ListHelpers.getCommsForPriority(
            data: data,
            priorityLevel: 4,
            messageType: BackendConstants.messageTypeIncidentSeverity);
        severityCommChannels5 = ListHelpers.getCommsForPriority(
            data: data,
            priorityLevel: 5,
            messageType: BackendConstants.messageTypeIncidentSeverity);
        hasLowBalance = data.data.hasLowBalance;
      },
    );

    //Cascading Plan
    if (_crisesControlCoreRepository
        .checkMenuAccess(SecItemKeys.incidentUseCascading)) {
      final responseCascading = await _crisesControlCoreRepository
          .getCascadingPlans(cascadingPlanType: CascadingPlanType.incident);
      if (isClosed) return;
      responseCascading.fold(
        (error) => emit(LaunchIncidentErrorPop(error)),
        (data) {
          allCascadingChannels = data.data;
        },
      );
    }

    emit(LaunchIncidentDetailsLoaded(
      incidentDetailData!,
      severityCommChannels1,
      severityCommChannels2,
      severityCommChannels3,
      severityCommChannels4,
      severityCommChannels5,
      allCommunicationChannels,
      allCascadingChannels,
      hasLowBalance,
    ));
  }

  Future<void> initiateAndLaunchIncident({
    required int incidentId,
    required String message,
    required List<LocationsData> locationsToNotify,
    required List<GroupData> groups,
    required List<DepartmentsData> departments,
    required List<SelectedUser> usersToNotify,
    required List<SelectedUser> keyContacts,
    required List<LocationsData> impactedLocations,
    required List<SelectedCommunication> selectedCommunicationMethods,
    required List<LocationsData> affectedLocations,
    required List<AcknowledgeOption> ackOptions,
    required bool isSlientMessage,
    required bool trackUser,
    required int severity,
    required int cascadingPlanId,
    required bool isSimulation,
  }) async {
    emit(const LaunchIncidentLoading());
    int cascadingPlanId = 0;

    if (selectedCommunicationMethods
        .where((element) => element.isCascadingPlan)
        .isNotEmpty) {
      cascadingPlanId = selectedCommunicationMethods
          .firstWhere((element) => element.isCascadingPlan)
          .id;
    }

    final response = await _incidentRepository.initiateAndLaunchIncident(
      incidentId: incidentId,
      message: message,
      locationsToNotify: locationsToNotify,
      groups: groups,
      departments: departments,
      usersToNotify: usersToNotify,
      keyContacts: keyContacts,
      impactedLocations: impactedLocations,
      messageMethods: selectedCommunicationMethods
          .where((element) => element.isCascadingPlan != true)
          .toList(),
      affectedLocations: affectedLocations,
      ackOptions: ackOptions,
      isSlientMessage: isSlientMessage,
      trackUser: trackUser,
      severity: severity,
      cascadingPlanId: cascadingPlanId,
      isSimulation: isSimulation,
    );
    response.fold((error) => emit(LaunchIncidentError(error)),
        (success) => emit(LaunchIncidentLaunched(""))); 
  }
}
