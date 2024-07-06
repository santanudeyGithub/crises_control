// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      json['userId'] as int,
      json['companyId'] as int,
      json['registeredUser'] as bool,
      json['firstName'] as String,
      json['lastName'] as String,
      json['mobileNo'] as String,
      json['primaryEmail'] as String,
      json['secondaryEmail'] as String,
      json['uniqueGuiID'] as String,
      json['createdBy'] as int,
      DateTime.parse(json['createdOn'] as String),
      json['updatedBy'] as int,
      DateTime.parse(json['updatedOn'] as String),
      json['status'] as int,
      json['userPhoto'] as String,
      json['iSDCode'] as String,
      json['userRole'] as String,
      json['lLISDCode'] as String,
      json['landline'] as String,
      json['lat'] as String,
      json['lng'] as String,
      json['userLanguage'] as String,
      json['firstLogin'] as bool,
      json['otpCode'] as String,
      json['externalScimId'] as String,
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'userId': instance.userId,
      'companyId': instance.companyId,
      'registeredUser': instance.registeredUser,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'mobileNo': instance.mobileNo,
      'primaryEmail': instance.primaryEmail,
      'secondaryEmail': instance.secondaryEmail,
      'uniqueGuiID': instance.uniqueGuiID,
      'createdBy': instance.createdBy,
      'createdOn': instance.createdOn.toIso8601String(),
      'updatedBy': instance.updatedBy,
      'updatedOn': instance.updatedOn.toIso8601String(),
      'status': instance.status,
      'userPhoto': instance.userPhoto,
      'iSDCode': instance.iSDCode,
      'userRole': instance.userRole,
      'lLISDCode': instance.lLISDCode,
      'landline': instance.landline,
      'lat': instance.lat,
      'lng': instance.lng,
      'userLanguage': instance.userLanguage,
      'firstLogin': instance.firstLogin,
      'otpCode': instance.otpCode,
      'externalScimId': instance.externalScimId,
    };
