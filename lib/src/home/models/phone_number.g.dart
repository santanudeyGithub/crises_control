// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'phone_number.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PhoneNumberData _$PhoneNumberDataFromJson(Map<String, dynamic> json) =>
    PhoneNumberData(
      phoneNumber: (json['PhoneNumber'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      errorId: json['ErrorId'] as int,
      message: json['Message'] as String,
      errorCode: json['ErrorCode'],
      statusCode: json['StatusCode'] as String,
    );

Map<String, dynamic> _$PhoneNumberDataToJson(PhoneNumberData instance) =>
    <String, dynamic>{
      'PhoneNumber': instance.phoneNumber,
      'ErrorId': instance.errorId,
      'Message': instance.message,
      'ErrorCode': instance.errorCode,
      'StatusCode': instance.statusCode,
    };
