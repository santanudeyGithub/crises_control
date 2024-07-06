import 'package:crises_control/src/core/models/communication_models/company_comms_response.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'ping_info.g.dart';

@JsonSerializable(fieldRename: FieldRename.pascal)
class PingInfoResponse extends Equatable {
  const PingInfoResponse({
    required this.data,
    required this.errorCode,
  });

  final PingInfo data;
  final String errorCode;

  factory PingInfoResponse.fromJson(Map<String, dynamic> json) =>
      _$PingInfoResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PingInfoResponseToJson(this);

  @override
  List<Object?> get props => [data, errorCode];
}

@JsonSerializable(fieldRename: FieldRename.pascal)
class PingInfo extends Equatable {
  const PingInfo({
    required this.messageText,
    required this.priority,
    required this.assetId,
    required this.multiResponse,
    required this.trackUser,
    required this.silentMessage,
    required this.attachmentCount,
    required this.cascadePlanId,
    required this.ackOptions,
    required this.messageAttachments,
    required this.messageMethod,
    required this.pingNotificationList,
    required this.departmentToNotify,
    required this.usersToNotify,
  });

  final String messageText;
  final int priority;
  final int assetId;
  final bool multiResponse;
  final bool trackUser;
  final bool silentMessage;
  final int attachmentCount;
  @JsonKey(name: 'CascadePlanID')
  final int cascadePlanId;
  final List<dynamic> ackOptions;
  final dynamic messageAttachments;
  final List<MessageMethod> messageMethod;
  final List<dynamic> pingNotificationList;
  final List<dynamic> departmentToNotify;
  final List<UsersToNotify> usersToNotify;

  factory PingInfo.fromJson(Map<String, dynamic> json) =>
      _$PingInfoFromJson(json);

  Map<String, dynamic> toJson() => _$PingInfoToJson(this);

  @override
  List<Object?> get props => [
        messageText,
        priority,
        assetId,
        multiResponse,
        trackUser,
        silentMessage,
        attachmentCount,
        cascadePlanId,
        ackOptions,
        messageAttachments,
        messageMethod,
        pingNotificationList,
        departmentToNotify,
        usersToNotify,
      ];
}

@JsonSerializable(fieldRename: FieldRename.pascal)
class UsersToNotify extends Equatable {
  const UsersToNotify({
    required this.userId,
    required this.userName,
    required this.userPhoto,
    required this.firstName,
    required this.lastName,
  });

  final int userId;
  final String? userName;
  final String? userPhoto;
  final String? firstName;
  final String? lastName;

  factory UsersToNotify.fromJson(Map<String, dynamic> json) =>
      _$UsersToNotifyFromJson(json);

  Map<String, dynamic> toJson() => _$UsersToNotifyToJson(this);

  @override
  List<Object?> get props => [
        userId,
        userName,
        userPhoto,
        firstName,
        lastName,
      ];
}
