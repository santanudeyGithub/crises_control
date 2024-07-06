// ignore_for_file: non_constant_identifier_names
/*
import 'package:crises_control/src/core/models/sent_by.dart';
import 'package:crises_control/src/core/utils/date_time_helpers.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';


@JsonSerializable(fieldRename: FieldRename.pascal)
class SosResponse extends Equatable {
  const SosResponse({
    required this.UserId,
    required this.calllbackmethod,
  });
  final String UserId;
  final int calllbackmethod;

  factory SosResponse.fromJson(Map<String, dynamic> json) =>
      _$SosResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SosResponseToJson(this);

  @override
  List<Object?> get props => [data, errorCode];
}

@JsonSerializable(fieldRename: FieldRename.pascal)
class Reply extends Equatable {
  const Reply({
    required this.firstName,
    required this.lastName,
    required this.messageId,
    required this.messageText,
    required this.sentBy,
    required this.priority,
    required this.createdBy,
    required this.createdOn,
    required this.ackOptions,
    required this.attachmentCount,
    required this.sentByUser,
    required this.userPhoto,
    required this.hasReply,
    required this.replyCount,
    required this.parentId,
    required this.pendingAck,
    required this.activeIncidentId,
    required this.acknowledgedFlag,
    required this.messageType,
    required this.incidentStatus,
  });

  final String firstName;
  final String lastName;
  final int messageId;
  final String messageText;
  final SentBy sentBy;
  final int priority;
  final int createdBy;
  final DateTime createdOn;
  final List<dynamic> ackOptions;
  final int attachmentCount;
  final bool sentByUser;
  final String userPhoto;
  final int hasReply;
  final int replyCount;
  @JsonKey(name: 'ParentID')
  final int parentId;
  final int pendingAck;
  @JsonKey(name: 'ActiveIncidentID')
  final int activeIncidentId;
  final int acknowledgedFlag;
  final String messageType;
  final int incidentStatus;

  factory Reply.fromJson(Map<String, dynamic> json) => _$ReplyFromJson(json);
  Map<String, dynamic> toJson() => _$ReplyToJson(this);

  String get fullName => '$firstName $lastName';
  bool get hasAttachment => attachmentCount > 0;
  bool get hasReplies => replyCount > 0;
  bool get isAcknowledged => acknowledgedFlag == 1;
  String get sentOn => DateTimeHelpers.getFormattedDateToString(createdOn);

  @override
  List<Object?> get props => [
        firstName,
        lastName,
        messageId,
        messageText,
        sentBy,
        priority,
        createdBy,
        createdOn,
        ackOptions,
        attachmentCount,
        sentByUser,
        userPhoto,
        hasReply,
        replyCount,
        parentId,
        pendingAck,
        activeIncidentId,
        acknowledgedFlag,
        messageType,
        incidentStatus,
      ];
}
*/