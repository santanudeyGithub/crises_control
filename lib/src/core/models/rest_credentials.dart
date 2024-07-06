import 'package:equatable/equatable.dart';

import 'login_data.dart';

class RestCredentials extends Equatable {
  const RestCredentials(
    this.accessToken,
    this.loginData,
  );

  final String accessToken;
  final LoginData loginData;
  @override
  List<Object?> get props => [accessToken,loginData];
}
