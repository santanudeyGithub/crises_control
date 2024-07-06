// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'send_ping_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SendPingBody _$SendPingBodyFromJson(Map<String, dynamic> json) => SendPingBody(
      messageText: json['MessageText'] as String,
      ackOptions: (json['AckOptions'] as List<dynamic>)
          .map((e) => AcknowledgeOptionRq.fromJson(e as Map<String, dynamic>))
          .toList(),
      priority: json['Priority'] as int,
      multiResponse: json['MultiResponse'] as bool,
      messageType: json['MessageType'] as String,
      incidentActivationId: json['IncidentActivationId'] as int,
      pingMessageObjLst: (json['PingMessageObjLst'] as List<dynamic>)
          .map((e) => MessageObjRq.fromJson(e as Map<String, dynamic>))
          .toList(),
      usersToNotify: (json['UsersToNotify'] as List<dynamic>)
          .map((e) => e as int)
          .toList(),
      audioAssetId: json['AudioAssetId'] as int,
      silentMessage: json['SilentMessage'] as bool,
      messageMethod: (json['MessageMethod'] as List<dynamic>)
          .map((e) => e as int)
          .toList(),
      mediaAttachments: json['MediaAttachments'] as List<dynamic>,
      socialHandle: json['SocialHandle'] as List<dynamic>,
      cascadePlanId: json['CascadePlanId'] as int,
      sendToAllRecipient: json['SendToAllRecipient'] as bool,
    );

Map<String, dynamic> _$SendPingBodyToJson(SendPingBody instance) =>
    <String, dynamic>{
      'MessageText': instance.messageText,
      'AckOptions': instance.ackOptions,
      'Priority': instance.priority,
      'MultiResponse': instance.multiResponse,
      'MessageType': instance.messageType,
      'IncidentActivationId': instance.incidentActivationId,
      'PingMessageObjLst': instance.pingMessageObjLst,
      'UsersToNotify': instance.usersToNotify,
      'AudioAssetId': instance.audioAssetId,
      'SilentMessage': instance.silentMessage,
      'MessageMethod': instance.messageMethod,
      'MediaAttachments': instance.mediaAttachments,
      'SocialHandle': instance.socialHandle,
      'CascadePlanId': instance.cascadePlanId,
      'SendToAllRecipient': instance.sendToAllRecipient,
    };
