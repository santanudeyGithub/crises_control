import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'acknowledge_message_body.g.dart';

@JsonSerializable(fieldRename: FieldRename.pascal)
class AcknowledgeMessageBody extends Equatable {
  const AcknowledgeMessageBody({
    required this.msgListId,
    required this.responseId,
    required this.ackMethod,
    required this.userLocationLong,
    required this.userLocationLat,
    required this.companyKey,
  });

  final int msgListId;
  final int responseId;
  final String ackMethod;
  final String userLocationLong;
  final String userLocationLat;
  final String companyKey;

  factory AcknowledgeMessageBody.fromJson(Map<String, dynamic> json) =>
      _$AcknowledgeMessageBodyFromJson(json);

  Map<String, dynamic> toJson() => _$AcknowledgeMessageBodyToJson(this);
  

  @override
  List<Object?> get props => [
        msgListId,
        responseId,
        ackMethod,
        userLocationLong,
        userLocationLat,
        companyKey,
  ];
}
