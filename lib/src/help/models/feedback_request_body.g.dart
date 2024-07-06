// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'feedback_request_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FeedbackRequestBody _$FeedbackRequestBodyFromJson(Map<String, dynamic> json) =>
    FeedbackRequestBody(
      deviceType: json['DeviceType'] as int,
      deviceOs: json['DeviceOs'] as String,
      deviceModel: json['DeviceModel'] as String,
      feedbackMessage: json['FeedbackMessage'] as String,
      userEmail: json['UserEmail'] as String,
    );

Map<String, dynamic> _$FeedbackRequestBodyToJson(
        FeedbackRequestBody instance) =>
    <String, dynamic>{
      'DeviceType': instance.deviceType,
      'DeviceOs': instance.deviceOs,
      'DeviceModel': instance.deviceModel,
      'FeedbackMessage': instance.feedbackMessage,
      'UserEmail': instance.userEmail,
    };
