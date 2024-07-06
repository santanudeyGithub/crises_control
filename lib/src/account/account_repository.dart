import 'package:crises_control/src/core/errors/cc_error.dart';
import 'package:crises_control/src/core/models/user_info.dart';
import 'package:crises_control/src/login/services/authentication_database_service.dart';
import 'package:dartz/dartz.dart';

class AccountRepository {
  AccountRepository(
    this._authenticationDatabaseService,
  );
  final AuthenticationDatabaseService _authenticationDatabaseService;
  //Retrieve the users information
  Either<CCError, UserInfo> retrieveUserInfo() {
    var userInfo = _authenticationDatabaseService.retrieveUserInfo();
    if (userInfo != null) return Right(userInfo);
    return const Left(CCError());
  }
}
