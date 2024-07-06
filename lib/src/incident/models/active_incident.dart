import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'active_incident.g.dart';
@JsonSerializable(fieldRename: FieldRename.pascal)
class ActiveIncidentResponse {
  ActiveIncidentResponse({
    required this.data,
  });

  final List<ActiveIncident> data;
  factory ActiveIncidentResponse.fromJson(Map<String, dynamic> json) =>
      _$ActiveIncidentResponseFromJson(json);
}

@JsonSerializable(fieldRename: FieldRename.pascal)
class ActiveIncident extends Equatable {
  const ActiveIncident({
    required this.activeIncidentId,
    required this.incidentId,
    required this.messageCount,
    required this.icon,
    required this.severity,
    required this.actionBrief,
    required this.launchDate,
    required this.launchedBy,
    required this.launchedById,
    required this.deactivatedById,
    required this.title,
    required this.impactedLocation,
    required this.locLat,
    required this.locLng,
    required this.trackUser,
    required this.numberOfKeyHolder,
    required this.status,
    required this.actionPlanDocumentUrl,
    required this.firstName,
    required this.lastName,
  });

  final int activeIncidentId;
  final int incidentId;
  final int messageCount;
  final String icon;
  final int severity;
  final String actionBrief;
  final DateTime launchDate;
  final LaunchedBy launchedBy;
  final int launchedById;
  final dynamic deactivatedById;
  final String title;
  final String impactedLocation;
  final String locLat;
  final String locLng;
  final bool trackUser;
  final int numberOfKeyHolder;
  final int status;
  final dynamic actionPlanDocumentUrl;
  final String firstName;
  final String lastName;

  factory ActiveIncident.fromJson(Map<String, dynamic> json) =>
      _$ActiveIncidentFromJson(json);
  
  Map<String, dynamic> toJson() => _$ActiveIncidentToJson(this);

  @override
  List<Object?> get props => [
        activeIncidentId,
        incidentId,
        messageCount,
        icon,
        severity,
        actionBrief,
        launchDate,
        launchedBy,
        launchedById,
        deactivatedById,
        title,
        impactedLocation,
        locLat,
        locLng,
        trackUser,
        numberOfKeyHolder,
        status,
        actionPlanDocumentUrl,
        firstName,
        lastName,
      ];

}

@JsonSerializable(fieldRename: FieldRename.pascal)
class LaunchedBy {
  LaunchedBy({
    required this.firstname,
    required this.lastname,
  });

  final String firstname;
  final String lastname;

  factory LaunchedBy.fromJson(Map<String, dynamic> json) =>
      _$LaunchedByFromJson(json);
}
