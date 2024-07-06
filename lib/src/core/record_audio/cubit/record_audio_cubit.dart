import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:crises_control/src/core/models/media_attachments.dart';
import 'package:crises_control/src/core/services/file_service.dart';
import 'package:equatable/equatable.dart';

part 'record_audio_state.dart';

class RecordAudioCubit extends Cubit<RecordAudioState> {
  RecordAudioCubit(this._fileService) : super(const RecordAudioState('', null));
  final FileService _fileService;

  useAudio(File audioFile) async {
    var fileName = audioFile.uri.pathSegments.last;
    var fileSize = await audioFile.length();
    var mediaAttachment = MediaAttachment(
      "Title",
      fileName,
      fileName,
      fileSize,
      audioFile.path,
      MediaAttachmentType.audio,
    );

    emit(RecordAudioState(audioFile.path, mediaAttachment));
  }

  generateAudioPath() async {
    var audioPath = await _fileService.createAudioFile();
    emit(RecordAudioState(audioPath, null));
  }
}
