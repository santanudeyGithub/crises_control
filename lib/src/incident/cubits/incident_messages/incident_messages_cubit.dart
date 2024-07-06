import 'package:bloc/bloc.dart';
import 'package:crises_control/src/core/errors/cc_error.dart';
import 'package:crises_control/src/incident/incident_repository.dart';
import 'package:crises_control/src/incident/models/incident_message_details.dart';
import 'package:equatable/equatable.dart';

part 'incident_messages_state.dart';

class IncidentMessagesCubit extends Cubit<IncidentMessagesState> {
  IncidentMessagesCubit(this._incidentRepository)
      : super(IncidentMessagesInitial());
  final IncidentRepository _incidentRepository;

  Future<void> loadIncidentMessages({required int incidentId}) async {
    await Future.delayed(const Duration(milliseconds: 1));
    emit(IncidentMessagesLoading());
    final result =
        await _incidentRepository.getIncidentMessages(incidentId: incidentId);
    result.fold(
      (error) => emit(IncidentMessagesFailure(error)),
      (incidentMessage) => emit(IncidentMessagesLoaded(incidentMessage)),
    );
  }
}
