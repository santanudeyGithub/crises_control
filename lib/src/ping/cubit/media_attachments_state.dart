// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'media_attachments_cubit.dart';

enum MediaAttachmentActionType {
  addPhotoOrVideo,
  addAudio,
  removeMedia,
  renameMedia,
  none
}

@immutable
class MediaAttachmentsState extends Equatable {
  const MediaAttachmentsState(this.mediaAttachments, this.mediaAttachmentsCount,
      this.mediaAttachmentActionType, this.mediaTitle);
  final List<MediaAttachment> mediaAttachments;
  final int mediaAttachmentsCount;
  final MediaAttachmentActionType mediaAttachmentActionType;
  final String mediaTitle;

  @override
  List<Object?> get props => [
        mediaAttachments,
        mediaAttachmentsCount,
        mediaAttachmentActionType,
        mediaTitle
      ];

  MediaAttachmentsState copyWith({
    List<MediaAttachment>? mediaAttachments,
    int? mediaAttachmentsCount,
    MediaAttachmentActionType? mediaAttachmentActionType,
    String? mediaTitle,
  }) {
    return MediaAttachmentsState(
      mediaAttachments ?? this.mediaAttachments,
      mediaAttachmentsCount ?? this.mediaAttachmentsCount,
      mediaAttachmentActionType ?? this.mediaAttachmentActionType,
      mediaTitle ?? this.mediaTitle,
    );
  }
}
