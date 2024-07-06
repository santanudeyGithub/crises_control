// ignore_for_file: constant_identifier_names

import 'package:crises_control/src/core/models/ack_option.dart';
import 'package:crises_control/src/core/models/communication_models/company_comms_response.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'incident_detail.g.dart';

@JsonSerializable(fieldRename: FieldRename.pascal)
class IncidentDetail extends Equatable {
  const IncidentDetail({
    required this.data,
    required this.errorId,
    required this.message,
    required this.errorCode,
    required this.statusCode,
  });

  final IncidentDetailData data;
  final int errorId;
  final String? message;
  final String? errorCode;
  final int statusCode;

  factory IncidentDetail.fromJson(Map<String, dynamic> json) =>
      _$IncidentDetailFromJson(json);

  Map<String, dynamic> toJson() => _$IncidentDetailToJson(this);

  @override
  List<Object?> get props => [data, errorId, message, errorCode, statusCode];
}

@JsonSerializable(fieldRename: FieldRename.pascal)
class IncidentDetailData extends Equatable {
  const IncidentDetailData({
    required this.companyId,
    required this.name,
    required this.description,
    required this.incidentId,
    required this.incidentTypeName,
    required this.incidentTypeId,
    required this.severity,
    required this.incidentIcon,
    required this.planAssetId,
    required this.actionPlanName,
    required this.status,
    required this.numberOfKeyHolders,
    required this.incKeyCon,
    required this.incKeyholders,
    required this.messageCount,
    required this.actionLst,
    required this.incidentAssets,
    required this.assetId,
    required this.hasTask,
    required this.isSOPDoc,
    required this.trackUser,
    required this.silentMessage,
    required this.ackOptions,
    required this.messageMethods,
    required this.showTrackUser,
    required this.showSilentMessage,
    required this.showMessageMethod,
    required this.impactedLocation,
    required this.notificationGroups,
    required this.segregationWarning,
    required this.createdByName,
    required this.updatedByName,
    required this.createdOn,
    required this.updatedOn,
    required this.participants,
    required this.cascadePlanId,
    required this.hasNominatedKeyholders,
  });

  final int companyId;
  final String name;
  final String description;
  final int incidentId;
  final String? incidentTypeName;
  final int incidentTypeId;
  final int severity;
  final String incidentIcon;
  final int planAssetId;
  final String? actionPlanName;
  final int status;
  final int numberOfKeyHolders;
  final List<IncKeyCon> incKeyCon;
  final dynamic incKeyholders;
  final int messageCount;
  final List<IncidentMessages> actionLst;
  final List<IncidentAsset> incidentAssets;
  final int assetId;
  final bool hasTask;
  final bool isSOPDoc;
  final bool trackUser;
  final bool silentMessage;
  final List<AckOption> ackOptions;
  final List<MessageMethod> messageMethods;
  final bool showTrackUser;
  final bool showSilentMessage;
  final bool showMessageMethod;
  final dynamic impactedLocation;
  final dynamic notificationGroups;
  final int segregationWarning;
  final dynamic createdByName;
  final dynamic updatedByName;
  final DateTime createdOn;
  final DateTime updatedOn;
  final List<Participant> participants;
  final int cascadePlanId;
  final bool hasNominatedKeyholders;

  factory IncidentDetailData.fromJson(Map<String, dynamic> json) =>
      _$IncidentDetailDataFromJson(json);
  Map<String, dynamic> toJson() => _$IncidentDetailDataToJson(this);

  @override
  List<Object?> get props => [
        companyId,
        name,
        description,
        incidentId,
        incidentTypeName,
        incidentTypeId,
        severity,
        incidentIcon,
        planAssetId,
        actionPlanName,
        status,
        numberOfKeyHolders,
        incKeyCon,
        incKeyholders,
        messageCount,
        actionLst,
        incidentAssets,
        assetId,
        hasTask,
        isSOPDoc,
        trackUser,
        silentMessage,
        ackOptions,
        messageMethods,
        showTrackUser,
        showSilentMessage,
        showMessageMethod,
        impactedLocation,
        notificationGroups,
        segregationWarning,
        createdByName,
        updatedByName,
        createdOn,
        updatedOn,
        participants,
        cascadePlanId,
        hasNominatedKeyholders,
      ];
}

@JsonSerializable(fieldRename: FieldRename.pascal)
class IncidentMessages extends Equatable {
  const IncidentMessages({
    required this.incidentActionId,
    required this.incidentId,
    required this.title,
    required this.actionDescription,
    required this.multiResponse,
    required this.status,
    required this.companyId,
    required this.incKeyActCon,
    required this.participants,
    required this.hasParticipants,
  });

  final int incidentActionId;
  final int incidentId;
  final String title;
  final String actionDescription;
  final int multiResponse;
  final int status;
  final int companyId;
  final dynamic incKeyActCon;
  final dynamic participants;
  final bool hasParticipants;

  factory IncidentMessages.fromJson(Map<String, dynamic> json) =>
      _$IncidentMessagesFromJson(json);

  Map<String, dynamic> toJson() => _$IncidentMessagesToJson(this);

  @override
  List<Object?> get props => [
        incidentActionId,
        incidentId,
        title,
        actionDescription,
        multiResponse,
        status,
        companyId,
        incKeyActCon,
        participants,
        hasParticipants,
      ];
}

@JsonSerializable(fieldRename: FieldRename.pascal)
class IncKeyCon extends Equatable {
  const IncKeyCon({
    required this.userId,
    required this.userName,
    required this.firstName,
    required this.lastName,
  });

  final int userId;
  final UserName userName;
  final String firstName;
  final String lastName;

  //full name
  String get fullName => '$firstName $lastName';

  factory IncKeyCon.fromJson(Map<String, dynamic> json) =>
      _$IncKeyConFromJson(json);

  Map<String, dynamic> toJson() => _$IncKeyConToJson(this);

  @override
  List<Object?> get props => [userId, userName, firstName, lastName];
}

@JsonSerializable(fieldRename: FieldRename.pascal)
class UserName extends Equatable {
  const UserName({
    required this.firstname,
    required this.lastname,
  });

  final String? firstname;
  final String? lastname;

  factory UserName.fromJson(Map<String, dynamic> json) =>
      _$UserNameFromJson(json);

  Map<String, dynamic> toJson() => _$UserNameToJson(this);

  @override
  List<Object?> get props => [firstname, lastname];
}

@JsonSerializable(fieldRename: FieldRename.pascal)
class IncidentAsset extends Equatable {
  const IncidentAsset({
    required this.assetId,
    required this.assetTitle,
    required this.assetDescription,
    required this.assetFileName,
    required this.assetPath,
    required this.filePath,
    required this.assetType,
    required this.assetSize,
    required this.assetTypeId,
    required this.updatedOn,
    required this.reviewDate,
    required this.assetOwnerName,
  });

  final int assetId;
  final String assetTitle;
  final String assetDescription;
  final String? assetFileName;
  final String? assetPath;
  final String? filePath;
  final String assetType;
  final int assetSize;
  final int assetTypeId;
  final DateTime updatedOn;
  final DateTime? reviewDate;
  final UserName assetOwnerName;

  factory IncidentAsset.fromJson(Map<String, dynamic> json) =>
      _$IncidentAssetFromJson(json);

  Map<String, dynamic> toJson() => _$IncidentAssetToJson(this);

  @override
  List<Object?> get props => [
        assetId,
        assetTitle,
        assetDescription,
        assetFileName,
        assetPath,
        filePath,
        assetType,
        assetSize,
        assetTypeId,
        updatedOn,
        reviewDate,
        assetOwnerName,
      ];
}

@JsonSerializable(fieldRename: FieldRename.pascal)
class Participant extends Equatable {
  const Participant({
    required this.incidentParticipantID,
    required this.incidentID,
    required this.incidentActionID,
    required this.groupType,
    required this.groupName,
    required this.participantType,
    required this.participantGroupID,
    required this.objectMappingID,
    required this.participantUserID,
    required this.userName,
    required this.firstName,
    required this.lastName,
  });

  final int? incidentParticipantID;
  final int incidentID;
  final int incidentActionID;
  final String groupType;
  final String groupName;
  final ParticipantType participantType;
  final int participantGroupID;
  final int objectMappingID;
  final int participantUserID;
  final UserName userName;
  final String? firstName;
  final String? lastName;

  factory Participant.fromJson(Map<String, dynamic> json) =>
      _$ParticipantFromJson(json);

  Map<String, dynamic> toJson() => _$ParticipantToJson(this);

  @override
  List<Object?> get props => [
        incidentParticipantID,
        incidentID,
        incidentActionID,
        groupType,
        groupName,
        participantType,
        participantGroupID,
        objectMappingID,
        participantUserID,
        userName,
        firstName,
        lastName,
      ];
}

enum ParticipantType { GROUP, USER }
