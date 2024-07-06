// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'launched_incidents_cubit.dart';

enum LaunchedIncidentActions { loaded, loading, select, none, error }

class LaunchedIncidentsState extends Equatable {
  const LaunchedIncidentsState(
    this.activeIncidents,
    this.error,
    this.isLoading,
    this.actions,
  );
  final AllActiveIncidentsResponse? activeIncidents;
  final CCError? error;
  final bool isLoading;
  final LaunchedIncidentActions actions;

  @override
  List<Object?> get props => [activeIncidents, error, isLoading, actions];

  LaunchedIncidentsState copyWith({
    AllActiveIncidentsResponse? activeIncidents,
    CCError? error,
    bool? isLoading,
    LaunchedIncidentActions? actions,
  }) {
    return LaunchedIncidentsState(
      activeIncidents ?? this.activeIncidents,
      error ?? this.error,
      isLoading ?? this.isLoading,
      actions ?? this.actions,
    );
  }
}
