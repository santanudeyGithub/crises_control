import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../core/models/list_models/request/request_models.dart';

part 'send_ping_body.g.dart';

@JsonSerializable(fieldRename: FieldRename.pascal)
class SendPingBody extends Equatable {
  const SendPingBody({
    required this.messageText,
    required this.ackOptions,
    required this.priority,
    required this.multiResponse,
    required this.messageType,
    required this.incidentActivationId,
    required this.pingMessageObjLst,
    required this.usersToNotify,
    required this.audioAssetId,
    required this.silentMessage,
    required this.messageMethod,
    required this.mediaAttachments,
    required this.socialHandle,
    required this.cascadePlanId,
    required this.sendToAllRecipient,
  });

  final String messageText;
  final List<AcknowledgeOptionRq> ackOptions;
  final int priority;
  final bool multiResponse;
  final String messageType;
  final int incidentActivationId;
  final List<MessageObjRq> pingMessageObjLst;
  final List<int> usersToNotify;
  final int audioAssetId;
  final bool silentMessage;
  final List<int> messageMethod;
  final List<dynamic> mediaAttachments;
  final List<dynamic> socialHandle;
  final int cascadePlanId;
  final bool sendToAllRecipient;

  factory SendPingBody.fromJson(Map<String, dynamic> json) =>
      _$SendPingBodyFromJson(json);

  Map<String, dynamic> toJson() => _$SendPingBodyToJson(this);

  @override
  List<Object?> get props => [
        messageText,
        ackOptions,
        priority,
        multiResponse,
        messageType,
        incidentActivationId,
        pingMessageObjLst,
        usersToNotify,
        audioAssetId,
        silentMessage,
        messageMethod,
        mediaAttachments,
        socialHandle,
        cascadePlanId,
        sendToAllRecipient,
      ];
}
