import 'package:crises_control/src/core/utils/colors_helper.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:json_annotation/json_annotation.dart';

part 'login_data.g.dart';

@JsonSerializable(fieldRename: FieldRename.pascal)
@HiveType(typeId: 4)
class LoginData extends Equatable {
  const LoginData({
    required this.firstLogin,
    required this.twoFactorLogin,
    required this.companyId,
    required this.userId,
    required this.customerId,
    required this.portal,
    required this.firstName,
    required this.lastName,
    required this.primaryEmail,
    required this.companyName,
    required this.uploadPath,
    required this.companyMasterPlan,
    required this.companyLoginLogo,
    required this.iosLogo,
    required this.androidLogo,
    required this.windowsLogo,
    required this.userDeviceId,
    required this.uniqueGuiId,
    required this.userRole,
    required this.userLanguage,
    required this.trackingStartTime,
    required this.trackingEndTime,
    required this.trackingInterval,
    required this.messageLength,
    required this.audioRecordMaxDuration,
    required this.uniqueKey,
    required this.forceUpdate,
  });

  @HiveField(0)
  final bool firstLogin;
  @HiveField(1)
  final bool twoFactorLogin;
  @HiveField(2)
  final int companyId;
  @HiveField(3)
  final int userId;
  @HiveField(4)
  final String customerId;
  @HiveField(5)
  final String portal;
  @HiveField(6)
  final String firstName;
  @HiveField(7)
  final String lastName;
  @HiveField(8)
  final String primaryEmail;
  @HiveField(9)
  final String companyName;
  @HiveField(10)
  final String uploadPath;
  @HiveField(11)
  final String companyMasterPlan;
  @HiveField(12)
  final String companyLoginLogo;
  @HiveField(13)
  final String iosLogo;
  @HiveField(14)
  final String androidLogo;
  @HiveField(15)
  final String windowsLogo;
  @HiveField(16)
  final int userDeviceId;
  @HiveField(17)
  final String uniqueGuiId;
  @HiveField(18)
  final String userRole;
  @HiveField(19)
  final String userLanguage;
  @HiveField(20)
  final DateTime trackingStartTime;
  @HiveField(21)
  final DateTime trackingEndTime;
  @HiveField(22)
  final int trackingInterval;
  @HiveField(23)
  final int messageLength;
  @HiveField(24)
  final int audioRecordMaxDuration;
  @HiveField(25)
  final String uniqueKey;
  @HiveField(26)
  final bool forceUpdate;

  //full name
  String get fullName => '$firstName $lastName';

  //Intials
  String get initials => '${firstName[0]}${lastName[0]}'.toUpperCase();

  //Users icon color
  Color get iconColor => ColorsHelper.colorFor(fullName);

  factory LoginData.fromJson(Map<String, dynamic> json) =>
      _$LoginDataFromJson(json);
  Map<String, dynamic> toJson() => _$LoginDataToJson(this);

  @override
  List<Object?> get props => [
        firstLogin,
        twoFactorLogin,
        companyId,
        userId,
        customerId,
        portal,
        firstName,
        lastName,
        primaryEmail,
        companyName,
        uploadPath,
        companyMasterPlan,
        companyLoginLogo,
        iosLogo,
        androidLogo,
        windowsLogo,
        userDeviceId,
        uniqueGuiId,
        userRole,
        userLanguage,
        trackingStartTime,
        trackingEndTime,
        trackingInterval,
        messageLength,
        audioRecordMaxDuration,
        uniqueKey,
        forceUpdate,
      ];
}
