import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'media_attachments_rq.g.dart';

@JsonSerializable(fieldRename: FieldRename.pascal)
class MediaAttachmentsRq extends Equatable {
  const MediaAttachmentsRq({
    required this.title,
    required this.fileName,
    required this.originalFileName,
    required this.fileSize,
    required this.attachmentType,
  });

  final String title;
  final String fileName;
  final String originalFileName;
  final int fileSize;
  final int attachmentType;

  factory MediaAttachmentsRq.fromJson(Map<String, dynamic> json) =>
      _$MediaAttachmentsRqFromJson(json);

  Map<String, dynamic> toJson() => _$MediaAttachmentsRqToJson(this);

  @override
  List<Object?> get props => [
        title,
        fileName,
        originalFileName,
        fileSize,
        attachmentType,
      ];
}
