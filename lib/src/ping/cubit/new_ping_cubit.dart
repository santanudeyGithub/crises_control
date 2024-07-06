import 'dart:io';

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
import 'package:crises_control/src/core/models/media_attachments.dart';
import 'package:crises_control/src/core/presentation/pages/lists/user_list_page.dart';
import 'package:crises_control/src/core/repository/crises_control_core_repository.dart';
import 'package:crises_control/src/core/services/crises_control_rest_service.dart';
import 'package:crises_control/src/core/utils/common.dart';
import 'package:crises_control/src/ping/ping.dart';
import 'package:crises_control/src/ping/repository/ping_repository.dart';
import 'package:equatable/equatable.dart';

part 'new_ping_state.dart';

class NewPingCubit extends Cubit<NewPingState> {
  NewPingCubit(this._pingRepository, this._crisesControlCoreRepository)
      : super(NewPingInitial());
  final PingRepository _pingRepository;
  final CrisesControlCoreRepository _crisesControlCoreRepository;
  List<MediaAttachment> _mediaAttachments = [];

  Future<void> loadNewPingPage() async {
    await Future.delayed(const Duration(microseconds: 1));
    emit(NewPingLoading());

    List<SelectedCommunication> lowPrioity = [];
    List<SelectedCommunication> mediumPrioity = [];
    List<SelectedCommunication> highPriority = [];
    List<MessageMethod> allCommunicationChannels = [];
    List<CascadingPlan> allCascadingChannels = [];
    String? hasLowBalance;
    //Comms
    final responseComms = await _crisesControlCoreRepository.getCompanyComms();
    if (isClosed) return;
    responseComms.fold(
      (error) => emit(NewPingErrorPop(error)),
      (data) {
        allCommunicationChannels =
            data.data.objectInfo.where((m) => m.status == 1).toList();
        lowPrioity = ListHelpers.getCommsForPriority(
            data: data,
            priorityLevel: 100,
            messageType: BackendConstants.messageTypePing);
        mediumPrioity = ListHelpers.getCommsForPriority(
            data: data,
            priorityLevel: 500,
            messageType: BackendConstants.messageTypePing);
        highPriority = ListHelpers.getCommsForPriority(
            data: data,
            priorityLevel: 999,
            messageType: BackendConstants.messageTypePing);
        hasLowBalance = data.data.hasLowBalance;
      },
    );

    //Cascading Plan
    if (_crisesControlCoreRepository
        .checkMenuAccess(SecItemKeys.pingUseCascading)) {
      final responseCascading = await _crisesControlCoreRepository
          .getCascadingPlans(cascadingPlanType: CascadingPlanType.ping);
      if (isClosed) return;
      responseCascading.fold(
        (error) => emit(NewPingErrorPop(error)),
        (data) {
          allCascadingChannels = data.data;
        },
      );
    }

    emit(NewPingLoaded(
      allCommunicationChannels,
      lowPrioity,
      mediumPrioity,
      highPriority,
      allCascadingChannels,
      hasLowBalance,
    ));
  }

  Future<void> sendPing({
    required String message,
    required List<AcknowledgeOption> ackOptions,
    required List<SelectedCommunication> selectedCommunicationMethods,
    required List<GroupData> groups,
    required List<LocationsData> locations,
    required List<DepartmentsData> departments,
    required List<SelectedUser> userToNotify,
    required bool isSlientMessage,
    required int priorityIndex,
  }) async {
    emit(NewPingLoading());
    int cascadingPlanId = 0;

    if (selectedCommunicationMethods
        .where((element) => element.isCascadingPlan)
        .isNotEmpty) {
      cascadingPlanId = selectedCommunicationMethods
          .firstWhere((element) => element.isCascadingPlan)
          .id;
    }

    if (_mediaAttachments.isNotEmpty) {
      _pingRepository.uploadAnAttachment(
        attachment: File(_mediaAttachments.first.filePath),
      );
    }

    final response = await _pingRepository.sendPing(
      message: message,
      mediaAttachments: [],
      ackOptions: ackOptions,
      messageMethods: selectedCommunicationMethods
          .where((element) => element.isCascadingPlan != true)
          .toList(),
      usersToNotify: userToNotify,
      cascadePlanId: cascadingPlanId,
      departments: departments,
      groups: groups,
      locations: locations,
      slientMessage: isSlientMessage,
      priorityIndex: priorityIndex,
    );
    response.fold((error) => emit(NewPingError(error)),
        (success) => emit(const NewPingLaunched(""))); 
  }

  addMediaAttachments(List<MediaAttachment> mediaAttachments) {
    _mediaAttachments = mediaAttachments;
  }
}
