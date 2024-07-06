import 'package:crises_control/src/core/models/communication_models/selected_communication.dart';
import 'package:json_annotation/json_annotation.dart';

part 'company_comms_response.g.dart';

@JsonSerializable(fieldRename: FieldRename.pascal)
class CompanyCommsResponse {
  CompanyCommsResponse({
    required this.data,
    required this.errorCode,
  });

  final CompanyCommsResponseData data;
  final String errorCode;

  factory CompanyCommsResponse.fromJson(Map<String, dynamic> json) =>
      _$CompanyCommsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CompanyCommsResponseToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.pascal)
class CompanyCommsResponseData {
  CompanyCommsResponseData({
    required this.priority,
    required this.priorityMethod,
    required this.objectInfo,
    required this.billUsers,
    required this.hasLowBalance,
  });

  final List<Priority> priority;
  final List<PriorityMethod> priorityMethod;
  final List<MessageMethod> objectInfo;
  final List<BillUser> billUsers;
  final String hasLowBalance;

  factory CompanyCommsResponseData.fromJson(Map<String, dynamic> json) =>
      _$CompanyCommsResponseDataFromJson(json);

  Map<String, dynamic> toJson() => _$CompanyCommsResponseDataToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.pascal)
class BillUser {
  BillUser({
    required this.userId,
    required this.userName,
  });

  final int userId;
  final UserName userName;

  factory BillUser.fromJson(Map<String, dynamic> json) =>
      _$BillUserFromJson(json);

  Map<String, dynamic> toJson() => _$BillUserToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.pascal)
class UserName {
  UserName({
    required this.firstname,
    required this.lastname,
  });

  final String firstname;
  final String lastname;

  factory UserName.fromJson(Map<String, dynamic> json) =>
      _$UserNameFromJson(json);

  Map<String, dynamic> toJson() => _$UserNameToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.pascal)
class MessageMethod {
  MessageMethod({
    required this.methodId,
    required this.serviceStatus,
    required this.status,
    required this.methodName,
  });

  final int methodId;
  final bool serviceStatus;
  final int status;
  final String methodName;

  factory MessageMethod.fromJson(Map<String, dynamic> json) =>
      _$MessageMethodFromJson(json);

  Map<String, dynamic> toJson() => _$MessageMethodToJson(this);

  SelectedCommunication toSelectedCommunication() {
    return SelectedCommunication(methodId, methodName, false);
  }
}

@JsonSerializable(fieldRename: FieldRename.pascal)
class Priority {
  Priority({
    required this.id,
    required this.companyId,
    required this.cascadingPlanId,
    required this.messageType,
    required this.priority,
    required this.interval,
    required this.methods,
  });

  final int id;
  final int companyId;
  final int? cascadingPlanId;
  final String messageType;
  final int priority;
  final int interval;
  final String methods;

  factory Priority.fromJson(Map<String, dynamic> json) =>
      _$PriorityFromJson(json);

  Map<String, dynamic> toJson() => _$PriorityToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.pascal)
class PriorityMethod {
  PriorityMethod({
    required this.id,
    required this.companyId,
    required this.priorityLevel,
    required this.methods,
    required this.messageType,
  });

  final int id;
  final int companyId;
  final int priorityLevel;
  final String methods;
  final String messageType;

  factory PriorityMethod.fromJson(Map<String, dynamic> json) =>
      _$PriorityMethodFromJson(json);

  Map<String, dynamic> toJson() => _$PriorityMethodToJson(this);
}
