// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_reply_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MessageReplyBody _$MessageReplyBodyFromJson(Map<String, dynamic> json) =>
    MessageReplyBody(
      parentId: json['ParentID'] as int,
      messageText: json['MessageText'] as String,
      replyTo: json['ReplyTo'] as String,
      messageType: json['MessageType'] as String,
      activeIncidentId: json['ActiveIncidentID'] as int,
      messageMethod: (json['MessageMethod'] as List<dynamic>)
          .map((e) => e as int)
          .toList(),
      cascadePlanId: json['CascadePlanID'] as int,
      currentUserId: json['CurrentUserId'] as int,
      companyId: json['CompanyId'] as int,
      timeZoneId: json['TimeZoneId'] as String,
    );

Map<String, dynamic> _$MessageReplyBodyToJson(MessageReplyBody instance) =>
    <String, dynamic>{
      'ParentID': instance.parentId,
      'MessageText': instance.messageText,
      'ReplyTo': instance.replyTo,
      'MessageType': instance.messageType,
      'ActiveIncidentID': instance.activeIncidentId,
      'MessageMethod': instance.messageMethod,
      'CascadePlanID': instance.cascadePlanId,
      'CurrentUserId': instance.currentUserId,
      'CompanyId': instance.companyId,
      'TimeZoneId': instance.timeZoneId,
    };
