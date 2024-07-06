import 'package:json_annotation/json_annotation.dart';

part 'cascading_plan_response.g.dart';

@JsonSerializable(fieldRename: FieldRename.pascal)
class CascadingPlanResponse {
  CascadingPlanResponse({
    required this.data,
    required this.errorCode,
  });

  final List<CascadingPlan> data;
  final String errorCode;

  factory CascadingPlanResponse.fromJson(Map<String, dynamic> json) =>
      _$CascadingPlanResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CascadingPlanResponseToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.pascal)
class CascadingPlan {
  CascadingPlan({
    required this.planId,
    required this.planName,
    required this.planType,
    required this.launchSos,
    required this.launchSosInterval,
    required this.commsMethod,
  });

  @JsonKey(name: 'PlanID')
  final int planId;
  final String planName;
  final String planType;
  @JsonKey(name: 'LaunchSOS')
  final bool launchSos;
  @JsonKey(name: 'LaunchSOSInterval')
  final int launchSosInterval;
  final dynamic commsMethod;

  factory CascadingPlan.fromJson(Map<String, dynamic> json) =>
      _$CascadingPlanFromJson(json);

  Map<String, dynamic> toJson() => _$CascadingPlanToJson(this);
}
