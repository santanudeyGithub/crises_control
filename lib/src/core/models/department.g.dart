// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: unused_element

part of 'department.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Department _$DepartmentFromJson(Map<String, dynamic> json) => Department(
      json['departmentName'] as String?,
      json['userCount'] as int,
      json['departmentId'] as int,
      json['createdBy'] as int,
      DateTime.parse(json['createdOn'] as String),
      json['updateBy'] as int,
      DateTime.parse(json['updatedOn'] as String),
      json['companyId'] as int,
      json['status'] as int,
    );

Map<String, dynamic> _$DepartmentToJson(Department instance) =>
    <String, dynamic>{
      'departmentId': instance.departmentId,
      'departmentName': instance.departmentName,
      'createdBy': instance.createdBy,
      'createdOn': instance.createdOn.toIso8601String(),
      'updateBy': instance.updateBy,
      'updatedOn': instance.updatedOn.toIso8601String(),
      'companyId': instance.companyId,
      'status': instance.status,
      'userCount': instance.userCount,
    };
