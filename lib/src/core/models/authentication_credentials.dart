import 'package:hive/hive.dart';
part 'authentication_credentials.g.dart';

@HiveType(typeId: 1)
class AuthenticationCredentials {
  AuthenticationCredentials(
    this.email,
    this.password,
    this.customerId,
    this.rememberMe,
    this.companyName,
    this.companyLogo,
  );

  @HiveField(0)
  final String email;

  @HiveField(2)
  final String password;

  @HiveField(3)
  final String customerId;

  @HiveField(4)
  final bool rememberMe;

  @HiveField(5)
  final String companyName;

  @HiveField(6)
  final String companyLogo;
}
