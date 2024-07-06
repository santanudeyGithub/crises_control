// ignore_for_file: must_be_immutable

import 'package:crises_control/src/core/models/siren_sound.dart';
import 'package:crises_control/src/core/presentation/widgets/custom_widgets.dart';
import 'package:crises_control/src/ping/bloc/bloc.dart';
import 'package:crises_control/src/settings/cubit/siren_sound_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SirenSoundPage extends StatelessWidget {
  SirenSoundPage({super.key});
  List<SirenSound> selectedSirenSounds = [];

  @override
  Widget build(BuildContext context) {
    final language = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(language!.siren_for_notifications),
        actions: selectedSirenSounds.isNotEmpty
            ? [IconButton(onPressed: () {}, icon: const Icon(Icons.save))]
            : null,
      ),
      body: SirenSoundBody(selectedSirenSounds: selectedSirenSounds),
    );
  }
}

class SirenSoundBody extends StatefulWidget {
  const SirenSoundBody({super.key, required this.selectedSirenSounds});
  final List<SirenSound> selectedSirenSounds;

  @override
  State<SirenSoundBody> createState() => _SirenSoundBodyState();
}

class _SirenSoundBodyState extends State<SirenSoundBody> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: SirenSound.sirenSounds.length,
      itemBuilder: (context, index) {
        final sirenSound = SirenSound.sirenSounds[index];
        return SelectionListTile(
          title: sirenSound.soundName,
          onTap: () {
            context.read<SirenSoundCubit>().play(sirenSound.soundFile);
            setState(() {
              widget.selectedSirenSounds.clear();
              widget.selectedSirenSounds.add(sirenSound);
            });
          },
          isSelected: widget.selectedSirenSounds.contains(sirenSound),
        );
      },
    );
  }
}
