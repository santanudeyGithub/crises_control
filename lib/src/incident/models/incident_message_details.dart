import 'package:crises_control/src/core/models/sent_by.dart';
import 'package:crises_control/src/core/utils/date_time_helpers.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'incident_message_details.g.dart';

@JsonSerializable(fieldRename: FieldRename.pascal)
class MessageDetailsResponse extends Equatable {
  const MessageDetailsResponse({
    required this.data,
    required this.errorCode,
  });

  final List<MessageDetails> data;
  final String errorCode;

  factory MessageDetailsResponse.fromJson(Map<String, dynamic> json) =>
      _$MessageDetailsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$MessageDetailsResponseToJson(this);

  @override
  List<Object?> get props => [data, errorCode];
}

@JsonSerializable(fieldRename: FieldRename.pascal)
class MessageDetails extends Equatable {
  const MessageDetails({
    required this.firstName,
    required this.lastName,
    required this.messageId,
    required this.messageText,
    required this.sentBy,
    required this.multiResponse,
    required this.priority,
    required this.totalAck,
    required this.totalNotAck,
    required this.createdBy,
    required this.createdOn,
    required this.attachmentCount,
    required this.hasReply,
  });

  final String firstName;
  final String lastName;
  final int messageId;
  final String messageText;
  final SentBy sentBy;
  final bool multiResponse;
  final int priority;
  final int totalAck;
  final int totalNotAck;
  final int createdBy;
  final DateTime createdOn;
  final int attachmentCount;
  final int hasReply;

  //has attachment
  bool get hasAttachment => attachmentCount > 0;

  factory MessageDetails.fromJson(Map<String, dynamic> json) =>
      _$MessageDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$MessageDetailsToJson(this);

  @override
  List<Object?> get props => [
        firstName,
        lastName,
        messageId,
        messageText,
        sentBy,
        multiResponse,
        priority,
        totalAck,
        totalNotAck,
        createdBy,
        createdOn,
        attachmentCount,
        hasReply,
      ];

  //Full name
  String get fullName => '$firstName $lastName';
  //Launch date
  String get launchDate => DateTimeHelpers.getFormattedDateToString(createdOn);
}

