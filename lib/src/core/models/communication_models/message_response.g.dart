// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MessageResponse _$MessageResponseFromJson(Map<String, dynamic> json) =>
    MessageResponse(
      data: (json['Data'] as List<dynamic>)
          .map((e) => AcknowledgeOption.fromJson(e as Map<String, dynamic>))
          .toList(),
      errorCode: json['ErrorCode'] as String,
    );

Map<String, dynamic> _$MessageResponseToJson(MessageResponse instance) =>
    <String, dynamic>{
      'Data': instance.data,
      'ErrorCode': instance.errorCode,
    };

AcknowledgeOption _$AcknowledgeOptionFromJson(Map<String, dynamic> json) =>
    AcknowledgeOption(
      responseId: json['ResponseId'] as int,
      libResponseId: json['LibResponseId'] as int,
      companyId: json['CompanyId'] as int,
      responseLabel: json['ResponseLabel'] as String,
      description: json['Description'] as String,
      messageType: json['MessageType'] as String,
      isSafetyResponse: json['IsSafetyResponse'] as bool,
      safetyAckAction: json['SafetyAckAction'] as String,
      updatedOn: DateTime.parse(json['UpdatedOn'] as String),
      updatedBy: json['UpdatedBy'] as int,
      status: json['Status'] as int,
    );

Map<String, dynamic> _$AcknowledgeOptionToJson(AcknowledgeOption instance) =>
    <String, dynamic>{
      'ResponseId': instance.responseId,
      'LibResponseId': instance.libResponseId,
      'CompanyId': instance.companyId,
      'ResponseLabel': instance.responseLabel,
      'Description': instance.description,
      'MessageType': instance.messageType,
      'IsSafetyResponse': instance.isSafetyResponse,
      'SafetyAckAction': instance.safetyAckAction,
      'UpdatedOn': instance.updatedOn.toIso8601String(),
      'UpdatedBy': instance.updatedBy,
      'Status': instance.status,
    };
