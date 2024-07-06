// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'launch_incident_request_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LaunchIncidentRequestBody _$LaunchIncidentRequestBodyFromJson(
        Map<String, dynamic> json) =>
    LaunchIncidentRequestBody(
      incidentId: json['IncidentId'] as int,
      incidentActivationId: json['IncidentActivationId'] as int,
      description: json['Description'] as String,
      severity: json['Severity'] as int,
      multiResponse: json['MultiResponse'] as bool,
      ackOptions: (json['AckOptions'] as List<dynamic>)
          .map((e) => AcknowledgeOptionRq.fromJson(e as Map<String, dynamic>))
          .toList(),
      impactedLocations: (json['ImpactedLocations'] as List<dynamic>)
          .map((e) => e as int)
          .toList(),
      userRole: json['UserRole'] as String,
      audioAssetId: json['AudioAssetId'] as int,
      trackUser: json['TrackUser'] as bool,
      silentMessage: json['SilentMessage'] as bool,
      messageMethod: (json['MessageMethod'] as List<dynamic>)
          .map((e) => e as int)
          .toList(),
      numberOfKeyHolder: json['NumberOfKeyHolder'] as int,
      initiateIncidentActionLst:
          json['InitiateIncidentActionLst'] as List<dynamic>,
      initiateIncidentKeyHldLst:
          (json['InitiateIncidentKeyHldLst'] as List<dynamic>)
              .map((e) => SelectedUser.fromJson(e as Map<String, dynamic>))
              .toList(),
      initiateIncidentNotificationObjLst:
          (json['InitiateIncidentNotificationObjLst'] as List<dynamic>)
              .map((e) => MessageObjRq.fromJson(e as Map<String, dynamic>))
              .toList(),
      affectedLocations: (json['AffectedLocations'] as List<dynamic>)
          .map((e) => LocationsData.fromJson(e as Map<String, dynamic>))
          .toList(),
      usersToNotify: (json['UsersToNotify'] as List<dynamic>)
          .map((e) => e as int)
          .toList(),
      launchMode: json['LaunchMode'] as int,
      socialHandle: json['SocialHandle'] as List<dynamic>,
      source: json['Source'] as String,
      cascadePlanId: json['CascadePlanId'] as int,
      incidentKeyholder: json['IncidentKeyholder'] as List<dynamic>,
    );

Map<String, dynamic> _$LaunchIncidentRequestBodyToJson(
        LaunchIncidentRequestBody instance) =>
    <String, dynamic>{
      'IncidentId': instance.incidentId,
      'IncidentActivationId': instance.incidentActivationId,
      'Description': instance.description,
      'Severity': instance.severity,
      'MultiResponse': instance.multiResponse,
      'AckOptions': instance.ackOptions,
      'ImpactedLocations': instance.impactedLocations,
      'UserRole': instance.userRole,
      'AudioAssetId': instance.audioAssetId,
      'TrackUser': instance.trackUser,
      'SilentMessage': instance.silentMessage,
      'MessageMethod': instance.messageMethod,
      'NumberOfKeyHolder': instance.numberOfKeyHolder,
      'InitiateIncidentActionLst': instance.initiateIncidentActionLst,
      'InitiateIncidentKeyHldLst': instance.initiateIncidentKeyHldLst,
      'InitiateIncidentNotificationObjLst':
          instance.initiateIncidentNotificationObjLst,
      'AffectedLocations': instance.affectedLocations,
      'UsersToNotify': instance.usersToNotify,
      'LaunchMode': instance.launchMode,
      'SocialHandle': instance.socialHandle,
      'Source': instance.source,
      'CascadePlanId': instance.cascadePlanId,
      'IncidentKeyholder': instance.incidentKeyholder,
    };
