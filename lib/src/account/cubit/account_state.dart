part of 'account_cubit.dart';

class AccountState extends Equatable {
  const AccountState(this.userInfo, this.error, this.isLoading);
  final UserInfo? userInfo;
  final CCError? error;
  final bool isLoading;

  @override
  List<Object?> get props => [userInfo, error, isLoading];
}
