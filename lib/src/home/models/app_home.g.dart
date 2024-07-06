// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_home.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AppHomeAdapter extends TypeAdapter<AppHome> {
  @override
  final int typeId = 10;

  @override
  AppHome read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AppHome(
      data: fields[0] as AppData,
      message: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, AppHome obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.data)
      ..writeByte(1)
      ..write(obj.message);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppHomeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class AppDataAdapter extends TypeAdapter<AppData> {
  @override
  final int typeId = 11;

  @override
  AppData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AppData(
      pingCount: fields[0] as int,
      incidentCount: fields[1] as int,
      pingStat: fields[2] as int,
      incidentStat: fields[3] as int,
      usefulText: fields[4] as UsefulText,
      tutorialPath: fields[5] as String,
      termsAndConditionsUrl: fields[6] as String,
      privacyPolicyUrl: fields[7] as String,
      whatsNewUrl: fields[8] as String,
      copyRightInfo: fields[9] as String,
      companyText: fields[10] as String,
      myTaskUrl: fields[11] as String,
      hasTask: fields[12] as bool,
      companyParams: (fields[13] as List).cast<CompanyParam>(),
      messageMethods: (fields[14] as List).cast<dynamic>(),
      trackMeTravel: fields[15] as bool,
      trackMeIncident: fields[16] as bool,
      appIconUrl: (fields[17] as List).cast<AppIconUrl>(),
      inviteUrl: fields[18] as String,
      apiVersion: fields[19] as String,
      cCMessageLastUpdate: fields[20] as DateTime,
      companyMessageLastUpdate: fields[21] as DateTime,
      phoneVerifier: fields[22] as String,
      langLastUpdated: fields[23] as DateTime,
      phoneContactLogo: fields[24] as String,
      pingListThreshold: fields[25] as int,
      pingListLimit: fields[26] as int,
    );
  }

  @override
  void write(BinaryWriter writer, AppData obj) {
    writer
      ..writeByte(27)
      ..writeByte(0)
      ..write(obj.pingCount)
      ..writeByte(1)
      ..write(obj.incidentCount)
      ..writeByte(2)
      ..write(obj.pingStat)
      ..writeByte(3)
      ..write(obj.incidentStat)
      ..writeByte(4)
      ..write(obj.usefulText)
      ..writeByte(5)
      ..write(obj.tutorialPath)
      ..writeByte(6)
      ..write(obj.termsAndConditionsUrl)
      ..writeByte(7)
      ..write(obj.privacyPolicyUrl)
      ..writeByte(8)
      ..write(obj.whatsNewUrl)
      ..writeByte(9)
      ..write(obj.copyRightInfo)
      ..writeByte(10)
      ..write(obj.companyText)
      ..writeByte(11)
      ..write(obj.myTaskUrl)
      ..writeByte(12)
      ..write(obj.hasTask)
      ..writeByte(13)
      ..write(obj.companyParams)
      ..writeByte(14)
      ..write(obj.messageMethods)
      ..writeByte(15)
      ..write(obj.trackMeTravel)
      ..writeByte(16)
      ..write(obj.trackMeIncident)
      ..writeByte(17)
      ..write(obj.appIconUrl)
      ..writeByte(18)
      ..write(obj.inviteUrl)
      ..writeByte(19)
      ..write(obj.apiVersion)
      ..writeByte(20)
      ..write(obj.cCMessageLastUpdate)
      ..writeByte(21)
      ..write(obj.companyMessageLastUpdate)
      ..writeByte(22)
      ..write(obj.phoneVerifier)
      ..writeByte(23)
      ..write(obj.langLastUpdated)
      ..writeByte(24)
      ..write(obj.phoneContactLogo)
      ..writeByte(25)
      ..write(obj.pingListThreshold)
      ..writeByte(26)
      ..write(obj.pingListLimit);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class AppIconUrlAdapter extends TypeAdapter<AppIconUrl> {
  @override
  final int typeId = 12;

  @override
  AppIconUrl read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AppIconUrl(
      langCode: fields[0] as String,
      iconUrl: fields[1] as String,
      platform: fields[2] as Platform,
      lastUpdate: fields[3] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, AppIconUrl obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.langCode)
      ..writeByte(1)
      ..write(obj.iconUrl)
      ..writeByte(2)
      ..write(obj.platform)
      ..writeByte(3)
      ..write(obj.lastUpdate);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppIconUrlAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class CompanyParamAdapter extends TypeAdapter<CompanyParam> {
  @override
  final int typeId = 14;

  @override
  CompanyParam read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CompanyParam(
      name: fields[0] as String,
      value: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, CompanyParam obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.value);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CompanyParamAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class UsefulTextAdapter extends TypeAdapter<UsefulText> {
  @override
  final int typeId = 15;

  @override
  UsefulText read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UsefulText(
      title: fields[0] as String,
      description: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, UsefulText obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.description);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UsefulTextAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class PlatformAdapter extends TypeAdapter<Platform> {
  @override
  final int typeId = 13;

  @override
  Platform read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return Platform.android;
      case 1:
        return Platform.ios;
      case 2:
        return Platform.windows;
      default:
        return Platform.android;
    }
  }

  @override
  void write(BinaryWriter writer, Platform obj) {
    switch (obj) {
      case Platform.android:
        writer.writeByte(0);
        break;
      case Platform.ios:
        writer.writeByte(1);
        break;
      case Platform.windows:
        writer.writeByte(2);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PlatformAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppHome _$AppHomeFromJson(Map<String, dynamic> json) => AppHome(
      data: AppData.fromJson(json['Data'] as Map<String, dynamic>),
      message: json['Message'] as String,
    );

Map<String, dynamic> _$AppHomeToJson(AppHome instance) => <String, dynamic>{
      'Data': instance.data,
      'Message': instance.message,
    };

AppData _$AppDataFromJson(Map<String, dynamic> json) => AppData(
      pingCount: json['PingCount'] as int,
      incidentCount: json['IncidentCount'] as int,
      pingStat: json['PingStat'] as int,
      incidentStat: json['IncidentStat'] as int,
      usefulText:
          UsefulText.fromJson(json['UsefulText'] as Map<String, dynamic>),
      tutorialPath: json['TutorialPath'] as String,
      termsAndConditionsUrl: json['TermsAndConditionsUrl'] as String,
      privacyPolicyUrl: json['PrivacyPolicyUrl'] as String,
      whatsNewUrl: json['WhatsNewUrl'] as String,
      copyRightInfo: json['CopyRightInfo'] as String,
      companyText: json['CompanyText'] as String,
      myTaskUrl: json['MyTaskUrl'] as String,
      hasTask: json['HasTask'] as bool,
      companyParams: (json['CompanyParams'] as List<dynamic>)
          .map((e) => CompanyParam.fromJson(e as Map<String, dynamic>))
          .toList(),
      messageMethods: json['MessageMethods'] as List<dynamic>,
      trackMeTravel: json['TrackMeTravel'] as bool,
      trackMeIncident: json['TrackMeIncident'] as bool,
      appIconUrl: (json['AppIconUrl'] as List<dynamic>)
          .map((e) => AppIconUrl.fromJson(e as Map<String, dynamic>))
          .toList(),
      inviteUrl: json['InviteUrl'] as String,
      apiVersion: json['ApiVersion'] as String,
      cCMessageLastUpdate:
          DateTime.parse(json['CCMessageLastUpdate'] as String),
      companyMessageLastUpdate:
          DateTime.parse(json['CompanyMessageLastUpdate'] as String),
      phoneVerifier: json['PhoneVerifier'] as String,
      langLastUpdated: DateTime.parse(json['LangLastUpdated'] as String),
      phoneContactLogo: json['PhoneContactLogo'] as String,
      pingListThreshold: json['PingListThreshold'] as int,
      pingListLimit: json['PingListLimit'] as int,
    );

Map<String, dynamic> _$AppDataToJson(AppData instance) => <String, dynamic>{
      'PingCount': instance.pingCount,
      'IncidentCount': instance.incidentCount,
      'PingStat': instance.pingStat,
      'IncidentStat': instance.incidentStat,
      'UsefulText': instance.usefulText,
      'TutorialPath': instance.tutorialPath,
      'TermsAndConditionsUrl': instance.termsAndConditionsUrl,
      'PrivacyPolicyUrl': instance.privacyPolicyUrl,
      'WhatsNewUrl': instance.whatsNewUrl,
      'CopyRightInfo': instance.copyRightInfo,
      'CompanyText': instance.companyText,
      'MyTaskUrl': instance.myTaskUrl,
      'HasTask': instance.hasTask,
      'CompanyParams': instance.companyParams,
      'MessageMethods': instance.messageMethods,
      'TrackMeTravel': instance.trackMeTravel,
      'TrackMeIncident': instance.trackMeIncident,
      'AppIconUrl': instance.appIconUrl,
      'InviteUrl': instance.inviteUrl,
      'ApiVersion': instance.apiVersion,
      'CCMessageLastUpdate': instance.cCMessageLastUpdate.toIso8601String(),
      'CompanyMessageLastUpdate':
          instance.companyMessageLastUpdate.toIso8601String(),
      'PhoneVerifier': instance.phoneVerifier,
      'LangLastUpdated': instance.langLastUpdated.toIso8601String(),
      'PhoneContactLogo': instance.phoneContactLogo,
      'PingListThreshold': instance.pingListThreshold,
      'PingListLimit': instance.pingListLimit,
    };

AppIconUrl _$AppIconUrlFromJson(Map<String, dynamic> json) => AppIconUrl(
      langCode: json['LangCode'] as String,
      iconUrl: json['IconUrl'] as String,
      platform: $enumDecode(_$PlatformEnumMap, json['Platform']),
      lastUpdate: DateTime.parse(json['LastUpdate'] as String),
    );

Map<String, dynamic> _$AppIconUrlToJson(AppIconUrl instance) =>
    <String, dynamic>{
      'LangCode': instance.langCode,
      'IconUrl': instance.iconUrl,
      'Platform': _$PlatformEnumMap[instance.platform]!,
      'LastUpdate': instance.lastUpdate.toIso8601String(),
    };

const _$PlatformEnumMap = {
  Platform.android: 'android',
  Platform.ios: 'ios',
  Platform.windows: 'windows',
};

CompanyParam _$CompanyParamFromJson(Map<String, dynamic> json) => CompanyParam(
      name: json['Name'] as String,
      value: json['Value'] as String,
    );

Map<String, dynamic> _$CompanyParamToJson(CompanyParam instance) =>
    <String, dynamic>{
      'Name': instance.name,
      'Value': instance.value,
    };

UsefulText _$UsefulTextFromJson(Map<String, dynamic> json) => UsefulText(
      title: json['Title'] as String,
      description: json['Description'] as String,
    );

Map<String, dynamic> _$UsefulTextToJson(UsefulText instance) =>
    <String, dynamic>{
      'Title': instance.title,
      'Description': instance.description,
    };
