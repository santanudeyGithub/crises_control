import 'package:bloc/bloc.dart';
import 'package:crises_control/src/account/account_repository.dart';
import 'package:crises_control/src/core/errors/cc_error.dart';
import 'package:crises_control/src/core/models/user_info.dart';
import 'package:equatable/equatable.dart';

part 'account_state.dart';

class AccountCubit extends Cubit<AccountState> {
  AccountCubit(this._accountRepository)
      : super(const AccountState(null, null, true));
  final AccountRepository _accountRepository;

  void loadUsersDetails()  {
    final result = _accountRepository.retrieveUserInfo();
    result.fold(
      (error) => emit(AccountState(null, error, false)),
      (userInfo) => emit(AccountState(userInfo, null, true)),
    );
  }
}
