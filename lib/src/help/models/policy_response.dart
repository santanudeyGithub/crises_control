import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'policy_response.g.dart';

@JsonSerializable(fieldRename: FieldRename.pascal)
class PolicyResponse extends Equatable {
  const PolicyResponse({
    required this.result,
    required this.errorId,
    required this.message,
    required this.errorCode,
    required this.statusCode,
  });

  final String result;
  final int errorId;
  final String message;
  final dynamic errorCode;
  final String statusCode;

  factory PolicyResponse.fromJson(Map<String, dynamic> json) =>
      _$PolicyResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PolicyResponseToJson(this);

  @override
  List<Object?> get props => [
        result,
        errorId,
        message,
        errorCode,
        statusCode,
      ];
}
