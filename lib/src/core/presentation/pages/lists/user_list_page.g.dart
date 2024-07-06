// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_list_page.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SelectedUser _$SelectedUserFromJson(Map<String, dynamic> json) => SelectedUser(
      json['UserId'] as int,
      json['FullName'] as String,
    );

Map<String, dynamic> _$SelectedUserToJson(SelectedUser instance) =>
    <String, dynamic>{
      'UserId': instance.userId,
      'FullName': instance.fullName,
    };
