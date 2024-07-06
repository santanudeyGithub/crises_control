// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'media_attachments_rq.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MediaAttachmentsRq _$MediaAttachmentsRqFromJson(Map<String, dynamic> json) =>
    MediaAttachmentsRq(
      title: json['Title'] as String,
      fileName: json['FileName'] as String,
      originalFileName: json['OriginalFileName'] as String,
      fileSize: json['FileSize'] as int,
      attachmentType: json['AttachmentType'] as int,
    );

Map<String, dynamic> _$MediaAttachmentsRqToJson(MediaAttachmentsRq instance) =>
    <String, dynamic>{
      'Title': instance.title,
      'FileName': instance.fileName,
      'OriginalFileName': instance.originalFileName,
      'FileSize': instance.fileSize,
      'AttachmentType': instance.attachmentType,
    };
