import 'package:json_annotation/json_annotation.dart';
part 'message_acknowledge_status_response.g.dart';

@JsonSerializable(fieldRename: FieldRename.pascal)
class MessageAcknowledgeStatusResponse {
  MessageAcknowledgeStatusResponse({
    required this.data,
    required this.errorCode,
  });

  final MessageAcknowledgeStatusData data;
  final String errorCode;

  factory MessageAcknowledgeStatusResponse.fromJson(
          Map<String, dynamic> json) =>
      _$MessageAcknowledgeStatusResponseFromJson(json);

  Map<String, dynamic> toJson() =>
      _$MessageAcknowledgeStatusResponseToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.pascal)
class MessageAcknowledgeStatusData {
  MessageAcknowledgeStatusData({
    required this.draw,
    required this.recordsTotal,
    required this.recordsFiltered,
    required this.data,
  });

  final int draw;
  final int recordsTotal;
  final int recordsFiltered;
  final List<MessageAcknowledgeStatus> data;

  factory MessageAcknowledgeStatusData.fromJson(Map<String, dynamic> json) =>
      _$MessageAcknowledgeStatusDataFromJson(json);
  Map<String, dynamic> toJson() => _$MessageAcknowledgeStatusDataToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.pascal)
class MessageAcknowledgeStatus {
  MessageAcknowledgeStatus({
    required this.dateAcknowledge,
    required this.messageSent,
    required this.dateSent,
    required this.messageAcknowledge,
    required this.messageLat,
    required this.messageLng,
    required this.acknowledgedUser,
    required this.firstName,
    required this.lastName,
    required this.userEmail,
    required this.primaryEmail,
    required this.isdCode,
    required this.mobileNo,
    required this.userStatus,
    required this.userMobile,
    required this.llisdCode,
    required this.landline,
    required this.userLandLine,
    required this.userId,
    required this.userPhoto,
    required this.messageAckStatus,
    required this.ackMethod,
    required this.isTaskRecepient,
    required this.responseLabel,
    required this.isSafetyResponse,
    required this.activeIncidentId,
    required this.channels,
    required this.activeUser,
  });

  final DateTime dateAcknowledge;
  final DateTime messageSent;
  final DateTime dateSent;
  final DateTime messageAcknowledge;
  final dynamic messageLat;
  final dynamic messageLng;
  final AcknowledgedUser acknowledgedUser;
  final String firstName;
  final String lastName;
  final String userEmail;
  final dynamic primaryEmail;
  @JsonKey(name: 'ISDCode')
  final String isdCode;
  final String mobileNo;
  final int userStatus;
  final UserPhone userMobile;
  @JsonKey(name: 'LLISDCode')
  final String llisdCode;
  final String landline;
  final UserPhone userLandLine;
  final int userId;
  final String userPhoto;
  final int messageAckStatus;
  final String ackMethod;
  final bool isTaskRecepient;
  final String responseLabel;
  final bool isSafetyResponse;
  @JsonKey(name: 'ActiveIncidentID')
  final int activeIncidentId;
  final dynamic channels;
  final bool activeUser;

  //full name
  String get fullName => '$firstName $lastName';

  //is acknowledged
  bool get isAcknowledged => messageAckStatus == 1;

  factory MessageAcknowledgeStatus.fromJson(Map<String, dynamic> json) =>
      _$MessageAcknowledgeStatusFromJson(json);
  Map<String, dynamic> toJson() => _$MessageAcknowledgeStatusToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.pascal)
class AcknowledgedUser {
  AcknowledgedUser({
    required this.firstname,
    required this.lastname,
  });

  final String firstname;
  final String lastname;

  factory AcknowledgedUser.fromJson(Map<String, dynamic> json) =>
      _$AcknowledgedUserFromJson(json);
  Map<String, dynamic> toJson() => _$AcknowledgedUserToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.pascal)
class UserPhone {
  UserPhone({
    required this.isd,
    required this.number,
  });

  @JsonKey(name: 'ISD')
  final String isd;
  final String number;

  factory UserPhone.fromJson(Map<String, dynamic> json) =>
      _$UserPhoneFromJson(json);
  Map<String, dynamic> toJson() => _$UserPhoneToJson(this);
}
