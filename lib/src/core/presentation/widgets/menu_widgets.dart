// ignore_for_file: use_super_parameters, prefer_final_fields, unused_element

import 'package:crises_control/src/core/constants.dart';
import 'package:crises_control/src/core/models/audio_message.dart';
import 'package:crises_control/src/core/models/communication_models/company_comms_response.dart';
import 'package:crises_control/src/core/models/communication_models/message_response.dart';
import 'package:crises_control/src/core/models/list_models/locations.dart';
import 'package:crises_control/src/core/presentation/styles/text/material_colors_helper.dart';
import 'package:crises_control/src/core/repository/crises_control_core_repository.dart';
import 'package:crises_control/src/core/router/page_arguments/page_arguments.dart';
import 'package:crises_control/src/core/router/route_constants.dart';
import 'package:crises_control/src/core/utils/common.dart';
import 'package:crises_control/src/ping/ping.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'cc_text_field.dart';

enum MenuRowType {
  whoToNotify,
  message,
  locations,
  groups,
  departments,
  users,
  incidentManagers,
  impactedLocation,
  advancedOptions,
  communicationPreferences,
}

class MenuRow extends StatelessWidget {
  const MenuRow({
    Key? key,
    required this.icon,
    required this.title,
    required this.type,
    required this.onPressed,
    required this.subtitle,
    this.arrowColor = Palette.primary,
    required this.messageType,
    required this.imagePath,
  }) : super(key: key);

  final IconData icon;
  final String title;
  final MenuRowType type;
  final String subtitle;
  final VoidCallback onPressed;
  final Color arrowColor;
  final String messageType;
  final String imagePath;

  @override
  Widget build(BuildContext context) {
    if (messageType == BackendConstants.messageTypePing) {
      return ListTile(
        leading: Icon(icon, color: Palette.primary),
        title: Text(title),
        subtitle: Text(
          subtitle,
          style:
              Theme.of(context).textTheme.bodySmall?.apply(color: Colors.grey),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        trailing: const Icon(Icons.chevron_right, color: Colors.blue),
        onTap: onPressed,
      );
    } else {
      return TextButton(
        onPressed: onPressed,
        child: Column(
          children: [
            Row(
              children: [
                //Icon(icon),
                // Image(
                //   image: AssetImage('assets/images/Messages_icon_new.png'),
                //   height: 55,
                //   width: 55,
                // ),
                Image.asset(
                  imagePath,
                  width: 50.0,
                  height: 50.0,
                  fit: BoxFit.cover,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                      Visibility(
                        visible: subtitle.length > 1,
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width - 80,
                          child: Text(
                            subtitle,
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.apply(color: Colors.grey),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                Icon(
                  Icons.navigate_next,
                  color: arrowColor,
                )
              ],
            ),
          ],
        ),
      );
    }
  }
}

class AdvanceOptionsMenuRow extends StatefulWidget {
  const AdvanceOptionsMenuRow({
    Key? key,
    required this.icon,
    required this.onPressed,
    required this.isPing,
    required this.onAffectedLocationsPressed,
    required this.acknowledgeOptions,
    required this.imagePath,
  }) : super(key: key);

  final IconData icon;
  final bool isPing;
  final VoidCallback onPressed;
  final VoidCallback onAffectedLocationsPressed;
  final List<String> acknowledgeOptions;
  final String imagePath;

  @override
  State<AdvanceOptionsMenuRow> createState() => _AdvanceOptionsMenuRowState();
}

class _AdvanceOptionsMenuRowState extends State<AdvanceOptionsMenuRow> {
  bool _showContent = false;
  bool _trackUser = false;
  bool _slientMessage = false;
  List<LocationsData> _impactedLocations = [];
  List<AcknowledgeOption> _selectedAcknowledgeOptions = [];
  List<AudioMessage> _selectedAudioMessages = [];

  @override
  Widget build(BuildContext context) {
    var language = AppLocalizations.of(context);
    return Column(
      children: [
        TextButton(
          onPressed: (() {
            setState(() {
              _showContent = !_showContent;
            });
          }),
          child: Column(
            children: [
              Row(
                children: [
                  // Icon(widget.icon),
                  Image.asset(
                    widget.imagePath,
                    width: 50.0,
                    height: 50.0,
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        language!.label_advanced_options,
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                    ],
                  ),
                  const Spacer(),
                  Icon(
                    _showContent ? Icons.expand_less : Icons.expand_more,
                    color: Colors.blue,
                  )
                ],
              ),
            ],
          ),
        ),
        Visibility(
          visible: _showContent &&
              RepositoryProvider.of<CrisesControlCoreRepository>(context)
                  .checkMenuAccess(SecItemKeys.incidentAudioMessage),
          child: TextButton(
            onPressed: _onAudioMessage,
            child: _AdvancedMenuRow(
              title: language.label_audio_message,
              icon: Icons.lyrics,
              imagePath: 'assets/images/audiomessage.png',
              isVisible: _showContent,
              trailing: const Icon(Icons.navigate_next),
              subtitle:
                  ListHelpers.audioMessageListToString(_selectedAudioMessages),
            ),
          ),
        ),
        Visibility(
          visible: _showContent && widget.isPing == false,
          child: TextButton(
            onPressed: widget.onAffectedLocationsPressed,
            child: _AdvancedMenuRow(
              title: language.label_affected_location,
              icon: Icons.pin_drop,
              imagePath: 'assets/images/Incident@.png',
              isVisible: _showContent,
              trailing: const Icon(Icons.navigate_next),
              subtitle: ListHelpers.locationListToString(_impactedLocations),
            ),
          ),
        ),
        Visibility(
          visible: _showContent,
          child: TextButton(
            onPressed: () => _onAcknowledgeOptions(
              messageType: widget.isPing ? 'Ping' : 'Incident',
            ),
            child: _AdvancedMenuRow(
              title: language.label_acknowledge_options,
              icon: Icons.check,
              imagePath: 'assets/images/AcknowledgeOptions.png',
              isVisible: _showContent,
              trailing: const Icon(Icons.navigate_next),
              subtitle: ListHelpers.acknowledgeOptionsListToString(
                  _selectedAcknowledgeOptions),
            ),
          ),
        ),
        Visibility(
          visible: _showContent,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
            child: _AdvancedMenuRow(
              title: language.label_silent_message,
              icon: Icons.volume_off,
              imagePath: 'assets/images/SocialPost.png',
              isVisible: _showContent,
              trailing: Switch(
                value: _slientMessage,
                activeColor: Colors.blue,
                onChanged: (bool value) {
                  setState(() {
                    _slientMessage = value;
                  });
                },
              ),
            ),
          ),
        ),
        Visibility(
          visible: _showContent && widget.isPing == false,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
            child: _AdvancedMenuRow(
              title: language.label_track_user,
              imagePath: 'assets/images/SilentMessage.png',
              icon: Icons.person_pin_circle,
              isVisible: _showContent,
              trailing: Switch(
                value: _trackUser,
                activeColor: Colors.blue,
                onChanged: (bool value) {
                  setState(() {
                    _trackUser = value;
                  });
                },
              ),
            ),
          ),
        ),
        Visibility(
          visible: _showContent && widget.isPing == false,
          child: _AdvancedMenuRow(
            title: language.label_social_post,
            icon: Icons.lyrics,
            imagePath: 'assets/images/SocialPost.png',
            isVisible: _showContent,
            trailing: const Icon(Icons.navigate_next),
            subtitle:
                ListHelpers.audioMessageListToString(_selectedAudioMessages),
          ),
        ),
      ],
    );
  }

  _onImpactedLocations() async {
    final locations =
        await Navigator.pushNamed(context, RouteConstants.locationsListPage,
            arguments: LocationListPageArguments(
              _impactedLocations,
              LocationListType.impacted,
            )) as List<LocationsData>;
    setState(() {
      _impactedLocations = locations;
    });
  }

  _onAcknowledgeOptions({required String messageType}) async {
    final acknowledgeOptions = await Navigator.pushNamed(
      context,
      RouteConstants.acknowledgeOptionsListPage,
      arguments: AcknowledgeOptionsListPageArguments(
        _selectedAcknowledgeOptions,
        messageType,
        0,
      ),
    ) as List<AcknowledgeOption>;
    setState(
      () {
        _selectedAcknowledgeOptions = acknowledgeOptions;
      },
    );
  }

  _onAudioMessage() async {
    final audioMessages = await Navigator.pushNamed(
      context,
      RouteConstants.audioMessagesListPage,
      arguments: AudioMessagesListPageArguments(_selectedAudioMessages),
    ) as List<AudioMessage>;
    setState(
      () {
        _selectedAudioMessages = audioMessages;
      },
    );
  }
}

class _AdvancedMenuRow extends StatelessWidget {
  const _AdvancedMenuRow({
    Key? key,
    required this.title,
    required this.isVisible,
    required this.trailing,
    required this.icon,
    required this.imagePath,
    this.subtitle = '',
  }) : super(key: key);

  final String title;
  final String subtitle;
  final bool isVisible;
  final Widget trailing;
  final IconData icon;
  final String imagePath;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Divider(),
        Row(
          children: [
            // Icon(icon),
            Image.asset(
              imagePath,
              width: 50.0,
              height: 50.0,
              fit: BoxFit.cover,
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.labelLarge,
                ),
                Visibility(
                  visible: subtitle.length > 1,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width - 80,
                    child: Text(
                      subtitle,
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall
                          ?.apply(color: Colors.grey),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                )
              ],
            ),
            const Spacer(),
            trailing
          ],
        ),
      ],
    );
  }
}

class FloatingAcknowledgedButton extends StatelessWidget {
  const FloatingAcknowledgedButton({
    Key? key,
    required this.onPressed,
  }) : super(key: key);
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: 250,
      child: FloatingActionButton(
        onPressed: onPressed,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        backgroundColor: const Color(0xff1E60AA),
        // child: Text(AppLocalizations.of(context)!.btn_label_acknowledge,
        //     style: const TextStyle(fontSize: UIConstants.buttonTextSize)),
        child: Text(AppLocalizations.of(context)!.btn_label_acknowledge,
            style: const TextStyle(fontSize: UIConstants.buttonTextSize)),
      ),
    );
  }
}

class MessageBottomMenu extends StatefulWidget {
  const MessageBottomMenu({
    Key? key,
  }) : super(key: key);

  @override
  State<MessageBottomMenu> createState() => _MessageBottomMenuState();
}

enum MessageMenuItem { reply, replyAll, renotify, recipients }

class _MessageBottomMenuState extends State<MessageBottomMenu> {
  final double _spacing = 10;

  final TextEditingController textEditingController = TextEditingController();
  List<MessageMethod> _selectedMessageMethods = [];
  @override
  Widget build(BuildContext context) {
    return ListView(shrinkWrap: true, children: [
      SizedBox(height: _spacing),
      PopupMenuItem(
        value: MessageMenuItem.reply,
        child: PingMenuItemRow(
          icon: Icons.reply,
          text: Text(AppLocalizations.of(context)!.label_reply),
        ),
      ),
      SizedBox(height: _spacing),
      PopupMenuItem(
        value: MessageMenuItem.replyAll,
        child: PingMenuItemRow(
          icon: Icons.reply_all,
          text: Text(AppLocalizations.of(context)!.label_replyall),
        ),
      ),
      SizedBox(height: _spacing),
      PopupMenuItem(
        value: MessageMenuItem.renotify,
        onTap: () {
          Future(() => renotifyUsers(context));
        },
        child: PingMenuItemRow(
          icon: Icons.notifications_active,
          text: Text(AppLocalizations.of(context)!.label_renotify),
        ),
      ),
      SizedBox(height: _spacing),
      PopupMenuItem(
        onTap: () => Future(() =>
            Navigator.pushNamed(context, RouteConstants.messageRecipientsPage)),
        value: MessageMenuItem.recipients,
        child: PingMenuItemRow(
          icon: Icons.people,
          text: Text(AppLocalizations.of(context)!.title_ack_msg_status),
        ),
      ),
    ]);
  }

  renotifyUsers(BuildContext context) {
    var language = AppLocalizations.of(context);
    return showDialog(
      context: context,
      builder: (buildContext) {
        return SimpleDialog(
          title: FittedBox(
            fit: BoxFit.fitWidth,
            child: Text(language!.label_renotify),
          ),
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: MessageTextField(
                textEditingController: textEditingController,
                type: MessageTextFieldType.reply,
              ),
            ),
            MenuRow(
              icon: Icons.podcasts,
              title: language.myaccount_comm_prefs,
              type: MenuRowType.communicationPreferences,
              onPressed: () {},
              subtitle: ListHelpers.messsageMethodsListToString(
                  _selectedMessageMethods),
              messageType: BackendConstants.messageTypeIncident,
              imagePath: 'assets/images/Channel_Cascading_Plan.png',
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                  onPressed: (() {
                    Navigator.pop(context);
                  }),
                  child: Text(language.cancel),
                ),
                TextButton(
                  onPressed: (() => Navigator.pop(context)),
                  child: Text(language.ok),
                )
              ],
            ),
          ],
        );
      },
    );
  }

  // _onCommunicationPreferences(BuildContext buildContext) async {
  //   final messageMethods = await Navigator.pushNamed(
  //       buildContext, RouteConstants.communicationPrefencesListPage,
  //       arguments: CommunicationPrefencesListPageArguments(
  //           _selectedMessageMethods, [])) as List<MessageMethod>;
  //   setState(() {
  //     _selectedMessageMethods = messageMethods;
  //   });
  // }
}
