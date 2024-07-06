// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_info.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserInfoAdapter extends TypeAdapter<UserInfo> {
  @override
  final int typeId = 6;

  @override
  UserInfo read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserInfo(
      companyId: fields[0] as int,
      companyName: fields[1] as String,
      companyLogo: fields[2] as String,
      companyProfile: fields[3] as String,
      anniversaryDate: fields[4] as DateTime,
      userId: fields[5] as int,
      customerId: fields[6] as String,
      firstName: fields[7] as String,
      lastName: fields[8] as String,
      userMobileIsd: fields[9] as String,
      phoneIsdCode: fields[10] as String,
      mobileNo: fields[11] as String,
      primaryEmail: fields[12] as String,
      userPassword: fields[13] as String,
      userPhoto: fields[14] as String,
      uniqueGuiId: fields[15] as String,
      registerUser: fields[16] as bool,
      userRole: fields[17] as String,
      userLanguage: fields[18] as String,
      status: fields[19] as int,
      firstLogin: fields[20] as bool,
      companyPlanId: fields[21] as int,
      companyStatus: fields[22] as int,
      uniqueKey: fields[23] as String,
      portalTimeZone: fields[24] as String,
      activeOffDuty: fields[25] as int,
      timeZoneId: fields[26] as int,
      activation: fields[28] as int,
      secItems: (fields[29] as List).cast<SecurityItem>(),
      errorId: fields[30] as int,
      message: fields[31] as String,
    );
  }

  @override
  void write(BinaryWriter writer, UserInfo obj) {
    writer
      ..writeByte(31)
      ..writeByte(0)
      ..write(obj.companyId)
      ..writeByte(1)
      ..write(obj.companyName)
      ..writeByte(2)
      ..write(obj.companyLogo)
      ..writeByte(3)
      ..write(obj.companyProfile)
      ..writeByte(4)
      ..write(obj.anniversaryDate)
      ..writeByte(5)
      ..write(obj.userId)
      ..writeByte(6)
      ..write(obj.customerId)
      ..writeByte(7)
      ..write(obj.firstName)
      ..writeByte(8)
      ..write(obj.lastName)
      ..writeByte(9)
      ..write(obj.userMobileIsd)
      ..writeByte(10)
      ..write(obj.phoneIsdCode)
      ..writeByte(11)
      ..write(obj.mobileNo)
      ..writeByte(12)
      ..write(obj.primaryEmail)
      ..writeByte(13)
      ..write(obj.userPassword)
      ..writeByte(14)
      ..write(obj.userPhoto)
      ..writeByte(15)
      ..write(obj.uniqueGuiId)
      ..writeByte(16)
      ..write(obj.registerUser)
      ..writeByte(17)
      ..write(obj.userRole)
      ..writeByte(18)
      ..write(obj.userLanguage)
      ..writeByte(19)
      ..write(obj.status)
      ..writeByte(20)
      ..write(obj.firstLogin)
      ..writeByte(21)
      ..write(obj.companyPlanId)
      ..writeByte(22)
      ..write(obj.companyStatus)
      ..writeByte(23)
      ..write(obj.uniqueKey)
      ..writeByte(24)
      ..write(obj.portalTimeZone)
      ..writeByte(25)
      ..write(obj.activeOffDuty)
      ..writeByte(26)
      ..write(obj.timeZoneId)
      ..writeByte(28)
      ..write(obj.activation)
      ..writeByte(29)
      ..write(obj.secItems)
      ..writeByte(30)
      ..write(obj.errorId)
      ..writeByte(31)
      ..write(obj.message);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserInfoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class SecurityItemAdapter extends TypeAdapter<SecurityItem> {
  @override
  final int typeId = 7;

  @override
  SecurityItem read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SecurityItem(
      securityKey: fields[0] as String,
      code: fields[1] as String,
      name: fields[2] as String,
      updatedOn: fields[3] as DateTime,
      target: fields[4] as String,
      showOnTrial: fields[5] as bool,
      hasAccess: fields[6] as String,
    );
  }

  @override
  void write(BinaryWriter writer, SecurityItem obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.securityKey)
      ..writeByte(1)
      ..write(obj.code)
      ..writeByte(2)
      ..write(obj.name)
      ..writeByte(3)
      ..write(obj.updatedOn)
      ..writeByte(4)
      ..write(obj.target)
      ..writeByte(5)
      ..write(obj.showOnTrial)
      ..writeByte(6)
      ..write(obj.hasAccess);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SecurityItemAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserInfo _$UserInfoFromJson(Map<String, dynamic> json) => UserInfo(
      companyId: json['CompanyId'] as int,
      companyName: json['CompanyName'] as String,
      companyLogo: json['CompanyLogo'] as String,
      companyProfile: json['CompanyProfile'] as String,
      anniversaryDate: DateTime.parse(json['AnniversaryDate'] as String),
      userId: json['UserId'] as int,
      customerId: json['CustomerId'] as String,
      firstName: json['First_Name'] as String,
      lastName: json['Last_Name'] as String,
      userMobileIsd: json['UserMobileISD'] as String,
      phoneIsdCode: json['PhoneISDCode'] as String,
      mobileNo: json['MobileNo'] as String,
      primaryEmail: json['Primary_Email'] as String,
      userPassword: json['UserPassword'] as String,
      userPhoto: json['UserPhoto'] as String,
      uniqueGuiId: json['UniqueGuiId'] as String,
      registerUser: json['RegisterUser'] as bool,
      userRole: json['UserRole'] as String,
      userLanguage: json['UserLanguage'] as String,
      status: json['Status'] as int,
      firstLogin: json['FirstLogin'] as bool,
      companyPlanId: json['CompanyPlanId'] as int,
      companyStatus: json['CompanyStatus'] as int,
      uniqueKey: json['UniqueKey'] as String,
      portalTimeZone: json['PortalTimeZone'] as String,
      activeOffDuty: json['ActiveOffDuty'] as int,
      timeZoneId: json['TimeZoneId'] as int,
      activation: json['Activation'] as int,
      secItems: (json['SecItems'] as List<dynamic>)
          .map((e) => SecurityItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      errorId: json['ErrorId'] as int,
      message: json['Message'] as String,
    );

Map<String, dynamic> _$UserInfoToJson(UserInfo instance) => <String, dynamic>{
      'CompanyId': instance.companyId,
      'CompanyName': instance.companyName,
      'CompanyLogo': instance.companyLogo,
      'CompanyProfile': instance.companyProfile,
      'AnniversaryDate': instance.anniversaryDate.toIso8601String(),
      'UserId': instance.userId,
      'CustomerId': instance.customerId,
      'First_Name': instance.firstName,
      'Last_Name': instance.lastName,
      'UserMobileISD': instance.userMobileIsd,
      'PhoneISDCode': instance.phoneIsdCode,
      'MobileNo': instance.mobileNo,
      'Primary_Email': instance.primaryEmail,
      'UserPassword': instance.userPassword,
      'UserPhoto': instance.userPhoto,
      'UniqueGuiId': instance.uniqueGuiId,
      'RegisterUser': instance.registerUser,
      'UserRole': instance.userRole,
      'UserLanguage': instance.userLanguage,
      'Status': instance.status,
      'FirstLogin': instance.firstLogin,
      'CompanyPlanId': instance.companyPlanId,
      'CompanyStatus': instance.companyStatus,
      'UniqueKey': instance.uniqueKey,
      'PortalTimeZone': instance.portalTimeZone,
      'ActiveOffDuty': instance.activeOffDuty,
      'TimeZoneId': instance.timeZoneId,
      'Activation': instance.activation,
      'SecItems': instance.secItems,
      'ErrorId': instance.errorId,
      'Message': instance.message,
    };

SecurityItem _$SecurityItemFromJson(Map<String, dynamic> json) => SecurityItem(
      securityKey: json['SecurityKey'] as String,
      code: json['Code'] as String,
      name: json['Name'] as String,
      updatedOn: DateTime.parse(json['UpdatedOn'] as String),
      target: json['Target'] as String,
      showOnTrial: json['ShowOnTrial'] as bool,
      hasAccess: json['HasAccess'] as String,
    );

Map<String, dynamic> _$SecurityItemToJson(SecurityItem instance) =>
    <String, dynamic>{
      'SecurityKey': instance.securityKey,
      'Code': instance.code,
      'Name': instance.name,
      'UpdatedOn': instance.updatedOn.toIso8601String(),
      'Target': instance.target,
      'ShowOnTrial': instance.showOnTrial,
      'HasAccess': instance.hasAccess,
    };
