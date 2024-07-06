part of 'help_cubit.dart';

abstract class HelpState extends Equatable {
  const HelpState();
}

class HelpInitial extends HelpState {
  const HelpInitial();

  @override
  List<Object?> get props => [];
}

class HelpError extends HelpState {
  const HelpError(this.error);
  final CCError error;

  @override
  List<Object?> get props => [error];
}

class HelpPolicy extends HelpState {
  const HelpPolicy(this.url, this.policyType);
  final String url;
  final PolicyType policyType;

  @override
  List<Object?> get props => [url, policyType];
}

class HelpLoading extends HelpState {
  const HelpLoading();

  @override
  List<Object?> get props => [];
}
