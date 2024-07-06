part of 'incident_messages_cubit.dart';

abstract class IncidentMessagesState extends Equatable {
  const IncidentMessagesState();
}

class IncidentMessagesInitial extends IncidentMessagesState {
  @override
  List<Object?> get props => [];
}

class IncidentMessagesLoading extends IncidentMessagesState {
  @override
  List<Object?> get props => [];
}

class IncidentMessagesFailure extends IncidentMessagesState {
  const IncidentMessagesFailure(this.error);

  final CCError error;

  @override
  List<Object?> get props => [error];
}

class IncidentMessagesLoaded extends IncidentMessagesState {
  const IncidentMessagesLoaded(this.incidentMessages);
  final List<MessageDetails> incidentMessages;

  @override
  List<Object> get props => [incidentMessages];
}
