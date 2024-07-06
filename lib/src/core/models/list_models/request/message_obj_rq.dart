import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'message_obj_rq.g.dart';

@JsonSerializable(fieldRename: FieldRename.pascal)
class MessageObjRq extends Equatable {
  const MessageObjRq({
    required this.objectMappingId,
    required this.sourceObjectPrimaryId,
  });

  final int objectMappingId;
  final int sourceObjectPrimaryId;

  factory MessageObjRq.fromJson(Map<String, dynamic> json) =>
      _$MessageObjRqFromJson(json);

  Map<String, dynamic> toJson() => _$MessageObjRqToJson(this);

  @override
  List<Object?> get props => [
        objectMappingId,
        sourceObjectPrimaryId,
      ];
}
