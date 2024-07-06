// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_acknowledge_status_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MessageAcknowledgeStatusResponse _$MessageAcknowledgeStatusResponseFromJson(
        Map<String, dynamic> json) =>
    MessageAcknowledgeStatusResponse(
      data: MessageAcknowledgeStatusData.fromJson(
          json['Data'] as Map<String, dynamic>),
      errorCode: json['ErrorCode'] as String,
    );

Map<String, dynamic> _$MessageAcknowledgeStatusResponseToJson(
        MessageAcknowledgeStatusResponse instance) =>
    <String, dynamic>{
      'Data': instance.data,
      'ErrorCode': instance.errorCode,
    };

MessageAcknowledgeStatusData _$MessageAcknowledgeStatusDataFromJson(
        Map<String, dynamic> json) =>
    MessageAcknowledgeStatusData(
      draw: json['Draw'] as int,
      recordsTotal: json['RecordsTotal'] as int,
      recordsFiltered: json['RecordsFiltered'] as int,
      data: (json['Data'] as List<dynamic>)
          .map((e) =>
              MessageAcknowledgeStatus.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MessageAcknowledgeStatusDataToJson(
        MessageAcknowledgeStatusData instance) =>
    <String, dynamic>{
      'Draw': instance.draw,
      'RecordsTotal': instance.recordsTotal,
      'RecordsFiltered': instance.recordsFiltered,
      'Data': instance.data,
    };

MessageAcknowledgeStatus _$MessageAcknowledgeStatusFromJson(
        Map<String, dynamic> json) =>
    MessageAcknowledgeStatus(
      dateAcknowledge: DateTime.parse(json['DateAcknowledge'] as String),
      messageSent: DateTime.parse(json['MessageSent'] as String),
      dateSent: DateTime.parse(json['DateSent'] as String),
      messageAcknowledge: DateTime.parse(json['MessageAcknowledge'] as String),
      messageLat: json['MessageLat'],
      messageLng: json['MessageLng'],
      acknowledgedUser: AcknowledgedUser.fromJson(
          json['AcknowledgedUser'] as Map<String, dynamic>),
      firstName: json['FirstName'] as String,
      lastName: json['LastName'] as String,
      userEmail: json['UserEmail'] as String,
      primaryEmail: json['PrimaryEmail'],
      isdCode: json['ISDCode'] as String,
      mobileNo: json['MobileNo'] as String,
      userStatus: json['UserStatus'] as int,
      userMobile:
          UserPhone.fromJson(json['UserMobile'] as Map<String, dynamic>),
      llisdCode: json['LLISDCode'] as String,
      landline: json['Landline'] as String,
      userLandLine:
          UserPhone.fromJson(json['UserLandLine'] as Map<String, dynamic>),
      userId: json['UserId'] as int,
      userPhoto: json['UserPhoto'] as String,
      messageAckStatus: json['MessageAckStatus'] as int,
      ackMethod: json['AckMethod'] as String,
      isTaskRecepient: json['IsTaskRecepient'] as bool,
      responseLabel: json['ResponseLabel'] as String,
      isSafetyResponse: json['IsSafetyResponse'] as bool,
      activeIncidentId: json['ActiveIncidentID'] as int,
      channels: json['Channels'],
      activeUser: json['ActiveUser'] as bool,
    );

Map<String, dynamic> _$MessageAcknowledgeStatusToJson(
        MessageAcknowledgeStatus instance) =>
    <String, dynamic>{
      'DateAcknowledge': instance.dateAcknowledge.toIso8601String(),
      'MessageSent': instance.messageSent.toIso8601String(),
      'DateSent': instance.dateSent.toIso8601String(),
      'MessageAcknowledge': instance.messageAcknowledge.toIso8601String(),
      'MessageLat': instance.messageLat,
      'MessageLng': instance.messageLng,
      'AcknowledgedUser': instance.acknowledgedUser,
      'FirstName': instance.firstName,
      'LastName': instance.lastName,
      'UserEmail': instance.userEmail,
      'PrimaryEmail': instance.primaryEmail,
      'ISDCode': instance.isdCode,
      'MobileNo': instance.mobileNo,
      'UserStatus': instance.userStatus,
      'UserMobile': instance.userMobile,
      'LLISDCode': instance.llisdCode,
      'Landline': instance.landline,
      'UserLandLine': instance.userLandLine,
      'UserId': instance.userId,
      'UserPhoto': instance.userPhoto,
      'MessageAckStatus': instance.messageAckStatus,
      'AckMethod': instance.ackMethod,
      'IsTaskRecepient': instance.isTaskRecepient,
      'ResponseLabel': instance.responseLabel,
      'IsSafetyResponse': instance.isSafetyResponse,
      'ActiveIncidentID': instance.activeIncidentId,
      'Channels': instance.channels,
      'ActiveUser': instance.activeUser,
    };

AcknowledgedUser _$AcknowledgedUserFromJson(Map<String, dynamic> json) =>
    AcknowledgedUser(
      firstname: json['Firstname'] as String,
      lastname: json['Lastname'] as String,
    );

Map<String, dynamic> _$AcknowledgedUserToJson(AcknowledgedUser instance) =>
    <String, dynamic>{
      'Firstname': instance.firstname,
      'Lastname': instance.lastname,
    };

UserPhone _$UserPhoneFromJson(Map<String, dynamic> json) => UserPhone(
      isd: json['ISD'] as String,
      number: json['Number'] as String,
    );

Map<String, dynamic> _$UserPhoneToJson(UserPhone instance) => <String, dynamic>{
      'ISD': instance.isd,
      'Number': instance.number,
    };
