// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'users.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Users _$UsersFromJson(Map<String, dynamic> json) => Users(
      data: UserResponseData.fromJson(json['Data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UsersToJson(Users instance) => <String, dynamic>{
      'Data': instance.data,
    };

UserResponseData _$UserResponseDataFromJson(Map<String, dynamic> json) =>
    UserResponseData(
      draw: json['Draw'] as int,
      recordsTotal: json['RecordsTotal'] as int,
      recordsFiltered: json['RecordsFiltered'] as int,
      data: (json['Data'] as List<dynamic>)
          .map((e) => UserData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$UserResponseDataToJson(UserResponseData instance) =>
    <String, dynamic>{
      'Draw': instance.draw,
      'RecordsTotal': instance.recordsTotal,
      'RecordsFiltered': instance.recordsFiltered,
      'Data': instance.data,
    };

UserData _$UserDataFromJson(Map<String, dynamic> json) => UserData(
      userId: json['UserId'] as int,
      firstName: json['FirstName'] as String,
      lastName: json['LastName'] as String,
      mobileISDCode: json['MobileISDCode'] as String,
      mobileNo: json['MobileNo'] as String,
      LLISDCode: json['LLISDCode'] as String?,
      landline: json['Landline'] as String?,
      primaryEmail: json['PrimaryEmail'] as String,
      userPhoto: json['UserPhoto'] as String,
      userRole: $enumDecode(_$UserRoleEnumMap, json['UserRole']),
      uniqueGuiID: json['UniqueGuiID'] as String,
      registerUser: json['RegisterUser'] as bool,
      status: json['Status'] as int,
      updatedOn: DateTime.parse(json['UpdatedOn'] as String),
      description: json['Description'],
      companyId: json['CompanyId'] as int,
      departmentName: json['DepartmentName'],
    );

Map<String, dynamic> _$UserDataToJson(UserData instance) => <String, dynamic>{
      'UserId': instance.userId,
      'FirstName': instance.firstName,
      'LastName': instance.lastName,
      'MobileISDCode': instance.mobileISDCode,
      'MobileNo': instance.mobileNo,
      'LLISDCode': instance.LLISDCode,
      'Landline': instance.landline,
      'PrimaryEmail': instance.primaryEmail,
      'UserPhoto': instance.userPhoto,
      'UserRole': _$UserRoleEnumMap[instance.userRole]!,
      'UniqueGuiID': instance.uniqueGuiID,
      'RegisterUser': instance.registerUser,
      'Status': instance.status,
      'UpdatedOn': instance.updatedOn.toIso8601String(),
      'Description': instance.description,
      'CompanyId': instance.companyId,
      'DepartmentName': instance.departmentName,
    };

const _$UserRoleEnumMap = {
  UserRole.ADMIN: 'ADMIN',
  UserRole.USER: 'USER',
  UserRole.KEYHOLDER: 'KEYHOLDER',
  UserRole.SUPERADMIN: 'SUPERADMIN',
};
