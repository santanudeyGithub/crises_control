import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'media_attachments.g.dart';

@JsonSerializable(fieldRename: FieldRename.pascal)
class MediaAttachment extends Equatable {
  const MediaAttachment(
    this.title,
    this.fileName,
    this.originalFileName,
    this.fileSize,
    this.filePath,
    this.mediaAttachmentType,
  );
  final String title;
  final String fileName;
  final String originalFileName;
  final int fileSize;
  final String filePath;
  final MediaAttachmentType mediaAttachmentType;

  @override
  List<Object?> get props => [
        title,
        fileName,
        originalFileName,
        fileSize,
        filePath,
        mediaAttachmentType,
      ];

  factory MediaAttachment.fromJson(Map<String, dynamic> json) =>
      _$MediaAttachmentFromJson(json);

  Map<String, dynamic> toJson() => _$MediaAttachmentToJson(this);

  MediaAttachment copyWith({
    String? title,
    String? fileName,
    String? originalFileName,
    int? fileSize,
    String? filePath,
    MediaAttachmentType? mediaAttachmentType,
  }) {
    return MediaAttachment(
      title ?? this.title,
      fileName ?? this.fileName,
      originalFileName ?? this.originalFileName,
      fileSize ?? this.fileSize,
      filePath ?? this.filePath,
      mediaAttachmentType ?? this.mediaAttachmentType,
    );
  }

  // MediaAttachmentsRq toMediaAttachmentRq() {
  //   return MediaAttachmentsRq(
  //     title: title,
  //   fileName: fileName,
  //   originalFileName: originalFileName,
  //   fileSize: fileSize,
  //   // attachmentType: attachmentType,
  //   );
  // }
}

//AttachmentType 1 = Image, 2 = Audio, 3 = Video, 4 = Document
enum MediaAttachmentType { image, audio, video, document, website }
