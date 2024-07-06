import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:json_annotation/json_annotation.dart';

part 'ping.g.dart';

@JsonSerializable(fieldRename: FieldRename.pascal)
class PingResponse extends Equatable {
  const PingResponse({
    required this.data,
    required this.errorCode,
  });

  final List<PingData> data;
  final String errorCode;

  factory PingResponse.fromJson(Map<String, dynamic> json) =>
      _$PingResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PingResponseToJson(this);

  @override
  List<Object?> get props => [data, errorCode];
}

@HiveType(typeId: 9)
@JsonSerializable(fieldRename: FieldRename.pascal)
class PingData extends Equatable {
  const PingData({
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
    required this.acknowledgedFlag,
  });

  @HiveField(0)
  final String firstName;
  @HiveField(1)
  final String lastName;
  @HiveField(2)
  final int messageId;
  @HiveField(3)
  final String messageText;
  @HiveField(4)
  final SentBy sentBy;
  @HiveField(5)
  final bool multiResponse;
  @HiveField(6)
  final int priority;
  @HiveField(7)
  final int totalAck;
  @HiveField(8)
  final int totalNotAck;
  @HiveField(9)
  final int createdBy;
  @HiveField(10)
  final DateTime createdOn;
  @HiveField(11)
  final int attachmentCount;
  @HiveField(12)
  final int hasReply;
  @HiveField(13)
  final int acknowledgedFlag;

  //Is message acknowledged
  bool get isAcknowledged => acknowledgedFlag == 1;

  //have all users acknowledged the ping
  bool get isAcknowledgedByAll => totalNotAck == 0;

  //has attachments
  bool get hasAttachments => attachmentCount > 0;

  String get sentDate => DateFormat('dd/MM/yyyy hh:mm').format(createdOn);
  //sender full name
  String get senderFullName => '$firstName $lastName';

  //Has replies
  bool get hasReplies => hasReply > 0;

  factory PingData.fromJson(Map<String, dynamic> json) =>
      _$PingDataFromJson(json);
  Map<String, dynamic> toJson() => _$PingDataToJson(this);

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
}

@JsonSerializable(fieldRename: FieldRename.pascal)
class SentBy extends Equatable {
  const SentBy({
    required this.firstname,
    required this.lastname,
  });

  final String firstname;
  final String lastname;

  factory SentBy.fromJson(Map<String, dynamic> json) => _$SentByFromJson(json);
  Map<String, dynamic> toJson() => _$SentByToJson(this);

  @override
  List<Object?> get props => [firstname, lastname];
}

class MockPing {
  MockPing(this.message, this.sender, this.date, this.isAcknowledged);

  final String message;
  final String sender;
  final String date;
  final bool isAcknowledged;

  static List<MockPing> mockData = [
    MockPing(
        "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
        'Luca Pirolo',
        '7 Sep 2022 - 17:56',
        true),
    MockPing('Test Message', 'Luca Pirolo', '7 Sep 2022 - 17:56', false),
    MockPing('Test Message', 'Luca Pirolo', '7 Sep 2022 - 17:56', false),
    MockPing('Test Message', 'Luca Pirolo', '7 Sep 2022 - 17:56', false),
    MockPing('Test Message', 'Luca Pirolo', '7 Sep 2022 - 17:56', false),
    MockPing('Test Message', 'Luca Pirolo', '7 Sep 2022 - 17:56', false),
    MockPing('Test Message', 'Luca Pirolo', '7 Sep 2022 - 17:56', false),
    MockPing('Test Message', 'Luca Pirolo', '7 Sep 2022 - 17:56', false),
    MockPing('Test Message', 'Luca Pirolo', '7 Sep 2022 - 17:56', false),
    MockPing('Test Message', 'Luca Pirolo', '7 Sep 2022 - 17:56', false),
  ];
}
