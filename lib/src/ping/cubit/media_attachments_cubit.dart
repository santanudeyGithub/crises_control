import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:crises_control/src/core/models/media_attachments.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../repository/ping_repository.dart';

part 'media_attachments_state.dart';

class MediaAttachmentsCubit extends Cubit<MediaAttachmentsState> {
  MediaAttachmentsCubit(this._pingRepository)
      : super(const MediaAttachmentsState(
            [], 0, MediaAttachmentActionType.none, ''));
  final List<MediaAttachment> _mediaAttachments = [];
  final PingRepository _pingRepository;

  addAudioMediaAttachment(MediaAttachment mediaAttachment) {
    _mediaAttachments.add(mediaAttachment);
    var count = _mediaAttachments.length;
    emit(MediaAttachmentsState(_mediaAttachments, count,
        MediaAttachmentActionType.addAudio, mediaAttachment.fileName));
  }

  addAllAudioMediaAttachment(List<MediaAttachment> mediaAttachment) {
    _mediaAttachments.addAll(mediaAttachment);
    var count = _mediaAttachments.length;
    emit(MediaAttachmentsState(
        _mediaAttachments, count, MediaAttachmentActionType.addAudio, ''));
  }

  takePicture({
    required bool fromGallery,
    required bool isVideo,
    required saveToGallery,
  }) async {
    var mediaAttachment = await _pingRepository.addMediaAttachment(
      fromGallery: fromGallery,
      isVideo: isVideo,
      saveToGallery: saveToGallery,
    );
    if (mediaAttachment != null) {
      var count = _mediaAttachments.length;
      _mediaAttachments.add(mediaAttachment);
      emit(MediaAttachmentsState(_mediaAttachments, count,
          MediaAttachmentActionType.addPhotoOrVideo, mediaAttachment.fileName));
    }
  }

  renameMediaAttachment(MediaAttachment mediaAttachment, String title) {
    var index = _mediaAttachments.indexOf(mediaAttachment);
    _mediaAttachments.remove(mediaAttachment);
    log(index.toString());
    _mediaAttachments.insert(index, mediaAttachment.copyWith(title: title));
    var count = _mediaAttachments.length;
    emit(MediaAttachmentsState(_mediaAttachments, count,
        MediaAttachmentActionType.renameMedia, title));
  }

  removeMediaAttachment(MediaAttachment mediaAttachment) {
    _mediaAttachments.remove(mediaAttachment);
    var count = _mediaAttachments.length;
    emit(MediaAttachmentsState(_mediaAttachments, count,
        MediaAttachmentActionType.removeMedia, mediaAttachment.fileName));
  }
}
