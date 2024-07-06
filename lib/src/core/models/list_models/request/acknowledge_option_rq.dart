import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'acknowledge_option_rq.g.dart';

@JsonSerializable(fieldRename: FieldRename.pascal)
class AcknowledgeOptionRq extends Equatable {
  const AcknowledgeOptionRq({
    required this.responseId,
    required this.responseLabel,
    required this.responseCode,
  });

  final int responseId;
  final String responseLabel;
  final int responseCode;

  factory AcknowledgeOptionRq.fromJson(Map<String, dynamic> json) =>
      _$AcknowledgeOptionRqFromJson(json);

  Map<String, dynamic> toJson() => _$AcknowledgeOptionRqToJson(this);

  @override
  List<Object?> get props => [
        responseId,
        responseLabel,
      ];
}
