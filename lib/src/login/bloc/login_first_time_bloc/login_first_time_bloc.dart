import 'package:bloc/bloc.dart';
import 'package:crises_control/src/core/errors/cc_error.dart';
import 'package:crises_control/src/login/repository/login_repository.dart';
import 'package:equatable/equatable.dart';

part 'login_first_time_event.dart';
part 'login_first_time_state.dart';

class LoginFirstTimeBloc extends Bloc<LoginFirstTimeEvent, LoginFirstTimeState> {
  LoginFirstTimeBloc(this._loginRepository) : super(LoginFirstTimeInitial()) {
    on<SubmitNewPassword>(onSubmitNewPassword);
  }
  final LoginRepository _loginRepository;

  onSubmitNewPassword(event, emit) async {
    emit(LoginFirstTimeLoading());
    final retrieveOTPResult = await _loginRepository.requestOTPForPasswordReset(
      event.oldPassword,
      event.newPassword,
    );

    retrieveOTPResult.fold(
      (error) => {
        emit(
          SubmitNewPasswordFailure(error),
        ),
        emit(
          LoginFirstTimeInitial(),
        )
      },
      (success) => emit(
        SubmitNewPasswordSuccess(),
      ),
    );
  }
}
