part of 'message_editor_cubit.dart';

@immutable
abstract class MessageEditorState extends Equatable {}

class MessageEditorInitial extends MessageEditorState {
  @override
  List<Object?> get props => [];
}

class LibraryMessageAdded extends MessageEditorState {
  LibraryMessageAdded(this.incidentMessage);
  final IncidentMessages incidentMessage;
  @override
  List<Object?> get props => [incidentMessage];
}
