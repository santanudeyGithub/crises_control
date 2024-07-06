// ignore_for_file: constant_identifier_names

import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:intl_phone_field/countries.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_info.g.dart';

@JsonSerializable(fieldRename: FieldRename.pascal)
@HiveType(typeId: 6)
class UserInfo extends Equatable {
  const UserInfo({
    required this.companyId,
    required this.companyName,
    required this.companyLogo,
    required this.companyProfile,
    required this.anniversaryDate,
    required this.userId,
    required this.customerId,
    required this.firstName,
    required this.lastName,
    required this.userMobileIsd,
    required this.phoneIsdCode,
    required this.mobileNo,
    required this.primaryEmail,
    required this.userPassword,
    required this.userPhoto,
    required this.uniqueGuiId,
    required this.registerUser,
    required this.userRole,
    required this.userLanguage,
    required this.status,
    required this.firstLogin,
    required this.companyPlanId,
    required this.companyStatus,
    required this.uniqueKey,
    required this.portalTimeZone,
    required this.activeOffDuty,
    required this.timeZoneId,
    required this.activation,
    required this.secItems,
    required this.errorId,
    required this.message,
  });

  @HiveField(0)
  final int companyId;
  @HiveField(1)
  final String companyName;
  @HiveField(2)
  final String companyLogo;
  @HiveField(3)
  final String companyProfile;
  @HiveField(4)
  final DateTime anniversaryDate;
  @HiveField(5)
  final int userId;
  @HiveField(6)
  final String customerId;
  @HiveField(7)
  @JsonKey(name: 'First_Name')
  final String firstName;
  @HiveField(8)
  @JsonKey(name: 'Last_Name')
  final String lastName;
  @HiveField(9)
  @JsonKey(name: 'UserMobileISD')
  final String userMobileIsd;
  @HiveField(10)
  @JsonKey(name: 'PhoneISDCode')
  final String phoneIsdCode;
  @HiveField(11)
  final String mobileNo;
  @HiveField(12)
  @JsonKey(name: 'Primary_Email')
  final String primaryEmail;
  @HiveField(13)
  final String userPassword;
  @HiveField(14)
  final String userPhoto;
  @HiveField(15)
  final String uniqueGuiId;
  @HiveField(16)
  final bool registerUser;
  @HiveField(17)
  final String userRole;
  @HiveField(18)
  final String userLanguage;
  @HiveField(19)
  final int status;
  @HiveField(20)
  final bool firstLogin;
  @HiveField(21)
  final int companyPlanId;
  @HiveField(22)
  final int companyStatus;
  @HiveField(23)
  final String uniqueKey;
  @HiveField(24)
  final String portalTimeZone;
  @HiveField(25)
  final int activeOffDuty;
  @HiveField(26)
  final int timeZoneId;
  @HiveField(28)
  final int activation;
  @HiveField(29)
  final List<SecurityItem> secItems;
  @HiveField(30)
  final int errorId;
  @HiveField(31)
  final String message;

  factory UserInfo.fromJson(Map<String, dynamic> json) =>
      _$UserInfoFromJson(json);

  Map<String, dynamic> toJson() => _$UserInfoToJson(this);

  //fullname of the user
  String get fullName => '$firstName $lastName';
  //User initials
  String get initials => '${firstName[0]}${lastName[0]}';

  String get countryCode =>
      countries.where((element) => element.dialCode == dialCode).last.code;

  //dial code without ++ sign
  String get dialCode => userMobileIsd.substring(1);

  @override
  List<Object?> get props => [
        companyId,
        companyName,
        companyLogo,
        companyProfile,
        anniversaryDate,
        userId,
        customerId,
        firstName,
        lastName,
        userMobileIsd,
        phoneIsdCode,
        mobileNo,
        primaryEmail,
        userPassword,
        userPhoto,
        uniqueGuiId,
        registerUser,
        userRole,
        userLanguage,
        status,
        firstLogin,
        companyPlanId,
        companyStatus,
        uniqueKey,
        portalTimeZone,
        activeOffDuty,
        timeZoneId,
        activation,
        secItems,
        errorId,
        message,
      ];
}

@HiveType(typeId: 7)
@JsonSerializable(fieldRename: FieldRename.pascal)
class SecurityItem extends Equatable {
  const SecurityItem({
    required this.securityKey,
    required this.code,
    required this.name,
    required this.updatedOn,
    required this.target,
    required this.showOnTrial,
    required this.hasAccess,
  });
  @HiveField(0)
  final String securityKey;
  @HiveField(1)
  final String code;
  @HiveField(2)
  final String name;
  @HiveField(3)
  final DateTime updatedOn;
  @HiveField(4)
  final String target;
  @HiveField(5)
  final bool showOnTrial;
  @HiveField(6)
  final String hasAccess;

  //Convert has acesss to bool
  bool get hasAccessBool => hasAccess == 'true';

  factory SecurityItem.fromJson(Map<String, dynamic> json) =>
      _$SecurityItemFromJson(json);

  Map<String, dynamic> toJson() => _$SecurityItemToJson(this);

  @override
  List<Object?> get props => [
        securityKey,
        code,
        name,
        updatedOn,
        target,
        showOnTrial,
        hasAccess,
      ];
}
