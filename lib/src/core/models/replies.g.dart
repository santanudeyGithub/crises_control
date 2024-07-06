// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'replies.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RepliesResponse _$RepliesResponseFromJson(Map<String, dynamic> json) =>
    RepliesResponse(
      data: (json['Data'] as List<dynamic>)
          .map((e) => Reply.fromJson(e as Map<String, dynamic>))
          .toList(),
      errorCode: json['ErrorCode'] as String,
    );

Map<String, dynamic> _$RepliesResponseToJson(RepliesResponse instance) =>
    <String, dynamic>{
      'Data': instance.data,
      'ErrorCode': instance.errorCode,
    };

Reply _$ReplyFromJson(Map<String, dynamic> json) => Reply(
      firstName: json['FirstName'] as String,
      lastName: json['LastName'] as String,
      messageId: json['MessageId'] as int,
      messageText: json['MessageText'] as String,
      sentBy: SentBy.fromJson(json['SentBy'] as Map<String, dynamic>),
      priority: json['Priority'] as int,
      createdBy: json['CreatedBy'] as int,
      createdOn: DateTime.parse(json['CreatedOn'] as String),
      ackOptions: json['AckOptions'] as List<dynamic>,
      attachmentCount: json['AttachmentCount'] as int,
      sentByUser: json['SentByUser'] as bool,
      userPhoto: json['UserPhoto'] as String,
      hasReply: json['HasReply'] as int,
      replyCount: json['ReplyCount'] as int,
      parentId: json['ParentID'] as int,
      pendingAck: json['PendingAck'] as int,
      activeIncidentId: json['ActiveIncidentID'] as int,
      acknowledgedFlag: json['AcknowledgedFlag'] as int,
      messageType: json['MessageType'] as String,
      incidentStatus: json['IncidentStatus'] as int,
    );

Map<String, dynamic> _$ReplyToJson(Reply instance) => <String, dynamic>{
      'FirstName': instance.firstName,
      'LastName': instance.lastName,
      'MessageId': instance.messageId,
      'MessageText': instance.messageText,
      'SentBy': instance.sentBy,
      'Priority': instance.priority,
      'CreatedBy': instance.createdBy,
      'CreatedOn': instance.createdOn.toIso8601String(),
      'AckOptions': instance.ackOptions,
      'AttachmentCount': instance.attachmentCount,
      'SentByUser': instance.sentByUser,
      'UserPhoto': instance.userPhoto,
      'HasReply': instance.hasReply,
      'ReplyCount': instance.replyCount,
      'ParentID': instance.parentId,
      'PendingAck': instance.pendingAck,
      'ActiveIncidentID': instance.activeIncidentId,
      'AcknowledgedFlag': instance.acknowledgedFlag,
      'MessageType': instance.messageType,
      'IncidentStatus': instance.incidentStatus,
    };
