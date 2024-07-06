// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cascading_plan_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CascadingPlanResponse _$CascadingPlanResponseFromJson(
        Map<String, dynamic> json) =>
    CascadingPlanResponse(
      data: (json['Data'] as List<dynamic>)
          .map((e) => CascadingPlan.fromJson(e as Map<String, dynamic>))
          .toList(),
      errorCode: json['ErrorCode'] as String,
    );

Map<String, dynamic> _$CascadingPlanResponseToJson(
        CascadingPlanResponse instance) =>
    <String, dynamic>{
      'Data': instance.data,
      'ErrorCode': instance.errorCode,
    };

CascadingPlan _$CascadingPlanFromJson(Map<String, dynamic> json) =>
    CascadingPlan(
      planId: json['PlanID'] as int,
      planName: json['PlanName'] as String,
      planType: json['PlanType'] as String,
      launchSos: json['LaunchSOS'] as bool,
      launchSosInterval: json['LaunchSOSInterval'] as int,
      commsMethod: json['CommsMethod'],
    );

Map<String, dynamic> _$CascadingPlanToJson(CascadingPlan instance) =>
    <String, dynamic>{
      'PlanID': instance.planId,
      'PlanName': instance.planName,
      'PlanType': instance.planType,
      'LaunchSOS': instance.launchSos,
      'LaunchSOSInterval': instance.launchSosInterval,
      'CommsMethod': instance.commsMethod,
    };
