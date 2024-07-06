// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'incident_message_details.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MessageDetailsResponse _$MessageDetailsResponseFromJson(
        Map<String, dynamic> json) =>
    MessageDetailsResponse(
      data: (json['Data'] as List<dynamic>)
          .map((e) => MessageDetails.fromJson(e as Map<String, dynamic>))
          .toList(),
      errorCode: json['ErrorCode'] as String,
    );

Map<String, dynamic> _$MessageDetailsResponseToJson(
        MessageDetailsResponse instance) =>
    <String, dynamic>{
      'Data': instance.data,
      'ErrorCode': instance.errorCode,
    };

MessageDetails _$MessageDetailsFromJson(Map<String, dynamic> json) =>
    MessageDetails(
      firstName: json['FirstName'] as String,
      lastName: json['LastName'] as String,
      messageId: json['MessageId'] as int,
      messageText: json['MessageText'] as String,
      sentBy: SentBy.fromJson(json['SentBy'] as Map<String, dynamic>),
      multiResponse: json['MultiResponse'] as bool,
      priority: json['Priority'] as int,
      totalAck: json['TotalAck'] as int,
      totalNotAck: json['TotalNotAck'] as int,
      createdBy: json['CreatedBy'] as int,
      createdOn: DateTime.parse(json['CreatedOn'] as String),
      attachmentCount: json['AttachmentCount'] as int,
      hasReply: json['HasReply'] as int,
    );

Map<String, dynamic> _$MessageDetailsToJson(MessageDetails instance) =>
    <String, dynamic>{
      'FirstName': instance.firstName,
      'LastName': instance.lastName,
      'MessageId': instance.messageId,
      'MessageText': instance.messageText,
      'SentBy': instance.sentBy,
      'MultiResponse': instance.multiResponse,
      'Priority': instance.priority,
      'TotalAck': instance.totalAck,
      'TotalNotAck': instance.totalNotAck,
      'CreatedBy': instance.createdBy,
      'CreatedOn': instance.createdOn.toIso8601String(),
      'AttachmentCount': instance.attachmentCount,
      'HasReply': instance.hasReply,
    };
