import 'package:bloc/bloc.dart';
import 'package:crises_control/src/core/services/audio_service.dart';
import 'package:equatable/equatable.dart';

part 'siren_sound_state.dart';

class SirenSoundCubit extends Cubit<SirenSoundState> {
  SirenSoundCubit() : super(SirenSoundInitial());

  AudioService mediaService = AudioService();

  Future<void> play(String fileName) async {
    await mediaService.play(fileName);
  }
}
