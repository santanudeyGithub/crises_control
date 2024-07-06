part of 'record_audio_cubit.dart';

class RecordAudioState extends Equatable {
  const RecordAudioState(this.audioPath, this.mediaAttachment);
  final String audioPath;
  final MediaAttachment? mediaAttachment;

  @override
  List<Object?> get props => [audioPath, mediaAttachment];
}
