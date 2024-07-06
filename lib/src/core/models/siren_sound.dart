import 'package:crises_control/src/core/constants.dart';
import 'package:equatable/equatable.dart';

class SirenSound extends Equatable {
  const SirenSound(this.soundName, this.soundFile);
  final String soundName;
  final String soundFile;

  @override
  List<Object?> get props => [soundName, soundFile];

  static List<SirenSound> sirenSounds = [
    const SirenSound('Beeping', AudioAssetsConstants.beeping),
    const SirenSound('Bell Chime', AudioAssetsConstants.bell_chime),
    const SirenSound('Jetta Horn', AudioAssetsConstants.jetta_horn),
    const SirenSound('Ring 1', AudioAssetsConstants.ring1),
    const SirenSound('Ring 2', AudioAssetsConstants.ring2),
    const SirenSound('Ring 3', AudioAssetsConstants.ring3),
    const SirenSound('SMS Alert', AudioAssetsConstants.sms_alert),
    const SirenSound('Space Siren', AudioAssetsConstants.space_siren),
    const SirenSound('Whooping', AudioAssetsConstants.whooping),
  ];
}
