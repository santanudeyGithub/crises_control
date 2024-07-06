// ignore_for_file: constant_identifier_names

import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';
import 'package:json_annotation/json_annotation.dart';

part 'all_active_incident.g.dart';

@JsonSerializable(fieldRename: FieldRename.pascal)
class AllActiveIncidentsResponse {
  AllActiveIncidentsResponse({
    required this.data,
  });

  final Data data;
  factory AllActiveIncidentsResponse.fromJson(Map<String, dynamic> json) =>
      _$AllActiveIncidentsResponseFromJson(json);
  Map<String, dynamic> toJson() => _$AllActiveIncidentsResponseToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.pascal)
class Data extends Equatable {
  const Data({
    required this.draw,
    required this.recordsTotal,
    required this.recordsFiltered,
    required this.data,
    required this.errorId,
    required this.errorCode,
    required this.message,
  });

  final int draw;
  final int recordsTotal;
  final int recordsFiltered;
  final List<AllActiveIncidentData> data;
  final int? errorId;
  final dynamic errorCode;
  final dynamic message;

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);
  Map<String, dynamic> toJson() => _$DataToJson(this);

  @override
  List<Object?> get props =>
      [draw, recordsTotal, recordsFiltered, data, errorId, errorCode, message];
}

@JsonSerializable(fieldRename: FieldRename.pascal)
class AllActiveIncidentData extends Equatable {
  const AllActiveIncidentData({
    required this.name,
    required this.icon,
    required this.companyId,
    required this.incidentActivationId,
    required this.incidentId,
    required this.initiatedOn,
    required this.initiatedBy,
    required this.firstName,
    required this.lastName,
    required this.initiatedByName,
    required this.launchedOn,
    required this.launchedBy,
    required this.launchedByName,
    required this.deactivatedOn,
    required this.deactivatedBy,
    required this.deactivatedByName,
    required this.closedOn,
    required this.closedBy,
    required this.closedByName,
    required this.statusId,
    required this.status,
    required this.hasTask,
    required this.severity,
    required this.impactedLocationId,
    required this.impactedLocation,
    required this.numberOfKeyHolders,
    required this.hasNotes,
    required this.trackUser,
    required this.totalAffectedLocations,
    required this.isKeyContact,
    required this.totalSOSEvents,
  });

  final String name;
  final String icon;
  final int companyId;
  final int incidentActivationId;
  final int incidentId;
  final DateTime initiatedOn;
  final int initiatedBy;
  final String firstName;
  final String lastName;
  final InitiatedByName initiatedByName;
  final DateTime launchedOn;
  final int launchedBy;
  final dynamic launchedByName;
  final DateTime deactivatedOn;
  final int deactivatedBy;
  final dynamic deactivatedByName;
  final DateTime closedOn;
  final int closedBy;
  final dynamic closedByName;
  final int statusId;
  final IncidentStatus status;
  final bool hasTask;
  final int severity;
  final int impactedLocationId;
  final String impactedLocation;
  final int numberOfKeyHolders;
  final bool hasNotes;
  final bool trackUser;
  final int totalAffectedLocations;
  final bool isKeyContact;
  final int totalSOSEvents;

  factory AllActiveIncidentData.fromJson(Map<String, dynamic> json) =>
      _$AllActiveIncidentDataFromJson(json);
  Map<String, dynamic> toJson() => _$AllActiveIncidentDataToJson(this);

  @override
  List<Object?> get props => [
        name,
        icon,
        companyId,
        incidentActivationId,
        incidentId,
        initiatedOn,
        initiatedBy,
        firstName,
        lastName,
        initiatedByName,
        launchedOn,
        launchedBy,
        launchedByName,
        deactivatedOn,
        deactivatedBy,
        deactivatedByName,
        closedOn,
        closedBy,
        closedByName,
        statusId,
        status,
        hasTask,
        severity,
        impactedLocationId,
        impactedLocation,
        numberOfKeyHolders,
        hasNotes,
        trackUser,
        totalAffectedLocations,
        isKeyContact,
        totalSOSEvents,
      ];

  String get launchedOnToString =>
      DateFormat('dd/MM/yyyy hh:mm').format(launchedOn);
  String get initiatedOnToString =>
      DateFormat('MM/DD/YY HH:MM').format(initiatedOn);
  String get deactivatedOnToString =>
      DateFormat('dd/MM/yyyy').format(deactivatedOn);
}

@JsonSerializable(fieldRename: FieldRename.pascal)
class InitiatedByName extends Equatable {
  const InitiatedByName({
    required this.firstname,
    required this.lastname,
  });

  final String firstname;
  final String lastname;

  factory InitiatedByName.fromJson(Map<String, dynamic> json) =>
      _$InitiatedByNameFromJson(json);
  Map<String, dynamic> toJson() => _$InitiatedByNameToJson(this);

  @override
  List<Object?> get props => [firstname, lastname];
}

enum IncidentStatus { AwaitingLaunch, Launched }
