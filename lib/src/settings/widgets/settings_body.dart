import 'package:crises_control/src/core/presentation/styles/text/material_colors_helper.dart';
import 'package:crises_control/src/core/router/route_constants.dart';
import 'package:flutter/material.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SettingsBody extends StatelessWidget {
  const SettingsBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SettingsList(
      sections: [
        SettingsSection(
          title: Text(AppLocalizations.of(context)!.common_settings),
          tiles: <SettingsTile>[
            SettingsTile.navigation(
              leading: const Icon(
                Icons.manage_accounts_outlined,
                color: Palette.primary,
              ),
              title: Text(AppLocalizations.of(context)!.title_my_account),
            ),
            SettingsTile.navigation(
              leading: const Icon(
                Icons.password_outlined,
                color: Palette.primary,
              ),
              title: const Text('Change Password'),
            ),
            SettingsTile.navigation(
              leading: const Icon(
                Icons.translate,
                color: Palette.primary,
              ),
              title: Text(AppLocalizations.of(context)!.label_language),
              value: const Text('English'),
              onPressed: (context) => Navigator.pushNamed(
                context,
                RouteConstants.chooseLanguage,
              ),
            ),
            SettingsTile.switchTile(
              leading: const Icon(
                Icons.security_update,
                color: Palette.primary,
              ),
              title:
                  Text(AppLocalizations.of(context)!.label_setting_store_plans),
              initialValue: false,
              onToggle: (value) {},
            ),
            SettingsTile.switchTile(
              leading: const Icon(
                Icons.sos,
                color: Palette.primary,
              ),
              title: Text(AppLocalizations.of(context)!.label_setting_sos),
              initialValue: false,
              onToggle: (value) {},
            ),
            SettingsTile.switchTile(
              leading: const Icon(
                Icons.text_fields,
                color: Palette.primary,
              ),
              title:
                  Text(AppLocalizations.of(context)!.label_setting_large_font),
              initialValue: false,
              onToggle: (value) {},
            ),
          ],
        ),
        SettingsSection(
          title: Text(AppLocalizations.of(context)!.location_settings),
          tiles: <SettingsTile>[
            SettingsTile.switchTile(
              leading: const Icon(
                Icons.person_pin_circle,
                color: Palette.primary,
              ),
              title: Text(AppLocalizations.of(context)!.label_setting_track_me),
              initialValue: false,
              onToggle: (bool value) {},
            ),
            SettingsTile.switchTile(
              leading: const Icon(
                Icons.fmd_bad_outlined,
                color: Palette.primary,
              ),
              title: Text(AppLocalizations.of(context)!
                  .label_setting_track_me_during_incident),
              initialValue: false,
              onToggle: (bool value) {},
            ),
          ],
        ),
        SettingsSection(
          title: Text(AppLocalizations.of(context)!.siren_settings),
          tiles: <SettingsTile>[
            SettingsTile.switchTile(
              leading: const Icon(
                Icons.volume_up_outlined,
                color: Palette.primary,
              ),
              initialValue: true,
              onToggle: (value) {},
              title:
                  Text(AppLocalizations.of(context)!.siren_for_notifications),
            ),
            SettingsTile.navigation(
              leading: const Icon(
                Icons.queue_music_outlined,
                color: Palette.primary,
              ),
              title: Text(AppLocalizations.of(context)!
                  .label_setting_choose_siren_sound),
              onPressed: (context) => Navigator.pushNamed(
                context,
                RouteConstants.sirenSoundPage,
              ),
            ),
          ],
        ),
        SettingsSection(
          tiles: <SettingsTile>[
            SettingsTile.navigation(
              leading: const Icon(
                Icons.event_busy,
                color: Palette.primary,
              ),
              title: Text(AppLocalizations.of(context)!.label_setting_offcall),
              onPressed: (context) => Navigator.pushNamed(
                context,
                RouteConstants.offDutySettingsPage,
              ),
            ),
            SettingsTile.navigation(
              leading: const Icon(
                Icons.logout,
                color: Palette.primary,
              ),
              title: Text(AppLocalizations.of(context)!.menu_logout),
            ),
          ],
        ),
      ],
    );
  }
}
