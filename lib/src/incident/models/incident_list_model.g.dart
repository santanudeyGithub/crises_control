// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'incident_list_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

IncidentListModel _$IncidentListModelFromJson(Map<String, dynamic> json) =>
    IncidentListModel(
      data: (json['Data'] as List<dynamic>)
          .map((e) => IncidentListDetail.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$IncidentListModelToJson(IncidentListModel instance) =>
    <String, dynamic>{
      'Data': instance.data,
    };

IncidentListDetail _$IncidentListDetailFromJson(Map<String, dynamic> json) =>
    IncidentListDetail(
      companyId: json['CompanyId'] as int,
      incidentId: json['IncidentId'] as int,
      name: json['Name'] as String,
      incidentIcon: json['IncidentIcon'] as String,
      severity: json['Severity'] as int,
      numberOfKeyHolders: json['NumberOfKeyHolders'] as int,
      status: json['Status'] as int,
      incidentTypeName: json['IncidentTypeName'] as String,
      hasTask: json['HasTask'] as bool,
      segregationWarning: json['SegregationWarning'] as int,
    );

Map<String, dynamic> _$IncidentListDetailToJson(IncidentListDetail instance) =>
    <String, dynamic>{
      'CompanyId': instance.companyId,
      'IncidentId': instance.incidentId,
      'Name': instance.name,
      'IncidentIcon': instance.incidentIcon,
      'Severity': instance.severity,
      'NumberOfKeyHolders': instance.numberOfKeyHolders,
      'Status': instance.status,
      'IncidentTypeName': instance.incidentTypeName,
      'HasTask': instance.hasTask,
      'SegregationWarning': instance.segregationWarning,
    };
