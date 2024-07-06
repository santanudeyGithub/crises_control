part of 'launch_incident_cubit.dart';

abstract class LaunchIncidentState extends Equatable {
  const LaunchIncidentState();
}

class LaunchIncidentDetailsLoading extends LaunchIncidentState {
  const LaunchIncidentDetailsLoading();
  @override
  List<Object?> get props => [];
}

class LaunchIncidentDetailsLoaded extends LaunchIncidentState {
  const LaunchIncidentDetailsLoaded(
    this.incidentDetailData,
    this.severityCommChannels1,
    this.severityCommChannels2,
    this.severityCommChannels3,
    this.severityCommChannels4,
    this.severityCommChannels5,
    this.allCommunicationChannels,
    this.allCascadingChannels,
    this.hasLowBalance,
  );
  final IncidentDetailData incidentDetailData;
  final List<SelectedCommunication> severityCommChannels1;
  final List<SelectedCommunication> severityCommChannels2;
  final List<SelectedCommunication> severityCommChannels3;
  final List<SelectedCommunication> severityCommChannels4;
  final List<SelectedCommunication> severityCommChannels5;
  final List<MessageMethod> allCommunicationChannels;
  final List<CascadingPlan> allCascadingChannels;
  final String? hasLowBalance;
  @override
  List<Object> get props => [
        incidentDetailData,
        severityCommChannels1,
        severityCommChannels2,
        severityCommChannels3,
        severityCommChannels4,
        severityCommChannels5,
        allCommunicationChannels,
        allCascadingChannels,
      ];
}

class LaunchIncidentDetailsError extends LaunchIncidentState {
  const LaunchIncidentDetailsError(this.error);
  final CCError error;

  @override
  List<Object?> get props => [error];
}

class LaunchIncidentInitial extends LaunchIncidentState {
  const LaunchIncidentInitial();
  @override
  List<Object?> get props => [];
}

class LaunchIncidentLoading extends LaunchIncidentState {
  const LaunchIncidentLoading();
  @override
  List<Object?> get props => [];
}

class LaunchIncidentError extends LaunchIncidentState {
  const LaunchIncidentError(this.error);
  final CCError error;

  @override
  List<Object?> get props => [error];
}

class LaunchIncidentErrorPop extends LaunchIncidentState {
  const LaunchIncidentErrorPop(this.error);
  final CCError error;
  @override
  List<Object?> get props => [error];
}

class LaunchIncidentLaunched extends LaunchIncidentState {
  const LaunchIncidentLaunched(this.message);
  final String message;
  @override
  List<Object?> get props => [message];
}
