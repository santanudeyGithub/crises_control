// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_data.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LoginDataAdapter extends TypeAdapter<LoginData> {
  @override
  final int typeId = 4;

  @override
  LoginData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return LoginData(
      firstLogin: fields[0] as bool,
      twoFactorLogin: fields[1] as bool,
      companyId: fields[2] as int,
      userId: fields[3] as int,
      customerId: fields[4] as String,
      portal: fields[5] as String,
      firstName: fields[6] as String,
      lastName: fields[7] as String,
      primaryEmail: fields[8] as String,
      companyName: fields[9] as String,
      uploadPath: fields[10] as String,
      companyMasterPlan: fields[11] as String,
      companyLoginLogo: fields[12] as String,
      iosLogo: fields[13] as String,
      androidLogo: fields[14] as String,
      windowsLogo: fields[15] as String,
      userDeviceId: fields[16] as int,
      uniqueGuiId: fields[17] as String,
      userRole: fields[18] as String,
      userLanguage: fields[19] as String,
      trackingStartTime: fields[20] as DateTime,
      trackingEndTime: fields[21] as DateTime,
      trackingInterval: fields[22] as int,
      messageLength: fields[23] as int,
      audioRecordMaxDuration: fields[24] as int,
      uniqueKey: fields[25] as String,
      forceUpdate: fields[26] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, LoginData obj) {
    writer
      ..writeByte(27)
      ..writeByte(0)
      ..write(obj.firstLogin)
      ..writeByte(1)
      ..write(obj.twoFactorLogin)
      ..writeByte(2)
      ..write(obj.companyId)
      ..writeByte(3)
      ..write(obj.userId)
      ..writeByte(4)
      ..write(obj.customerId)
      ..writeByte(5)
      ..write(obj.portal)
      ..writeByte(6)
      ..write(obj.firstName)
      ..writeByte(7)
      ..write(obj.lastName)
      ..writeByte(8)
      ..write(obj.primaryEmail)
      ..writeByte(9)
      ..write(obj.companyName)
      ..writeByte(10)
      ..write(obj.uploadPath)
      ..writeByte(11)
      ..write(obj.companyMasterPlan)
      ..writeByte(12)
      ..write(obj.companyLoginLogo)
      ..writeByte(13)
      ..write(obj.iosLogo)
      ..writeByte(14)
      ..write(obj.androidLogo)
      ..writeByte(15)
      ..write(obj.windowsLogo)
      ..writeByte(16)
      ..write(obj.userDeviceId)
      ..writeByte(17)
      ..write(obj.uniqueGuiId)
      ..writeByte(18)
      ..write(obj.userRole)
      ..writeByte(19)
      ..write(obj.userLanguage)
      ..writeByte(20)
      ..write(obj.trackingStartTime)
      ..writeByte(21)
      ..write(obj.trackingEndTime)
      ..writeByte(22)
      ..write(obj.trackingInterval)
      ..writeByte(23)
      ..write(obj.messageLength)
      ..writeByte(24)
      ..write(obj.audioRecordMaxDuration)
      ..writeByte(25)
      ..write(obj.uniqueKey)
      ..writeByte(26)
      ..write(obj.forceUpdate);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LoginDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginData _$LoginDataFromJson(Map<String, dynamic> json) => LoginData(
      firstLogin: json['FirstLogin'] as bool,
      twoFactorLogin: json['TwoFactorLogin'] as bool,
      companyId: json['CompanyId'] as int,
      userId: json['UserId'] as int,
      customerId: json['CustomerId'] as String,
      portal: json['Portal'] as String,
      firstName: json['FirstName'] as String,
      lastName: json['LastName'] as String,
      primaryEmail: json['PrimaryEmail'] as String,
      companyName: json['CompanyName'] as String,
      uploadPath: json['UploadPath'] as String,
      companyMasterPlan: json['CompanyMasterPlan'] as String,
      companyLoginLogo: json['CompanyLoginLogo'] as String,
      iosLogo: json['IosLogo'] as String,
      androidLogo: json['AndroidLogo'] as String,
      windowsLogo: json['WindowsLogo'] as String,
      userDeviceId: json['UserDeviceId'] as int,
      uniqueGuiId: json['UniqueGuiId'] as String,
      userRole: json['UserRole'] as String,
      userLanguage: json['UserLanguage'] as String,
      trackingStartTime: DateTime.parse(json['TrackingStartTime'] as String),
      trackingEndTime: DateTime.parse(json['TrackingEndTime'] as String),
      trackingInterval: json['TrackingInterval'] as int,
      messageLength: json['MessageLength'] as int,
      audioRecordMaxDuration: json['AudioRecordMaxDuration'] as int,
      uniqueKey: json['UniqueKey'] as String,
      forceUpdate: json['ForceUpdate'] as bool,
    );

Map<String, dynamic> _$LoginDataToJson(LoginData instance) => <String, dynamic>{
      'FirstLogin': instance.firstLogin,
      'TwoFactorLogin': instance.twoFactorLogin,
      'CompanyId': instance.companyId,
      'UserId': instance.userId,
      'CustomerId': instance.customerId,
      'Portal': instance.portal,
      'FirstName': instance.firstName,
      'LastName': instance.lastName,
      'PrimaryEmail': instance.primaryEmail,
      'CompanyName': instance.companyName,
      'UploadPath': instance.uploadPath,
      'CompanyMasterPlan': instance.companyMasterPlan,
      'CompanyLoginLogo': instance.companyLoginLogo,
      'IosLogo': instance.iosLogo,
      'AndroidLogo': instance.androidLogo,
      'WindowsLogo': instance.windowsLogo,
      'UserDeviceId': instance.userDeviceId,
      'UniqueGuiId': instance.uniqueGuiId,
      'UserRole': instance.userRole,
      'UserLanguage': instance.userLanguage,
      'TrackingStartTime': instance.trackingStartTime.toIso8601String(),
      'TrackingEndTime': instance.trackingEndTime.toIso8601String(),
      'TrackingInterval': instance.trackingInterval,
      'MessageLength': instance.messageLength,
      'AudioRecordMaxDuration': instance.audioRecordMaxDuration,
      'UniqueKey': instance.uniqueKey,
      'ForceUpdate': instance.forceUpdate,
    };
