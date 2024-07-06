// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'groups.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Groups _$GroupsFromJson(Map<String, dynamic> json) => Groups(
      data: (json['Data'] as List<dynamic>)
          .map((e) => GroupData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GroupsToJson(Groups instance) => <String, dynamic>{
      'Data': instance.data,
    };

GroupData _$GroupDataFromJson(Map<String, dynamic> json) => GroupData(
      groupId: json['GroupId'] as int,
      groupName: json['GroupName'] as String,
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

Map<String, dynamic> _$GroupDataToJson(GroupData instance) => <String, dynamic>{
      'GroupId': instance.groupId,
      'GroupName': instance.groupName,
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

CreatedByName _$CreatedByNameFromJson(Map<String, dynamic> json) =>
    CreatedByName(
      firstname: json['Firstname'] as String,
      lastname: json['Lastname'] as String,
    );

Map<String, dynamic> _$CreatedByNameToJson(CreatedByName instance) =>
    <String, dynamic>{
      'Firstname': instance.firstname,
      'Lastname': instance.lastname,
    };
