import 'package:bloc/bloc.dart';
import 'package:crises_control/src/core/models/authentication_credentials.dart';
import 'package:crises_control/src/core/errors/cc_error.dart';
import 'package:crises_control/src/login/repository/login_repository.dart';
import 'package:crises_control/src/login/services/biometric_service.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc(this._loginRepository, this._biometricService)
      : super(LoginInitial()) {
    on<Login>(onLogin);
    on<UseBiometrics>(onUseBiometrics);
    on<CheckBiometricsVisibility>(onCheckShowBiometric);
      on<SendForgotPassword>(onForgotPassword);
  }
  final LoginRepository _loginRepository;
  final BiometricService _biometricService;

  onLogin(event, emit) async {
    emit(LoginLoading());
    final loginResult = await _loginRepository.loginUserWithPassword(
      event.username,
      event.password,
      event.rememberMe,
      event.customerId,
    );

    loginResult.fold(
      (error) => {
        emit(LoginFailure(error)),
        emit(LoginInitial()),
      },
      (loginData) async {
        emit(LoginSuccess());
      },
    );
  }

  onUseBiometrics(event, emit) async {
    emit(LoginLoading());
    final authenticateResult = await _biometricService.authenticate();
    if (authenticateResult) {
      var authenticationCredentialsList =
          _loginRepository.getAuthenticationCredentialsBiometrics();
      emit(LoginBiometricSuccess(authenticationCredentialsList));
    } else {
      emit(LoginBiometricFailure());
    }
  }

  onCheckShowBiometric(event, emit) async {
    try {
      bool canCheckBiometrics = await _biometricService.checkBiometrics();
      if (canCheckBiometrics) {
        var authenticationCredentialsList =
            _loginRepository.getAuthenticationCredentialsBiometrics();
        authenticationCredentialsList.isNotEmpty
            ? emit(CheckBiometricVisibilitySuccess(true))
            : emit(CheckBiometricVisibilitySuccess(false));
      } else {
        emit(CheckBiometricVisibilitySuccess(false));
      }
    } on Exception {
      emit(CheckBiometricVisibilityFailure());
    }
  }
  
   onForgotPassword(event, emit) async {
    emit(LoginLoading());    
    final forgotPasswordResult = await _loginRepository.forgotPassword(
      event.customerId,
      event.email
    );

    forgotPasswordResult.fold(
      (error) => {        
        emit(LoginFailure(error)),
        emit(LoginInitial()),
      },
      (loginData) async {
        emit(LoginSuccess());
      },
    );
  }
}
