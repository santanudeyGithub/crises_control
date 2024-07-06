// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_obj_rq.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MessageObjRq _$MessageObjRqFromJson(Map<String, dynamic> json) => MessageObjRq(
      objectMappingId: json['ObjectMappingId'] as int,
      sourceObjectPrimaryId: json['SourceObjectPrimaryId'] as int,
    );

Map<String, dynamic> _$MessageObjRqToJson(MessageObjRq instance) =>
    <String, dynamic>{
      'ObjectMappingId': instance.objectMappingId,
      'SourceObjectPrimaryId': instance.sourceObjectPrimaryId,
    };
