// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'all_active_incident.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AllActiveIncidentsResponse _$AllActiveIncidentsResponseFromJson(
        Map<String, dynamic> json) =>
    AllActiveIncidentsResponse(
      data: Data.fromJson(json['Data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AllActiveIncidentsResponseToJson(
        AllActiveIncidentsResponse instance) =>
    <String, dynamic>{
      'Data': instance.data,
    };

Data _$DataFromJson(Map<String, dynamic> json) => Data(
      draw: json['Draw'] as int,
      recordsTotal: json['RecordsTotal'] as int,
      recordsFiltered: json['RecordsFiltered'] as int,
      data: (json['Data'] as List<dynamic>)
          .map((e) => AllActiveIncidentData.fromJson(e as Map<String, dynamic>))
          .toList(),
      errorId: json['ErrorId'] as int?,
      errorCode: json['ErrorCode'],
      message: json['Message'],
    );

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'Draw': instance.draw,
      'RecordsTotal': instance.recordsTotal,
      'RecordsFiltered': instance.recordsFiltered,
      'Data': instance.data,
      'ErrorId': instance.errorId,
      'ErrorCode': instance.errorCode,
      'Message': instance.message,
    };

AllActiveIncidentData _$AllActiveIncidentDataFromJson(
        Map<String, dynamic> json) =>
    AllActiveIncidentData(
      name: json['Name'] as String,
      icon: json['Icon'] as String,
      companyId: json['CompanyId'] as int,
      incidentActivationId: json['IncidentActivationId'] as int,
      incidentId: json['IncidentId'] as int,
      initiatedOn: DateTime.parse(json['InitiatedOn'] as String),
      initiatedBy: json['InitiatedBy'] as int,
      firstName: json['FirstName'] as String,
      lastName: json['LastName'] as String,
      initiatedByName: InitiatedByName.fromJson(
          json['InitiatedByName'] as Map<String, dynamic>),
      launchedOn: DateTime.parse(json['LaunchedOn'] as String),
      launchedBy: json['LaunchedBy'] as int,
      launchedByName: json['LaunchedByName'],
      deactivatedOn: DateTime.parse(json['DeactivatedOn'] as String),
      deactivatedBy: json['DeactivatedBy'] as int,
      deactivatedByName: json['DeactivatedByName'],
      closedOn: DateTime.parse(json['ClosedOn'] as String),
      closedBy: json['ClosedBy'] as int,
      closedByName: json['ClosedByName'],
      statusId: json['StatusId'] as int,
      status: $enumDecode(_$IncidentStatusEnumMap, json['Status']),
      hasTask: json['HasTask'] as bool,
      severity: json['Severity'] as int,
      impactedLocationId: json['ImpactedLocationId'] as int,
      impactedLocation: json['ImpactedLocation'] as String,
      numberOfKeyHolders: json['NumberOfKeyHolders'] as int,
      hasNotes: json['HasNotes'] as bool,
      trackUser: json['TrackUser'] as bool,
      totalAffectedLocations: json['TotalAffectedLocations'] as int,
      isKeyContact: json['IsKeyContact'] as bool,
      totalSOSEvents: json['TotalSOSEvents'] as int,
    );

Map<String, dynamic> _$AllActiveIncidentDataToJson(
        AllActiveIncidentData instance) =>
    <String, dynamic>{
      'Name': instance.name,
      'Icon': instance.icon,
      'CompanyId': instance.companyId,
      'IncidentActivationId': instance.incidentActivationId,
      'IncidentId': instance.incidentId,
      'InitiatedOn': instance.initiatedOn.toIso8601String(),
      'InitiatedBy': instance.initiatedBy,
      'FirstName': instance.firstName,
      'LastName': instance.lastName,
      'InitiatedByName': instance.initiatedByName,
      'LaunchedOn': instance.launchedOn.toIso8601String(),
      'LaunchedBy': instance.launchedBy,
      'LaunchedByName': instance.launchedByName,
      'DeactivatedOn': instance.deactivatedOn.toIso8601String(),
      'DeactivatedBy': instance.deactivatedBy,
      'DeactivatedByName': instance.deactivatedByName,
      'ClosedOn': instance.closedOn.toIso8601String(),
      'ClosedBy': instance.closedBy,
      'ClosedByName': instance.closedByName,
      'StatusId': instance.statusId,
      'Status': _$IncidentStatusEnumMap[instance.status]!,
      'HasTask': instance.hasTask,
      'Severity': instance.severity,
      'ImpactedLocationId': instance.impactedLocationId,
      'ImpactedLocation': instance.impactedLocation,
      'NumberOfKeyHolders': instance.numberOfKeyHolders,
      'HasNotes': instance.hasNotes,
      'TrackUser': instance.trackUser,
      'TotalAffectedLocations': instance.totalAffectedLocations,
      'IsKeyContact': instance.isKeyContact,
      'TotalSOSEvents': instance.totalSOSEvents,
    };

const _$IncidentStatusEnumMap = {
  IncidentStatus.AwaitingLaunch: 'AwaitingLaunch',
  IncidentStatus.Launched: 'Launched',
};

InitiatedByName _$InitiatedByNameFromJson(Map<String, dynamic> json) =>
    InitiatedByName(
      firstname: json['Firstname'] as String,
      lastname: json['Lastname'] as String,
    );

Map<String, dynamic> _$InitiatedByNameToJson(InitiatedByName instance) =>
    <String, dynamic>{
      'Firstname': instance.firstname,
      'Lastname': instance.lastname,
    };
