// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'departments.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Departments _$DepartmentsFromJson(Map<String, dynamic> json) => Departments(
      data: (json['Data'] as List<dynamic>)
          .map((e) => DepartmentsData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$DepartmentsToJson(Departments instance) =>
    <String, dynamic>{
      'Data': instance.data,
    };

DepartmentsData _$DepartmentsDataFromJson(Map<String, dynamic> json) =>
    DepartmentsData(
      departmentId: json['DepartmentId'] as int,
      departmentName: json['DepartmentName'] as String,
      status: json['Status'] as int,
      objectMappingId: json['ObjectMappingId'] as int,
      userCount: json['UserCount'] as int,
      activeUserCount: json['ActiveUserCount'] as int,
      userList: json['UserList'],
      createdByName:
          CreatedByName.fromJson(json['CreatedByName'] as Map<String, dynamic>),
      updatedByName: json['UpdatedByName'],
      firstName: json['FirstName'] as String,
      lastName: json['LastName'] as String,
      companyId: json['CompanyId'] as int,
      createdOn: DateTime.parse(json['CreatedOn'] as String),
      updatedOn: DateTime.parse(json['UpdatedOn'] as String),
    );

Map<String, dynamic> _$DepartmentsDataToJson(DepartmentsData instance) =>
    <String, dynamic>{
      'DepartmentId': instance.departmentId,
      'DepartmentName': instance.departmentName,
      'Status': instance.status,
      'ObjectMappingId': instance.objectMappingId,
      'UserCount': instance.userCount,
      'ActiveUserCount': instance.activeUserCount,
      'UserList': instance.userList,
      'CreatedByName': instance.createdByName,
      'UpdatedByName': instance.updatedByName,
      'FirstName': instance.firstName,
      'LastName': instance.lastName,
      'CompanyId': instance.companyId,
      'CreatedOn': instance.createdOn.toIso8601String(),
      'UpdatedOn': instance.updatedOn.toIso8601String(),
    };
