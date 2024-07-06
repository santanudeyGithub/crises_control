import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'reply_message_response.g.dart';

@JsonSerializable(fieldRename: FieldRename.pascal)
class ReplyMessageResponse extends Equatable {
  const ReplyMessageResponse({
    required this.data,
    required this.errorId,
    required this.message,
    required this.errorCode,
    required this.statusCode,
  });

  final dynamic data;
  final int? errorId;
  final String message;
  final dynamic errorCode;
  final int statusCode;

  factory ReplyMessageResponse.fromJson(Map<String, dynamic> json) =>
      _$ReplyMessageResponseFromJson(json);
  Map<String, dynamic> toJson() => _$ReplyMessageResponseToJson(this);

  @override
  List<Object?> get props => [
        data,
        errorId,
        message,
        errorCode,
        statusCode,
      ];
}
