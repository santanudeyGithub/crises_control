// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'acknowledge_message_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AcknowledgeMessageBody _$AcknowledgeMessageBodyFromJson(
        Map<String, dynamic> json) =>
    AcknowledgeMessageBody(
      msgListId: json['MsgListId'] as int,
      responseId: json['ResponseId'] as int,
      ackMethod: json['AckMethod'] as String,
      userLocationLong: json['UserLocationLong'] as String,
      userLocationLat: json['UserLocationLat'] as String,
      companyKey: json['CompanyKey'] as String,
    );

Map<String, dynamic> _$AcknowledgeMessageBodyToJson(
        AcknowledgeMessageBody instance) =>
    <String, dynamic>{
      'MsgListId': instance.msgListId,
      'ResponseId': instance.responseId,
      'AckMethod': instance.ackMethod,
      'UserLocationLong': instance.userLocationLong,
      'UserLocationLat': instance.userLocationLat,
      'CompanyKey': instance.companyKey,
    };
