part of 'login_first_otp_cubit.dart';

abstract class LoginFirstOtpState extends Equatable {}

class LoginFirstOtpInitial extends LoginFirstOtpState {
  @override
  List<Object?> get props => [];
}

class LoginFirstOtpLoading extends LoginFirstOtpState {
  @override
  List<Object?> get props => [];
}

class SubmitOtpSuccess extends LoginFirstOtpState {
  @override
  List<Object?> get props => [];
}

class SubmitOtpFailure extends LoginFirstOtpState {
  SubmitOtpFailure(this.error);
  final CCError error;

  @override
  List<Object?> get props => [error];
}

class ResendOtpSuccess extends LoginFirstOtpState {
  @override
  List<Object?> get props => [];
}

class ResendOtpFailure extends LoginFirstOtpState {
  ResendOtpFailure(this.error);
  final CCError error;

  @override
  List<Object?> get props => [error];
}

class LoginFailure extends LoginFirstOtpState {
  LoginFailure(this.error);
  final CCError error;

  @override
  List<Object?> get props => [error];
}

class LoginSuccess extends LoginFirstOtpState {
  LoginSuccess(this.loginData, this.companies);
  final LoginData loginData;
  final List<Company> companies;

  @override
  List<Object?> get props => [loginData, companies];
}
