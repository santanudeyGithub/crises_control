// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'group_detail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GroupDetail _$GroupDetailFromJson(Map<String, dynamic> json) => GroupDetail(
      json['groupId'] as int,
      json['groupName'] as String,
      json['status'] as int,
      json['objectMappingId'] as int,
      json['activeUserCount'] as int,
      (json['users'] as List<dynamic>)
          .map((e) => User.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['createdByName'] as String,
      json['upatedByName'] as String,
      json['firstName'] as String,
      json['lastName'] as String,
      json['companyId'] as int,
      DateTime.parse(json['createdOn'] as String),
      DateTime.parse(json['updatedOn'] as String),
    );

Map<String, dynamic> _$GroupDetailToJson(GroupDetail instance) =>
    <String, dynamic>{
      'groupId': instance.groupId,
      'groupName': instance.groupName,
      'status': instance.status,
      'objectMappingId': instance.objectMappingId,
      'activeUserCount': instance.activeUserCount,
      'users': instance.users,
      'createdByName': instance.createdByName,
      'upatedByName': instance.upatedByName,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'companyId': instance.companyId,
      'createdOn': instance.createdOn.toIso8601String(),
      'updatedOn': instance.updatedOn.toIso8601String(),
    };
