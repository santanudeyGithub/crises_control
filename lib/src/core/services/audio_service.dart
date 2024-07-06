import 'package:audioplayers/audioplayers.dart';
import 'package:crises_control/src/core/constants.dart';

class AudioService {
  AudioPlayer player = AudioPlayer();

  Future<void> play(String fileName) async {
    var path =
        '${AudioAssetsConstants.audioPath}${fileName}_1${AudioAssetsConstants.audioAssetsExtension}';
    await player.play(AssetSource(path));
  }
}
