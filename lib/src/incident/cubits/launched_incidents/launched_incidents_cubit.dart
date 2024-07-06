import 'package:bloc/bloc.dart';
import 'package:crises_control/src/core/errors/cc_error.dart';
import 'package:crises_control/src/incident/incident_repository.dart';
import 'package:crises_control/src/incident/models/all_active_incident.dart';
import 'package:equatable/equatable.dart';

part 'launched_incidents_state.dart';

class LaunchedIncidentsCubit extends Cubit<LaunchedIncidentsState> {
  LaunchedIncidentsCubit(this._incidentRepository)
      : super(const LaunchedIncidentsState(
            null, null, false, LaunchedIncidentActions.none));
  final IncidentRepository _incidentRepository;

  Future<void> getAllActiveIncidents(IncidentStatus status) async {
    await Future.delayed(const Duration(milliseconds: 100));
    emit(const LaunchedIncidentsState(
        null, null, true, LaunchedIncidentActions.loading));
    final result =
        await _incidentRepository.getAllCompanyActiveIncident(status);
    result.fold(
      (error) => emit(
        state.copyWith(
          error: error,
          isLoading: false,
          actions: LaunchedIncidentActions.error,
        ),
      ),
      (activeIncidents) => emit(
        state.copyWith(
          activeIncidents: activeIncidents,
          isLoading: false,
          actions: LaunchedIncidentActions.loaded,
        ),
      ),
    );
  }
}
