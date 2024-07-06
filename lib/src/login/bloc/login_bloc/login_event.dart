part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();
}

class Login extends LoginEvent {
  const Login(this.username, this.password, this.rememberMe, this.customerId);
  final String username;
  final String password;
  final String customerId;
  final bool rememberMe;

  @override
  List<Object?> get props => [username, password, customerId, rememberMe];
}

class SendForgotPassword extends LoginEvent {
  const SendForgotPassword(this.customerId, this.email);

  final String customerId;
  final String email;

  @override
  List<Object> get props => [customerId, email];
}

class CheckBiometricsVisibility extends LoginEvent {
  @override
  List<Object?> get props => [];
}

class UseBiometrics extends LoginEvent {
  @override
  List<Object?> get props => [];
}
