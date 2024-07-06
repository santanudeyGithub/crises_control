part of 'login_first_time_bloc.dart';

abstract class LoginFirstTimeState extends Equatable {}

class LoginFirstTimeInitial extends LoginFirstTimeState {
  @override
  List<Object?> get props => [];
}

class LoginFirstTimeLoading extends LoginFirstTimeState {
  @override
  List<Object?> get props => [];
}

class SubmitNewPasswordFailure extends LoginFirstTimeState {
  SubmitNewPasswordFailure(this.error);
  final CCError error;

  @override
  List<Object?> get props => [error];
}

class SubmitNewPasswordSuccess extends LoginFirstTimeState {
  @override
  List<Object?> get props => [];
}
