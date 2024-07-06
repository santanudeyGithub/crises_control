// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: unused_element

part of 'active_incident.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ActiveIncidentResponse _$ActiveIncidentResponseFromJson(
        Map<String, dynamic> json) =>
    ActiveIncidentResponse(
      data: (json['Data'] as List<dynamic>)
          .map((e) => ActiveIncident.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ActiveIncidentResponseToJson(
        ActiveIncidentResponse instance) =>
    <String, dynamic>{
      'Data': instance.data,
    };

ActiveIncident _$ActiveIncidentFromJson(Map<String, dynamic> json) =>
    ActiveIncident(
      activeIncidentId: json['ActiveIncidentId'] as int,
      incidentId: json['IncidentId'] as int,
      messageCount: json['MessageCount'] as int,
      icon: json['Icon'] as String,
      severity: json['Severity'] as int,
      actionBrief: json['ActionBrief'] as String,
      launchDate: DateTime.parse(json['LaunchDate'] as String),
      launchedBy:
          LaunchedBy.fromJson(json['LaunchedBy'] as Map<String, dynamic>),
      launchedById: json['LaunchedById'] as int,
      deactivatedById: json['DeactivatedById'],
      title: json['Title'] as String,
      impactedLocation: json['ImpactedLocation'] as String,
      locLat: json['LocLat'] as String,
      locLng: json['LocLng'] as String,
      trackUser: json['TrackUser'] as bool,
      numberOfKeyHolder: json['NumberOfKeyHolder'] as int,
      status: json['Status'] as int,
      actionPlanDocumentUrl: json['ActionPlanDocumentUrl'],
      firstName: json['FirstName'] as String,
      lastName: json['LastName'] as String,
    );

Map<String, dynamic> _$ActiveIncidentToJson(ActiveIncident instance) =>
    <String, dynamic>{
      'ActiveIncidentId': instance.activeIncidentId,
      'IncidentId': instance.incidentId,
      'MessageCount': instance.messageCount,
      'Icon': instance.icon,
      'Severity': instance.severity,
      'ActionBrief': instance.actionBrief,
      'LaunchDate': instance.launchDate.toIso8601String(),
      'LaunchedBy': instance.launchedBy,
      'LaunchedById': instance.launchedById,
      'DeactivatedById': instance.deactivatedById,
      'Title': instance.title,
      'ImpactedLocation': instance.impactedLocation,
      'LocLat': instance.locLat,
      'LocLng': instance.locLng,
      'TrackUser': instance.trackUser,
      'NumberOfKeyHolder': instance.numberOfKeyHolder,
      'Status': instance.status,
      'ActionPlanDocumentUrl': instance.actionPlanDocumentUrl,
      'FirstName': instance.firstName,
      'LastName': instance.lastName,
    };

LaunchedBy _$LaunchedByFromJson(Map<String, dynamic> json) => LaunchedBy(
      firstname: json['Firstname'] as String,
      lastname: json['Lastname'] as String,
    );

Map<String, dynamic> _$LaunchedByToJson(LaunchedBy instance) =>
    <String, dynamic>{
      'Firstname': instance.firstname,
      'Lastname': instance.lastname,
    };
