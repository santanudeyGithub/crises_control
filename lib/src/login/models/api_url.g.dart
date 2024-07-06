// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_url.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ApiUrl _$ApiUrlFromJson(Map<String, dynamic> json) => ApiUrl(
      apiUrl: json['ApiUrl'] as String?,
      errorId: json['ErrorId'] as int?,
      errorCode: json['ErrorCode'] as String?,
      message: json['Message'] as String?,
    );

Map<String, dynamic> _$ApiUrlToJson(ApiUrl instance) => <String, dynamic>{
      'ErrorId': instance.errorId,
      'ErrorCode': instance.errorCode,
      'Message': instance.message,
      'ApiUrl': instance.apiUrl,
    };
