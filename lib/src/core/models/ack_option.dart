import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'ack_option.g.dart';
@JsonSerializable(fieldRename: FieldRename.pascal)
class AckOption extends Equatable {
  const AckOption({
    required this.responseId,
    required this.responseLabel,
    required this.responseCode,
  });

  final int responseId;
  final String responseLabel;
  final int responseCode;

  factory AckOption.fromJson(Map<String, dynamic> json) =>
      _$AckOptionFromJson(json);

  Map<String, dynamic> toJson() => _$AckOptionToJson(this);

  @override
  List<Object?> get props => [responseId, responseLabel, responseCode];
}
