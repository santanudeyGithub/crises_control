import 'package:crises_control/src/core/models/list_models/locations.dart';
import 'package:crises_control/src/core/models/list_models/request/acknowledge_option_rq.dart';
import 'package:crises_control/src/core/models/list_models/request/message_obj_rq.dart';
import 'package:crises_control/src/core/presentation/pages/lists/user_list_page.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'launch_incident_request_body.g.dart';

@JsonSerializable(fieldRename: FieldRename.pascal)
class LaunchIncidentRequestBody extends Equatable {
  const LaunchIncidentRequestBody({
    required this.incidentId,
    required this.incidentActivationId,
    required this.description,
    required this.severity,
    required this.multiResponse,
    required this.ackOptions,
    required this.impactedLocations,
    required this.userRole,
    required this.audioAssetId,
    required this.trackUser,
    required this.silentMessage,
    required this.messageMethod,
    required this.numberOfKeyHolder,
    required this.initiateIncidentActionLst,
    required this.initiateIncidentKeyHldLst,
    required this.initiateIncidentNotificationObjLst,
    required this.affectedLocations,
    required this.usersToNotify,
    required this.launchMode,
    required this.socialHandle,
    required this.source,
    required this.cascadePlanId,
    required this.incidentKeyholder,
  });
  final int incidentId;
  final int incidentActivationId;
  final String description;
  final int severity;
  final bool multiResponse;
  final List<AcknowledgeOptionRq> ackOptions;
  final List<int> impactedLocations;
  final String userRole;
  final int audioAssetId;
  final bool trackUser;
  final bool silentMessage;
  final List<int> messageMethod;
  final int numberOfKeyHolder;
  final List<dynamic> initiateIncidentActionLst;
  final List<SelectedUser> initiateIncidentKeyHldLst;
  final List<MessageObjRq> initiateIncidentNotificationObjLst;
  final List<LocationsData> affectedLocations;
  final List<int> usersToNotify;
  final int launchMode;
  final List<dynamic> socialHandle;
  final String source;
  final int cascadePlanId;
  final List<dynamic> incidentKeyholder;

  factory LaunchIncidentRequestBody.fromJson(Map<String, dynamic> json) =>
      _$LaunchIncidentRequestBodyFromJson(json);

  Map<String, dynamic> toJson() => _$LaunchIncidentRequestBodyToJson(this);

  @override
  List<Object?> get props => [
        incidentId,
        incidentActivationId,
        description,
        severity,
        multiResponse,
        ackOptions,
        impactedLocations,
        userRole,
        audioAssetId,
        trackUser,
        silentMessage,
        messageMethod,
        numberOfKeyHolder,
        initiateIncidentActionLst,
        initiateIncidentKeyHldLst,
        initiateIncidentNotificationObjLst,
        affectedLocations,
        usersToNotify,
        launchMode,
        socialHandle,
        source,
        cascadePlanId,
        incidentKeyholder,
      ];
}
