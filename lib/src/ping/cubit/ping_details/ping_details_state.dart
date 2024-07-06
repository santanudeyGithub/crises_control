part of 'ping_details_cubit.dart';

abstract class PingDetailsState extends Equatable {
  const PingDetailsState();
}

class PingDetailsInitial extends PingDetailsState {
  @override
  List<Object?> get props => [];
}

class PingDetailsLoading extends PingDetailsState {
  @override
  List<Object?> get props => [];
}

class PingDetailsFailure extends PingDetailsState {
  const PingDetailsFailure(this.error);
  final CCError error;

  @override
  List<Object?> get props => [error];
}

class PingDetailsLoaded extends PingDetailsState {
  const PingDetailsLoaded(this.pingInfo);
  final PingInfo pingInfo;

  @override
  List<Object> get props => [];
}

class PingDetailsReplied extends PingDetailsState {
  @override
  List<Object?> get props => [];
}

class PingDetailsReplies extends PingDetailsState {
  const PingDetailsReplies(this.replies);
  final List<Reply> replies;

  @override
  List<Object?> get props => [replies];
}

class PingDetailsCommunicationMethodsLoaded extends PingDetailsState {
  const PingDetailsCommunicationMethodsLoaded(
    this.communicationMethods,
    this.allCommunicationMethods,
  );
  final List<SelectedCommunication> communicationMethods;
  final List<MessageMethod> allCommunicationMethods;

  @override
  List<Object?> get props => [communicationMethods];
}
