part of 'new_ping_cubit.dart';

abstract class NewPingState extends Equatable {
  const NewPingState();
}

class NewPingInitial extends NewPingState {
  @override
  List<Object?> get props => [];
}

class NewPingLoading extends NewPingState {
  @override
  List<Object?> get props => [];
}

class NewPingLoaded extends NewPingState {
  const NewPingLoaded(
    this.messageMethods,
    this.lowPriorityMethods,
    this.mediumPriorityMethods,
    this.highPriorityMethods,
    this.cascadingPlans,
    this.hasLowBalance,
  );
  final List<MessageMethod> messageMethods;
  final List<SelectedCommunication> lowPriorityMethods;
  final List<SelectedCommunication> mediumPriorityMethods;
  final List<SelectedCommunication> highPriorityMethods;
  final List<CascadingPlan> cascadingPlans;
  final String? hasLowBalance;

  @override
  List<Object?> get props => [
        messageMethods,
        lowPriorityMethods,
        mediumPriorityMethods,
        highPriorityMethods,
        cascadingPlans,
        hasLowBalance,
      ];
}

class NewPingError extends NewPingState {
  const NewPingError(this.error);
  final CCError error;
  @override
  List<Object?> get props => [error];
}

class NewPingErrorPop extends NewPingState {
  const NewPingErrorPop(this.error);
  final CCError error;
  @override
  List<Object?> get props => [error];
}

class NewPingLaunched extends NewPingState {
  const NewPingLaunched(this.message);
  final String message;
  @override
  List<Object?> get props => [message];
}
