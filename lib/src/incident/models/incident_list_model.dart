import 'package:json_annotation/json_annotation.dart';

part 'incident_list_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.pascal)
class IncidentListModel {
  IncidentListModel({
    required this.data,
  });

  final List<IncidentListDetail> data;
  factory IncidentListModel.fromJson(Map<String, dynamic> json) =>
      _$IncidentListModelFromJson(json);
  Map<String, dynamic> toJson() => _$IncidentListModelToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.pascal)
class IncidentListDetail {
  IncidentListDetail({
    required this.companyId,
    required this.incidentId,
    required this.name,
    required this.incidentIcon,
    required this.severity,
    required this.numberOfKeyHolders,
    required this.status,
    required this.incidentTypeName,
    required this.hasTask,
    required this.segregationWarning,
  });

  final int companyId;
  final int incidentId;
  final String name;
  final String incidentIcon;
  final int severity;
  final int numberOfKeyHolders;
  final int status;
  final String incidentTypeName;
  final bool hasTask;
  final int segregationWarning;

  factory IncidentListDetail.fromJson(Map<String, dynamic> json) =>
      _$IncidentListDetailFromJson(json);
  Map<String, dynamic> toJson() => _$IncidentListDetailToJson(this);
}
