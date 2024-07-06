part of 'login_first_time_bloc.dart';

abstract class LoginFirstTimeEvent extends Equatable {
  const LoginFirstTimeEvent();
}

class SubmitNewPassword extends LoginFirstTimeEvent {
  const SubmitNewPassword(this.oldPassword, this.newPassword);
  final String oldPassword;
  final String newPassword;

  @override
  List<Object?> get props => [oldPassword, newPassword];
}
