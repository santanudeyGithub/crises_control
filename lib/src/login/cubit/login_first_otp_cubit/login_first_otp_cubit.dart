// ignore_for_file: unnecessary_set_literal

import 'package:bloc/bloc.dart';
import 'package:crises_control/src/companies/models/company.dart';
import 'package:crises_control/src/core/errors/cc_error.dart';
import 'package:crises_control/src/core/models/login_data.dart';
import 'package:crises_control/src/login/repository/login_repository.dart';
import 'package:equatable/equatable.dart';

part 'login_first_otp_state.dart';

class LoginFirstOtpCubit extends Cubit<LoginFirstOtpState> {
  LoginFirstOtpCubit(this._loginRepository) : super(LoginFirstOtpInitial());
  final LoginRepository _loginRepository;

  onSubmitOtp(
      {required String oldPassword,
      required String newPassword,
      required String otpCode,
      required String userName,
      required bool rememberMe,
      required String customerId}) async {
    emit(LoginFirstOtpLoading());
    //Submit otp
    final useOTPForPasswordResetResult =
        await _loginRepository.useOTPForPasswordReset(
      oldPassword,
      newPassword,
      otpCode,
    );

    useOTPForPasswordResetResult.fold(
        (error) => {
              emit(
                SubmitOtpFailure(error),
              ),
              emit(
                LoginFirstOtpInitial(),
              )
            }, (success) async {
      emit(SubmitOtpSuccess());

      //Login
      final loginResult = await _loginRepository.loginUserWithPassword(
        userName,
        newPassword,
        rememberMe,
        customerId,
      );
      loginResult.fold(
        (error) => {
          emit(LoginFailure(error)),
          emit(LoginFirstOtpInitial()),
        },
        (loginData) async {
          emit(LoginSuccess(loginData, const []));
        },
      );
    });
  }

  onResendOtp(String oldPassword, String newPassword, String otpCode) async {
    emit(LoginFirstOtpLoading());
    final useOTPForPasswordResetResult =
        await _loginRepository.resendOTPForPasswordReset(
      oldPassword,
      newPassword,
      otpCode,
    );

    useOTPForPasswordResetResult.fold(
      (error) => {
        emit(
          ResendOtpFailure(error),
        ),
        emit(
          LoginFirstOtpInitial(),
        )
      },
      (success) => emit(
        ResendOtpSuccess(),
      ),
    );
  }
}
