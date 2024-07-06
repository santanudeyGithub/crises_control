import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'ping_message_obj.g.dart';


@JsonSerializable(fieldRename: FieldRename.pascal)
class PingMessageObj extends Equatable {
  const PingMessageObj({
    required this.objectMappingId,
    required this.sourceObjectPrimaryId,
  });
  final int objectMappingId;
  final int sourceObjectPrimaryId;

  factory PingMessageObj.fromJson(Map<String, dynamic> json) =>
      _$PingMessageObjFromJson(json);
  Map<String, dynamic> toJson() => _$PingMessageObjToJson(this);

  @override
  List<Object?> get props => [
        objectMappingId,
        sourceObjectPrimaryId,
      ];
}
