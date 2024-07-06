// ignore_for_file: constant_identifier_names

import 'package:hive_flutter/hive_flutter.dart';
import 'package:json_annotation/json_annotation.dart';

part 'app_home.g.dart';

@HiveType(typeId: 10)
@JsonSerializable(fieldRename: FieldRename.pascal)
class AppHome {
  AppHome({
    required this.data,
    required this.message,
  });

  @HiveField(0)
  final AppData data;
  @HiveField(1)
  final String message;

  factory AppHome.fromJson(Map<String, dynamic> json) =>
      _$AppHomeFromJson(json);
  Map<String, dynamic> toJson() => _$AppHomeToJson(this);
}

@HiveType(typeId: 11)
@JsonSerializable(fieldRename: FieldRename.pascal)
class AppData {
  AppData({
    required this.pingCount,
    required this.incidentCount,
    required this.pingStat,
    required this.incidentStat,
    required this.usefulText,
    required this.tutorialPath,
    required this.termsAndConditionsUrl,
    required this.privacyPolicyUrl,
    required this.whatsNewUrl,
    required this.copyRightInfo,
    required this.companyText,
    required this.myTaskUrl,
    required this.hasTask,
    required this.companyParams,
    required this.messageMethods,
    required this.trackMeTravel,
    required this.trackMeIncident,
    required this.appIconUrl,
    required this.inviteUrl,
    required this.apiVersion,
    required this.cCMessageLastUpdate,
    required this.companyMessageLastUpdate,
    required this.phoneVerifier,
    required this.langLastUpdated,
    required this.phoneContactLogo,
    required this.pingListThreshold,
    required this.pingListLimit,
  });

  @HiveField(0)
  final int pingCount;
  @HiveField(1)
  final int incidentCount;
  @HiveField(2)
  final int pingStat;
  @HiveField(3)
  final int incidentStat;
  @HiveField(4)
  final UsefulText usefulText;
  @HiveField(5)
  final String tutorialPath;
  @HiveField(6)
  final String termsAndConditionsUrl;
  @HiveField(7)
  final String privacyPolicyUrl;
  @HiveField(8)
  final String whatsNewUrl;
  @HiveField(9)
  final String copyRightInfo;
  @HiveField(10)
  final String companyText;
  @HiveField(11)
  final String myTaskUrl;
  @HiveField(12)
  final bool hasTask;
  @HiveField(13)
  final List<CompanyParam> companyParams;
  @HiveField(14)
  final List<dynamic> messageMethods;
  @HiveField(15)
  final bool trackMeTravel;
  @HiveField(16)
  final bool trackMeIncident;
  @HiveField(17)
  final List<AppIconUrl> appIconUrl;
  @HiveField(18)
  final String inviteUrl;
  @HiveField(19)
  final String apiVersion;
  @HiveField(20)
  final DateTime cCMessageLastUpdate;
  @HiveField(21)
  final DateTime companyMessageLastUpdate;
  @HiveField(22)
  final String phoneVerifier;
  @HiveField(23)
  final DateTime langLastUpdated;
  @HiveField(24)
  final String phoneContactLogo;
  @HiveField(25)
  final int pingListThreshold;
  @HiveField(26)
  final int pingListLimit;

  factory AppData.fromJson(Map<String, dynamic> json) =>
      _$AppDataFromJson(json);
  Map<String, dynamic> toJson() => _$AppDataToJson(this);
}

@HiveType(typeId: 12)
@JsonSerializable(fieldRename: FieldRename.pascal)
class AppIconUrl {
  AppIconUrl({
    required this.langCode,
    required this.iconUrl,
    required this.platform,
    required this.lastUpdate,
  });

  @HiveField(0)
  final String langCode;
  @HiveField(1)
  final String iconUrl;
  @HiveField(2)
  final Platform platform;
  @HiveField(3)
  final DateTime lastUpdate;
  factory AppIconUrl.fromJson(Map<String, dynamic> json) =>
      _$AppIconUrlFromJson(json);
  Map<String, dynamic> toJson() => _$AppIconUrlToJson(this);
}

@HiveType(typeId: 13)
enum Platform {
  @HiveField(0)
  android,
  @HiveField(1)
  ios,
  @HiveField(2)
  windows
}

@HiveType(typeId: 14)
@JsonSerializable(fieldRename: FieldRename.pascal)
class CompanyParam {
  CompanyParam({
    required this.name,
    required this.value,
  });

  @HiveField(0)
  final String name;
  @HiveField(1)
  final String value;

  factory CompanyParam.fromJson(Map<String, dynamic> json) =>
      _$CompanyParamFromJson(json);
  Map<String, dynamic> toJson() => _$CompanyParamToJson(this);
}

@HiveType(typeId: 15)
@JsonSerializable(fieldRename: FieldRename.pascal)
class UsefulText {
  UsefulText({
    required this.title,
    required this.description,
  });

  @HiveField(0)
  final String title;
  @HiveField(1)
  final String description;

  factory UsefulText.fromJson(Map<String, dynamic> json) =>
      _$UsefulTextFromJson(json);
  Map<String, dynamic> toJson() => _$UsefulTextToJson(this);
}
