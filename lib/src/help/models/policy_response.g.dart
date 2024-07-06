// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'policy_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PolicyResponse _$PolicyResponseFromJson(Map<String, dynamic> json) =>
    PolicyResponse(
      result: json['Result'] as String,
      errorId: json['ErrorId'] as int,
      message: json['Message'] as String,
      errorCode: json['ErrorCode'],
      statusCode: json['StatusCode'] as String,
    );

Map<String, dynamic> _$PolicyResponseToJson(PolicyResponse instance) =>
    <String, dynamic>{
      'Result': instance.result,
      'ErrorId': instance.errorId,
      'Message': instance.message,
      'ErrorCode': instance.errorCode,
      'StatusCode': instance.statusCode,
    };
