import 'package:bloc/bloc.dart';
import 'package:crises_control/src/incident/models/incident_detail.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'message_editor_state.dart';

class MessageEditorCubit extends Cubit<MessageEditorState> {
  MessageEditorCubit() : super(MessageEditorInitial());

  ///Adds the selected message from the message library and emits an [LibraryMessageAdded] state
  addMessageFromLibrary({required IncidentMessages incidentMessage}) {
    emit(LibraryMessageAdded(incidentMessage));
    emit(MessageEditorInitial());
  }
}
