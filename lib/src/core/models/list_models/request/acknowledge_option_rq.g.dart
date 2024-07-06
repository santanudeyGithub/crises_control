// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'acknowledge_option_rq.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AcknowledgeOptionRq _$AcknowledgeOptionRqFromJson(Map<String, dynamic> json) =>
    AcknowledgeOptionRq(
      responseId: json['ResponseId'] as int,
      responseLabel: json['ResponseLabel'] as String,
      responseCode: json['ResponseCode'] as int,
    );

Map<String, dynamic> _$AcknowledgeOptionRqToJson(
        AcknowledgeOptionRq instance) =>
    <String, dynamic>{
      'ResponseId': instance.responseId,
      'ResponseLabel': instance.responseLabel,
      'ResponseCode': instance.responseCode,
    };
