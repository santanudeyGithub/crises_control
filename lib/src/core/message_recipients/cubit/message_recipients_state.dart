part of 'message_recipients_cubit.dart';

//Enum to define the actions of the message recipients page
enum MessageRecipientsStatus {
  initial,
  add,
  remove,
  loading,
  acknowledge,
  unacknowledge,
  all,
  loaded,
  error,
  selectAll,
  unselectAll,
  email,
  phone,
  landline,
  location
}

class MessageRecipientsState extends Equatable {
  const MessageRecipientsState(
    this.acknowledgeStatusList,
    this.selectedRecipients,
    this.status,
    this.selectedCount,
    this.error,
  );

  final List<MessageAcknowledgeStatus> acknowledgeStatusList;
  final List<MessageAcknowledgeStatus> selectedRecipients;
  final MessageRecipientsStatus status;
  final int selectedCount;
  final CCError? error;
  @override
  List<Object?> get props =>
      [acknowledgeStatusList, selectedRecipients, status, selectedCount];

  MessageRecipientsState copyWith({
    List<MessageAcknowledgeStatus>? acknowledgeStatusList,
    List<MessageAcknowledgeStatus>? selectedRecipients,
    MessageRecipientsStatus? status,
    int? selectedCount,
    CCError? error,
  }) {
    return MessageRecipientsState(
      acknowledgeStatusList ?? this.acknowledgeStatusList,
      selectedRecipients ?? this.selectedRecipients,
      status ?? this.status,
      selectedCount ?? this.selectedCount,
      error ?? this.error,
    );
  }
}
