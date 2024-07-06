// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'media_attachments.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MediaAttachment _$MediaAttachmentFromJson(Map<String, dynamic> json) =>
    MediaAttachment(
      json['Title'] as String,
      json['FileName'] as String,
      json['OriginalFileName'] as String,
      json['FileSize'] as int,
      json['FilePath'] as String,
      $enumDecode(_$MediaAttachmentTypeEnumMap, json['MediaAttachmentType']),
    );

Map<String, dynamic> _$MediaAttachmentToJson(MediaAttachment instance) =>
    <String, dynamic>{
      'Title': instance.title,
      'FileName': instance.fileName,
      'OriginalFileName': instance.originalFileName,
      'FileSize': instance.fileSize,
      'FilePath': instance.filePath,
      'MediaAttachmentType':
          _$MediaAttachmentTypeEnumMap[instance.mediaAttachmentType]!,
    };

const _$MediaAttachmentTypeEnumMap = {
  MediaAttachmentType.image: 'image',
  MediaAttachmentType.audio: 'audio',
  MediaAttachmentType.video: 'video',
  MediaAttachmentType.document: 'document',
  MediaAttachmentType.website: 'website',
};
