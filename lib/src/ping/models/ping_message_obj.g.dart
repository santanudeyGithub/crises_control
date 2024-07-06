// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ping_message_obj.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PingMessageObj _$PingMessageObjFromJson(Map<String, dynamic> json) =>
    PingMessageObj(
      objectMappingId: json['ObjectMappingId'] as int,
      sourceObjectPrimaryId: json['SourceObjectPrimaryId'] as int,
    );

Map<String, dynamic> _$PingMessageObjToJson(PingMessageObj instance) =>
    <String, dynamic>{
      'ObjectMappingId': instance.objectMappingId,
      'SourceObjectPrimaryId': instance.sourceObjectPrimaryId,
    };
