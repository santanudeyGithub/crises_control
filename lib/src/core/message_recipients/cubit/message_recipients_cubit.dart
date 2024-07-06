import 'package:bloc/bloc.dart';
import 'package:crises_control/src/core/errors/exceptions.dart';
//import 'package:crises_control/src/core/message_recipients/models/acknowledge_status.dart';
import 'package:crises_control/src/core/errors/cc_error.dart';
import 'package:crises_control/src/core/models/message_acknowledge_status_response.dart';
import 'package:crises_control/src/core/repository/crises_control_core_repository.dart';
import 'package:crises_control/src/core/services/url_launcher_service.dart';
import 'package:equatable/equatable.dart';

part 'message_recipients_state.dart';

class MessageRecipientsCubit extends Cubit<MessageRecipientsState> {
  MessageRecipientsCubit(
    this._urlLauncherService,
    this._crisesControlCoreRepository,
  ) : super(
          const MessageRecipientsState(
              [], [], MessageRecipientsStatus.initial, 0, null),
        );

  List<MessageAcknowledgeStatus> allAcknowledgeStatusList = [];
  List<MessageAcknowledgeStatus> selectedRecipients = [];
  final CrisesControlCoreRepository _crisesControlCoreRepository;
  final UrlLauncherService _urlLauncherService;

  tabChanged(int index) {
    switch (index) {
      case 0:
        selectAllAcknowledgeStatus();
        break;
      case 1:
        selectAcknowledgeStatus();
        break;
      case 2:
        selectUnacknowledgeStatus();
        break;
    }
  }

  Future<void> loadAllAcknowledgeStatus({required int messageId}) async {
    await Future.delayed(const Duration(milliseconds: 1));
    emit(state.copyWith(status: MessageRecipientsStatus.loading));
    final result =
        await _crisesControlCoreRepository.getMessageAcknowledgeStatus(
      messageId: messageId,
    );
    result.fold(
      (l) => emit(
        state.copyWith(
          acknowledgeStatusList: [],
          status: MessageRecipientsStatus.error,
          error: l,
        ),
      ),
      (r) {
        allAcknowledgeStatusList = r.data.data;
        emit(
          state.copyWith(
            acknowledgeStatusList: allAcknowledgeStatusList,
            status: MessageRecipientsStatus.loaded,
            error: null,
          ),
        );
      },
    );
  }

  selectAllTapped(bool isAllSelected) {
    if (isAllSelected) {
      selectedRecipients = state.acknowledgeStatusList;
      emit(
        state.copyWith(
          selectedRecipients: selectedRecipients,
          selectedCount: selectedRecipients.length,
          status: MessageRecipientsStatus.selectAll,
        ),
      );
    } else {
      selectedRecipients = [];
      emit(
        state.copyWith(
          selectedRecipients: selectedRecipients,
          selectedCount: selectedRecipients.length,
          status: MessageRecipientsStatus.unselectAll,
        ),
      );
    }
  }

  recipientTapped(MessageAcknowledgeStatus recipient) {
    if (selectedRecipients.contains(recipient)) {
      selectedRecipients.remove(recipient);
      emit(
        state.copyWith(
          selectedRecipients: selectedRecipients,
          selectedCount: selectedRecipients.length,
          status: MessageRecipientsStatus.remove,
        ),
      );
    } else {
      selectedRecipients.add(recipient);
      emit(
        state.copyWith(
          selectedRecipients: selectedRecipients,
          selectedCount: selectedRecipients.length,
          status: MessageRecipientsStatus.add,
        ),
      );
    }
  }

  selectAllAcknowledgeStatus() {
    emit(
      MessageRecipientsState(
        allAcknowledgeStatusList,
        selectedRecipients,
        MessageRecipientsStatus.all,
        selectedRecipients.length,
        null,
      ),
    );
  }

  selectAcknowledgeStatus() {
    List<MessageAcknowledgeStatus> unacknowledgeStatusList =
        allAcknowledgeStatusList
            .where((element) => element.isAcknowledged == true)
            .toList();
    emit(
      MessageRecipientsState(
        unacknowledgeStatusList,
        selectedRecipients,
        MessageRecipientsStatus.acknowledge,
        selectedRecipients.length,
        null,
      ),
    );
  }

  selectUnacknowledgeStatus() {
    List<MessageAcknowledgeStatus> unacknowledgeStatusList =
        allAcknowledgeStatusList
            .where((element) => element.isAcknowledged == false)
            .toList();
    emit(
      MessageRecipientsState(
        unacknowledgeStatusList,
        selectedRecipients,
        MessageRecipientsStatus.unacknowledge,
        selectedRecipients.length,
        null,
      ),
    );
  }

  onEmail({required String email}) async {
    try {
      await _urlLauncherService.sendEmail(
        email: email,
        subject: '',
        body: '',
      );
    } on UrlLauncherException {
      emit(state.copyWith(error: const CCError()));
    }
  }
}
