import 'package:bloc/bloc.dart';
import 'package:crises_control/src/core/errors/cc_error.dart';
import 'package:crises_control/src/incident/incident_repository.dart';
import 'package:crises_control/src/incident/models/incident_list_model.dart';
import 'package:equatable/equatable.dart';

part 'select_incident_state.dart';

class SelectIncidentCubit extends Cubit<SelectIncidentState> {
  SelectIncidentCubit(this._incidentRepository)
      : super(
          const SelectIncidentState(
            false,
            null,
            null,
            SelectIncidentActions.loading,
          ),
        );

  final IncidentRepository _incidentRepository;
  loadCompanyIncidents() async {
    await Future.delayed(const Duration(milliseconds: 1));
    emit(
      const SelectIncidentState(
        true,
        null,
        null,
        SelectIncidentActions.loading,
      ),
    );
    var incidentList = await _incidentRepository.getAllCompanyIncident();
    incidentList.fold(
      (error) => emit(
        SelectIncidentState(
          false,
          error,
          null,
          SelectIncidentActions.error,
        ),
      ),
      (incidentList) => emit(
        SelectIncidentState(
            false, null, incidentList, SelectIncidentActions.loaded),
      ),
    );
  }
}
