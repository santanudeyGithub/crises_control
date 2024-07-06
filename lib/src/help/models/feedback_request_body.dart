import 'package:json_annotation/json_annotation.dart';

part 'feedback_request_body.g.dart';

@JsonSerializable(fieldRename: FieldRename.pascal)
class FeedbackRequestBody {
  FeedbackRequestBody({
    required this.deviceType,
    required this.deviceOs,
    required this.deviceModel,
    required this.feedbackMessage,
    required this.userEmail,
  });

  final int deviceType;
  final String deviceOs;
  final String deviceModel;
  final String feedbackMessage;
  final String userEmail;

  factory FeedbackRequestBody.fromJson(Map<String, dynamic> json) =>
      _$FeedbackRequestBodyFromJson(json);

  Map<String, dynamic> toJson() => _$FeedbackRequestBodyToJson(this);
}
