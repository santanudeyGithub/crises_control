// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reply_message_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReplyMessageResponse _$ReplyMessageResponseFromJson(
        Map<String, dynamic> json) =>
    ReplyMessageResponse(
      data: json['Data'],
      errorId: json['ErrorId'] as int?,
      message: json['Message'] as String,
      errorCode: json['ErrorCode'],
      statusCode: json['StatusCode'] as int,
    );

Map<String, dynamic> _$ReplyMessageResponseToJson(
        ReplyMessageResponse instance) =>
    <String, dynamic>{
      'Data': instance.data,
      'ErrorId': instance.errorId,
      'Message': instance.message,
      'ErrorCode': instance.errorCode,
      'StatusCode': instance.statusCode,
    };
