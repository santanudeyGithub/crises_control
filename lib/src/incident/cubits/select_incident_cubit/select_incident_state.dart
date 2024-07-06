part of 'select_incident_cubit.dart';

enum SelectIncidentActions { loaded, loading, select, none, error }

class SelectIncidentState extends Equatable {
  const SelectIncidentState(
      this.isLoading, this.error, this.incidentList, this.actions);

  final bool isLoading;
  final CCError? error;
  final IncidentListModel? incidentList;
  final SelectIncidentActions actions;

  @override
  List<Object?> get props => [isLoading, error, incidentList, actions];
}
