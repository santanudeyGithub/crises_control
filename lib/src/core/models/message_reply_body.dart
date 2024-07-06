import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'message_reply_body.g.dart';

@JsonSerializable(fieldRename: FieldRename.pascal)
class MessageReplyBody extends Equatable {
  const MessageReplyBody({
    required this.parentId,
    required this.messageText,
    required this.replyTo,
    required this.messageType,
    required this.activeIncidentId,
    required this.messageMethod,
    required this.cascadePlanId,
    required this.currentUserId,
    required this.companyId,
    required this.timeZoneId,
  });

  @JsonKey(name: 'ParentID')
  final int parentId;
  final String messageText;
  final String replyTo;
  final String messageType;
  @JsonKey(name: 'ActiveIncidentID')
  final int activeIncidentId;
  final List<int> messageMethod;
  @JsonKey(name: 'CascadePlanID')
  final int cascadePlanId;
  final int currentUserId;
  final int companyId;
  final String timeZoneId;

  factory MessageReplyBody.fromJson(Map<String, dynamic> json) =>
      _$MessageReplyBodyFromJson(json);
  Map<String, dynamic> toJson() => _$MessageReplyBodyToJson(this);

  @override
  List<Object?> get props => [
        parentId,
        messageText,
        replyTo,
        messageType,
        activeIncidentId,
        messageMethod,
        cascadePlanId,
        currentUserId,
        companyId,
        timeZoneId,
      ];
}
