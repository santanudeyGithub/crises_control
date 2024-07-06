import 'package:bloc/bloc.dart';
import 'package:crises_control/src/core/core.dart';
import 'package:crises_control/src/core/errors/cc_error.dart';
import 'package:crises_control/src/core/models/communication_models/company_comms_response.dart';
import 'package:crises_control/src/core/models/communication_models/selected_communication.dart';
import 'package:crises_control/src/core/models/replies.dart';
import 'package:crises_control/src/core/repository/crises_control_core_repository.dart';
import 'package:crises_control/src/core/utils/list_helpers.dart';
import 'package:crises_control/src/ping/models/ping.dart';
import 'package:crises_control/src/ping/models/ping_info.dart';
import 'package:crises_control/src/ping/repository/ping_repository.dart';
import 'package:equatable/equatable.dart';

part 'ping_details_state.dart';

class PingDetailsCubit extends Cubit<PingDetailsState> {
  PingDetailsCubit(this._pingRepository, this._crisesControlCoreRepository)
      : super(PingDetailsInitial());
  final PingRepository _pingRepository;
  final CrisesControlCoreRepository _crisesControlCoreRepository;

  //Load ping details page
  Future<void> loadPingDetailsPage(PingData pingData) async {
    if (pingData.hasReplies) {
      await getReplies(pingData.messageId);
    } else {
      await getPingInfo(pingData.messageId);
    }
  }

  //get ping info
  Future<void> getPingInfo(int messageId) async {
    emit(PingDetailsLoading());
    final result = await _pingRepository.getPingInfo(messageId: messageId);
    if (isClosed) return;
    result.fold(
      (error) => emit(PingDetailsFailure(error)),
      (pingInfo) => emit(PingDetailsLoaded(pingInfo)),
    );
  }

  Future<void> getCommunicationMethods() async {
    emit(PingDetailsLoading());
    final result = await _crisesControlCoreRepository.getCompanyComms();
    if (isClosed) return;
    result.fold(
      (error) => emit(PingDetailsFailure(error)),
      (communicationMethods) {
        var comms = ListHelpers.getPriorityForCommsResponse(
          data: communicationMethods,
          priorityLevel: 100,
          messageType: BackendConstants.messageTypePing,
        );
        emit(
          PingDetailsCommunicationMethodsLoaded(
            comms,
            communicationMethods.data.objectInfo,
          ),
        );
      },
    );
  }

  Future<void> getReplies(int parentId) async {
    await Future.delayed(const Duration(microseconds: 1));
    emit(PingDetailsLoading());
    if (isClosed) return;
    final result = await _pingRepository.getReplies(parentId: parentId);
    result.fold(
      (error) => emit(PingDetailsFailure(error)),
      (replies) => emit(PingDetailsReplies(replies)),
    );
  }

  Future<void> replyToPing({
    required PingData ping,
    required ReplyType replyTo,
    required String message,
    required List<int> messageMethods,
  }) async {
    final result = await _pingRepository.replyToPing(
      ping: ping,
      message: message,
      messageMethod: messageMethods,
      pingReplyTo: replyTo,
    );

    if (isClosed) return;
    result.fold(
      (error) => emit(PingDetailsFailure(error)),
      (success) => emit(PingDetailsReplied()),
    );
  }

  Future<void> renotifyUnacknowledged({
    required PingData ping,
    required String message,
    required List<int> messageMethods,
    required int cascadingPlanId,
  }) async {
    final result = await _pingRepository.renotifyUnacknowledgeUsers(
      ping: ping,
      messageMethod: messageMethods,
      message: message,
      cascadingPlanId: cascadingPlanId,
    );

    if (isClosed) return;
    result.fold(
      (error) => emit(PingDetailsFailure(error)),
      (success) => emit(PingDetailsReplied()),
    );
  }

  //acknowledge ping
  Future<void> acknowledgePing({
    required PingData ping,
  }) async {
    final result = await _pingRepository.acknowledgePing(
      msgListId: ping.messageId,
      responseId: 0,
    );

    if (isClosed) return;
    result.fold((error) => emit(PingDetailsFailure(error)), (success) => null);
  }
}
