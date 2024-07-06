// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'company_comms_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CompanyCommsResponse _$CompanyCommsResponseFromJson(
        Map<String, dynamic> json) =>
    CompanyCommsResponse(
      data: CompanyCommsResponseData.fromJson(
          json['Data'] as Map<String, dynamic>),
      errorCode: json['ErrorCode'] as String,
    );

Map<String, dynamic> _$CompanyCommsResponseToJson(
        CompanyCommsResponse instance) =>
    <String, dynamic>{
      'Data': instance.data,
      'ErrorCode': instance.errorCode,
    };

CompanyCommsResponseData _$CompanyCommsResponseDataFromJson(
        Map<String, dynamic> json) =>
    CompanyCommsResponseData(
      priority: (json['Priority'] as List<dynamic>)
          .map((e) => Priority.fromJson(e as Map<String, dynamic>))
          .toList(),
      priorityMethod: (json['PriorityMethod'] as List<dynamic>)
          .map((e) => PriorityMethod.fromJson(e as Map<String, dynamic>))
          .toList(),
      objectInfo: (json['ObjectInfo'] as List<dynamic>)
          .map((e) => MessageMethod.fromJson(e as Map<String, dynamic>))
          .toList(),
      billUsers: (json['BillUsers'] as List<dynamic>)
          .map((e) => BillUser.fromJson(e as Map<String, dynamic>))
          .toList(),
      hasLowBalance: json['HasLowBalance'] as String,
    );

Map<String, dynamic> _$CompanyCommsResponseDataToJson(
        CompanyCommsResponseData instance) =>
    <String, dynamic>{
      'Priority': instance.priority,
      'PriorityMethod': instance.priorityMethod,
      'ObjectInfo': instance.objectInfo,
      'BillUsers': instance.billUsers,
      'HasLowBalance': instance.hasLowBalance,
    };

BillUser _$BillUserFromJson(Map<String, dynamic> json) => BillUser(
      userId: json['UserId'] as int,
      userName: UserName.fromJson(json['UserName'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$BillUserToJson(BillUser instance) => <String, dynamic>{
      'UserId': instance.userId,
      'UserName': instance.userName,
    };

UserName _$UserNameFromJson(Map<String, dynamic> json) => UserName(
      firstname: json['Firstname'] as String,
      lastname: json['Lastname'] as String,
    );

Map<String, dynamic> _$UserNameToJson(UserName instance) => <String, dynamic>{
      'Firstname': instance.firstname,
      'Lastname': instance.lastname,
    };

MessageMethod _$MessageMethodFromJson(Map<String, dynamic> json) =>
    MessageMethod(
      methodId: json['MethodId'] as int,
      serviceStatus: json['ServiceStatus'] as bool,
      status: json['Status'] as int,
      methodName: json['MethodName'] as String,
    );

Map<String, dynamic> _$MessageMethodToJson(MessageMethod instance) =>
    <String, dynamic>{
      'MethodId': instance.methodId,
      'ServiceStatus': instance.serviceStatus,
      'Status': instance.status,
      'MethodName': instance.methodName,
    };

Priority _$PriorityFromJson(Map<String, dynamic> json) => Priority(
      id: json['Id'] as int,
      companyId: json['CompanyId'] as int,
      cascadingPlanId: json['CascadingPlanId'] as int?,
      messageType: json['MessageType'] as String,
      priority: json['Priority'] as int,
      interval: json['Interval'] as int,
      methods: json['Methods'] as String,
    );

Map<String, dynamic> _$PriorityToJson(Priority instance) => <String, dynamic>{
      'Id': instance.id,
      'CompanyId': instance.companyId,
      'CascadingPlanId': instance.cascadingPlanId,
      'MessageType': instance.messageType,
      'Priority': instance.priority,
      'Interval': instance.interval,
      'Methods': instance.methods,
    };

PriorityMethod _$PriorityMethodFromJson(Map<String, dynamic> json) =>
    PriorityMethod(
      id: json['Id'] as int,
      companyId: json['CompanyId'] as int,
      priorityLevel: json['PriorityLevel'] as int,
      methods: json['Methods'] as String,
      messageType: json['MessageType'] as String,
    );

Map<String, dynamic> _$PriorityMethodToJson(PriorityMethod instance) =>
    <String, dynamic>{
      'Id': instance.id,
      'CompanyId': instance.companyId,
      'PriorityLevel': instance.priorityLevel,
      'Methods': instance.methods,
      'MessageType': instance.messageType,
    };
