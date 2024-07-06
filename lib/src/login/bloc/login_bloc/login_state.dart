part of 'login_bloc.dart';

@immutable
abstract class LoginState extends Equatable {}

class LoginInitial extends LoginState {
  @override
  List<Object?> get props => [];
}

class LoginLoading extends LoginState {
  @override
  List<Object?> get props => [];
}

class LoginFailure extends LoginState {
  LoginFailure(this.error);
  final CCError error;

  @override
  List<Object?> get props => [error];
}

class LoginSuccess extends LoginState {
  LoginSuccess();

  @override
  List<Object?> get props => [];
}

class LoginRemeberMe extends LoginState {
  LoginRemeberMe(this.credentials);

  final AuthenticationCredentials credentials;
  @override
  List<Object?> get props => [credentials];
}

class CheckBiometricVisibilityFailure extends LoginState {
  @override
  List<Object?> get props => [];
}

class CheckBiometricVisibilitySuccess extends LoginState {
  CheckBiometricVisibilitySuccess(this.showBiometric);
  final bool showBiometric;
  @override
  List<Object?> get props => [showBiometric];
}

class LoginBiometricFailure extends LoginState {
  @override
  List<Object?> get props => [];
}

class LoginBiometricSuccess extends LoginState {
  LoginBiometricSuccess(this.authenticationCredentialsList);
  final List<AuthenticationCredentials> authenticationCredentialsList;
  @override
  List<Object?> get props => [authenticationCredentialsList];
}
