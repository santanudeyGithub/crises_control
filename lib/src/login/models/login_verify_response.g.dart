// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_verify_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginVerifyResponse _$LoginVerifyResponseFromJson(Map<String, dynamic> json) =>
    LoginVerifyResponse(
      data: LoginData.fromJson(json['Data'] as Map<String, dynamic>),
      errorId: json['ErrorId'] as int?,
      message: json['Message'] as String?,
      errorCode: json['ErrorCode'] as String?,
      statusCode: json['StatusCode'] as String?,
    );

Map<String, dynamic> _$LoginVerifyResponseToJson(
        LoginVerifyResponse instance) =>
    <String, dynamic>{
      'Data': instance.data,
      'ErrorId': instance.errorId,
      'Message': instance.message,
      'ErrorCode': instance.errorCode,
      'StatusCode': instance.statusCode,
    };
