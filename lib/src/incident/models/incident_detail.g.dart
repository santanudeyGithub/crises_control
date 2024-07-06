// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'incident_detail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

IncidentDetail _$IncidentDetailFromJson(Map<String, dynamic> json) =>
    IncidentDetail(
      data: IncidentDetailData.fromJson(json['Data'] as Map<String, dynamic>),
      errorId: json['ErrorId'] as int,
      message: json['Message'] as String?,
      errorCode: json['ErrorCode'] as String?,
      statusCode: json['StatusCode'] as int,
    );

Map<String, dynamic> _$IncidentDetailToJson(IncidentDetail instance) =>
    <String, dynamic>{
      'Data': instance.data,
      'ErrorId': instance.errorId,
      'Message': instance.message,
      'ErrorCode': instance.errorCode,
      'StatusCode': instance.statusCode,
    };

IncidentDetailData _$IncidentDetailDataFromJson(Map<String, dynamic> json) =>
    IncidentDetailData(
      companyId: json['CompanyId'] as int,
      name: json['Name'] as String,
      description: json['Description'] as String,
      incidentId: json['IncidentId'] as int,
      incidentTypeName: json['IncidentTypeName'] as String?,
      incidentTypeId: json['IncidentTypeId'] as int,
      severity: json['Severity'] as int,
      incidentIcon: json['IncidentIcon'] as String,
      planAssetId: json['PlanAssetId'] as int,
      actionPlanName: json['ActionPlanName'] as String?,
      status: json['Status'] as int,
      numberOfKeyHolders: json['NumberOfKeyHolders'] as int,
      incKeyCon: (json['IncKeyCon'] as List<dynamic>)
          .map((e) => IncKeyCon.fromJson(e as Map<String, dynamic>))
          .toList(),
      incKeyholders: json['IncKeyholders'],
      messageCount: json['MessageCount'] as int,
      actionLst: (json['ActionLst'] as List<dynamic>)
          .map((e) => IncidentMessages.fromJson(e as Map<String, dynamic>))
          .toList(),
      incidentAssets: (json['IncidentAssets'] as List<dynamic>)
          .map((e) => IncidentAsset.fromJson(e as Map<String, dynamic>))
          .toList(),
      assetId: json['AssetId'] as int,
      hasTask: json['HasTask'] as bool,
      isSOPDoc: json['IsSOPDoc'] as bool,
      trackUser: json['TrackUser'] as bool,
      silentMessage: json['SilentMessage'] as bool,
      ackOptions: (json['AckOptions'] as List<dynamic>)
          .map((e) => AckOption.fromJson(e as Map<String, dynamic>))
          .toList(),
      messageMethods: (json['MessageMethods'] as List<dynamic>)
          .map((e) => MessageMethod.fromJson(e as Map<String, dynamic>))
          .toList(),
      showTrackUser: json['ShowTrackUser'] as bool,
      showSilentMessage: json['ShowSilentMessage'] as bool,
      showMessageMethod: json['ShowMessageMethod'] as bool,
      impactedLocation: json['ImpactedLocation'],
      notificationGroups: json['NotificationGroups'],
      segregationWarning: json['SegregationWarning'] as int,
      createdByName: json['CreatedByName'],
      updatedByName: json['UpdatedByName'],
      createdOn: DateTime.parse(json['CreatedOn'] as String),
      updatedOn: DateTime.parse(json['UpdatedOn'] as String),
      participants: (json['Participants'] as List<dynamic>)
          .map((e) => Participant.fromJson(e as Map<String, dynamic>))
          .toList(),
      cascadePlanId: json['CascadePlanId'] as int,
      hasNominatedKeyholders: json['HasNominatedKeyholders'] as bool,
    );

Map<String, dynamic> _$IncidentDetailDataToJson(IncidentDetailData instance) =>
    <String, dynamic>{
      'CompanyId': instance.companyId,
      'Name': instance.name,
      'Description': instance.description,
      'IncidentId': instance.incidentId,
      'IncidentTypeName': instance.incidentTypeName,
      'IncidentTypeId': instance.incidentTypeId,
      'Severity': instance.severity,
      'IncidentIcon': instance.incidentIcon,
      'PlanAssetId': instance.planAssetId,
      'ActionPlanName': instance.actionPlanName,
      'Status': instance.status,
      'NumberOfKeyHolders': instance.numberOfKeyHolders,
      'IncKeyCon': instance.incKeyCon,
      'IncKeyholders': instance.incKeyholders,
      'MessageCount': instance.messageCount,
      'ActionLst': instance.actionLst,
      'IncidentAssets': instance.incidentAssets,
      'AssetId': instance.assetId,
      'HasTask': instance.hasTask,
      'IsSOPDoc': instance.isSOPDoc,
      'TrackUser': instance.trackUser,
      'SilentMessage': instance.silentMessage,
      'AckOptions': instance.ackOptions,
      'MessageMethods': instance.messageMethods,
      'ShowTrackUser': instance.showTrackUser,
      'ShowSilentMessage': instance.showSilentMessage,
      'ShowMessageMethod': instance.showMessageMethod,
      'ImpactedLocation': instance.impactedLocation,
      'NotificationGroups': instance.notificationGroups,
      'SegregationWarning': instance.segregationWarning,
      'CreatedByName': instance.createdByName,
      'UpdatedByName': instance.updatedByName,
      'CreatedOn': instance.createdOn.toIso8601String(),
      'UpdatedOn': instance.updatedOn.toIso8601String(),
      'Participants': instance.participants,
      'CascadePlanId': instance.cascadePlanId,
      'HasNominatedKeyholders': instance.hasNominatedKeyholders,
    };

IncidentMessages _$IncidentMessagesFromJson(Map<String, dynamic> json) =>
    IncidentMessages(
      incidentActionId: json['IncidentActionId'] as int,
      incidentId: json['IncidentId'] as int,
      title: json['Title'] as String,
      actionDescription: json['ActionDescription'] as String,
      multiResponse: json['MultiResponse'] as int,
      status: json['Status'] as int,
      companyId: json['CompanyId'] as int,
      incKeyActCon: json['IncKeyActCon'],
      participants: json['Participants'],
      hasParticipants: json['HasParticipants'] as bool,
    );

Map<String, dynamic> _$IncidentMessagesToJson(IncidentMessages instance) =>
    <String, dynamic>{
      'IncidentActionId': instance.incidentActionId,
      'IncidentId': instance.incidentId,
      'Title': instance.title,
      'ActionDescription': instance.actionDescription,
      'MultiResponse': instance.multiResponse,
      'Status': instance.status,
      'CompanyId': instance.companyId,
      'IncKeyActCon': instance.incKeyActCon,
      'Participants': instance.participants,
      'HasParticipants': instance.hasParticipants,
    };

IncKeyCon _$IncKeyConFromJson(Map<String, dynamic> json) => IncKeyCon(
      userId: json['UserId'] as int,
      userName: UserName.fromJson(json['UserName'] as Map<String, dynamic>),
      firstName: json['FirstName'] as String,
      lastName: json['LastName'] as String,
    );

Map<String, dynamic> _$IncKeyConToJson(IncKeyCon instance) => <String, dynamic>{
      'UserId': instance.userId,
      'UserName': instance.userName,
      'FirstName': instance.firstName,
      'LastName': instance.lastName,
    };

UserName _$UserNameFromJson(Map<String, dynamic> json) => UserName(
      firstname: json['Firstname'] as String?,
      lastname: json['Lastname'] as String?,
    );

Map<String, dynamic> _$UserNameToJson(UserName instance) => <String, dynamic>{
      'Firstname': instance.firstname,
      'Lastname': instance.lastname,
    };

IncidentAsset _$IncidentAssetFromJson(Map<String, dynamic> json) =>
    IncidentAsset(
      assetId: json['AssetId'] as int,
      assetTitle: json['AssetTitle'] as String,
      assetDescription: json['AssetDescription'] as String,
      assetFileName: json['AssetFileName'] as String?,
      assetPath: json['AssetPath'] as String?,
      filePath: json['FilePath'] as String?,
      assetType: json['AssetType'] as String,
      assetSize: json['AssetSize'] as int,
      assetTypeId: json['AssetTypeId'] as int,
      updatedOn: DateTime.parse(json['UpdatedOn'] as String),
      reviewDate: json['ReviewDate'] == null
          ? null
          : DateTime.parse(json['ReviewDate'] as String),
      assetOwnerName:
          UserName.fromJson(json['AssetOwnerName'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$IncidentAssetToJson(IncidentAsset instance) =>
    <String, dynamic>{
      'AssetId': instance.assetId,
      'AssetTitle': instance.assetTitle,
      'AssetDescription': instance.assetDescription,
      'AssetFileName': instance.assetFileName,
      'AssetPath': instance.assetPath,
      'FilePath': instance.filePath,
      'AssetType': instance.assetType,
      'AssetSize': instance.assetSize,
      'AssetTypeId': instance.assetTypeId,
      'UpdatedOn': instance.updatedOn.toIso8601String(),
      'ReviewDate': instance.reviewDate?.toIso8601String(),
      'AssetOwnerName': instance.assetOwnerName,
    };

Participant _$ParticipantFromJson(Map<String, dynamic> json) => Participant(
      incidentParticipantID: json['IncidentParticipantID'] as int?,
      incidentID: json['IncidentID'] as int,
      incidentActionID: json['IncidentActionID'] as int,
      groupType: json['GroupType'] as String,
      groupName: json['GroupName'] as String,
      participantType:
          $enumDecode(_$ParticipantTypeEnumMap, json['ParticipantType']),
      participantGroupID: json['ParticipantGroupID'] as int,
      objectMappingID: json['ObjectMappingID'] as int,
      participantUserID: json['ParticipantUserID'] as int,
      userName: UserName.fromJson(json['UserName'] as Map<String, dynamic>),
      firstName: json['FirstName'] as String?,
      lastName: json['LastName'] as String?,
    );

Map<String, dynamic> _$ParticipantToJson(Participant instance) =>
    <String, dynamic>{
      'IncidentParticipantID': instance.incidentParticipantID,
      'IncidentID': instance.incidentID,
      'IncidentActionID': instance.incidentActionID,
      'GroupType': instance.groupType,
      'GroupName': instance.groupName,
      'ParticipantType': _$ParticipantTypeEnumMap[instance.participantType]!,
      'ParticipantGroupID': instance.participantGroupID,
      'ObjectMappingID': instance.objectMappingID,
      'ParticipantUserID': instance.participantUserID,
      'UserName': instance.userName,
      'FirstName': instance.firstName,
      'LastName': instance.lastName,
    };

const _$ParticipantTypeEnumMap = {
  ParticipantType.GROUP: 'GROUP',
  ParticipantType.USER: 'USER',
};
