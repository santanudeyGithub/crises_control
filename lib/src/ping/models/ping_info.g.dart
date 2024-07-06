// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ping_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PingInfoResponse _$PingInfoResponseFromJson(Map<String, dynamic> json) =>
    PingInfoResponse(
      data: PingInfo.fromJson(json['Data'] as Map<String, dynamic>),
      errorCode: json['ErrorCode'] as String,
    );

Map<String, dynamic> _$PingInfoResponseToJson(PingInfoResponse instance) =>
    <String, dynamic>{
      'Data': instance.data,
      'ErrorCode': instance.errorCode,
    };

PingInfo _$PingInfoFromJson(Map<String, dynamic> json) => PingInfo(
      messageText: json['MessageText'] as String,
      priority: json['Priority'] as int,
      assetId: json['AssetId'] as int,
      multiResponse: json['MultiResponse'] as bool,
      trackUser: json['TrackUser'] as bool,
      silentMessage: json['SilentMessage'] as bool,
      attachmentCount: json['AttachmentCount'] as int,
      cascadePlanId: json['CascadePlanID'] as int,
      ackOptions: json['AckOptions'] as List<dynamic>,
      messageAttachments: json['MessageAttachments'],
      messageMethod: (json['MessageMethod'] as List<dynamic>)
          .map((e) => MessageMethod.fromJson(e as Map<String, dynamic>))
          .toList(),
      pingNotificationList: json['PingNotificationList'] as List<dynamic>,
      departmentToNotify: json['DepartmentToNotify'] as List<dynamic>,
      usersToNotify: (json['UsersToNotify'] as List<dynamic>)
          .map((e) => UsersToNotify.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PingInfoToJson(PingInfo instance) => <String, dynamic>{
      'MessageText': instance.messageText,
      'Priority': instance.priority,
      'AssetId': instance.assetId,
      'MultiResponse': instance.multiResponse,
      'TrackUser': instance.trackUser,
      'SilentMessage': instance.silentMessage,
      'AttachmentCount': instance.attachmentCount,
      'CascadePlanID': instance.cascadePlanId,
      'AckOptions': instance.ackOptions,
      'MessageAttachments': instance.messageAttachments,
      'MessageMethod': instance.messageMethod,
      'PingNotificationList': instance.pingNotificationList,
      'DepartmentToNotify': instance.departmentToNotify,
      'UsersToNotify': instance.usersToNotify,
    };

UsersToNotify _$UsersToNotifyFromJson(Map<String, dynamic> json) =>
    UsersToNotify(
      userId: json['UserId'] as int,
      userName: json['UserName'] as String?,
      userPhoto: json['UserPhoto'] as String?,
      firstName: json['FirstName'] as String?,
      lastName: json['LastName'] as String?,
    );

Map<String, dynamic> _$UsersToNotifyToJson(UsersToNotify instance) =>
    <String, dynamic>{
      'UserId': instance.userId,
      'UserName': instance.userName,
      'UserPhoto': instance.userPhoto,
      'FirstName': instance.firstName,
      'LastName': instance.lastName,
    };
