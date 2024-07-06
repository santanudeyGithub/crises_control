// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ack_option.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AckOption _$AckOptionFromJson(Map<String, dynamic> json) => AckOption(
      responseId: json['ResponseId'] as int,
      responseLabel: json['ResponseLabel'] as String,
      responseCode: json['ResponseCode'] as int,
    );

Map<String, dynamic> _$AckOptionToJson(AckOption instance) => <String, dynamic>{
      'ResponseId': instance.responseId,
      'ResponseLabel': instance.responseLabel,
      'ResponseCode': instance.responseCode,
    };
