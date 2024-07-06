// ignore_for_file: public_member_api_docs, sort_constructors_first, use_super_parameters
import 'package:crises_control/src/core/message_recipients/cubit/message_recipients_cubit.dart';
//import 'package:crises_control/src/core/message_recipients/models/acknowledge_status.dart';
import 'package:crises_control/src/core/models/message_acknowledge_status_response.dart';
import 'package:crises_control/src/core/presentation/styles/text/material_colors_helper.dart';
import 'package:crises_control/src/core/presentation/widgets/cc_activity_indicator.dart';
import 'package:crises_control/src/core/presentation/widgets/custom_widgets.dart';
//import 'package:crises_control/src/core/utils/extensions/string_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MessageRecipientsPage extends StatefulWidget {
  const MessageRecipientsPage({
    Key? key,
  }) : super(key: key);

  @override
  State<MessageRecipientsPage> createState() => _MessageRecipientsPageState();
}

class _MessageRecipientsPageState extends State<MessageRecipientsPage>
    with TickerProviderStateMixin {
  late TabController _tabController;
  bool _isSelectAll = false;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var language = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(language!.title_ack_msg_status),
        actions: [
          IconButton(
              onPressed: () {
                setState(() {
                  _isSelectAll = !_isSelectAll;
                });
                context
                    .read<MessageRecipientsCubit>()
                    .selectAllTapped(_isSelectAll);
              },
              icon:
                  Icon(_isSelectAll ? Icons.playlist_remove : Icons.checklist))
        ],
        bottom: TabBar(
          onTap: (index) {
            context.read<MessageRecipientsCubit>().tabChanged(index);
          },
          isScrollable: true,
          controller: _tabController,
          tabs: <Widget>[
            Tab(text: language!.label_tab_all),
            Tab(text: language!.label_tab_ack),
            Tab(text: language!.label_tab_unack),
          ],
        ),
      ),
      bottomNavigationBar:
          BlocBuilder<MessageRecipientsCubit, MessageRecipientsState>(
        builder: (context, state) {
          return Visibility(
            visible: state.selectedCount != 0,
            child: BottomNavigationBar(
              onTap: (index) {},
              unselectedItemColor: Palette.primary,
              type: BottomNavigationBarType.fixed,
              unselectedFontSize: 8,
              selectedFontSize: 8,
              iconSize: 24,
              items: [
                BottomNavigationBarItem(
                  icon: const Icon(
                    Icons.wifi,
                    color: Palette.primary,
                  ),
                  //label: language.label_ping_message,
                ),
                BottomNavigationBarItem(
                  icon: const Icon(
                    Icons.call_merge,
                    color: Palette.primary,
                  ),
                  label: language.bottom_bar_conference,
                ),
              ],
            ),
          );
        },
      ),
      body: MessageRecipientsBody(),
    );
  }
}

class MessageRecipientsBody extends StatelessWidget {
  MessageRecipientsBody({super.key});
  final CCLoadingOverlay _loadingOverlay = CCLoadingOverlay();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MessageRecipientsCubit, MessageRecipientsState>(
      listener: (context, state) {
        if (state.status == MessageRecipientsStatus.loading) {
          _loadingOverlay.show(context);
        } else {
          _loadingOverlay.hide();
        }
      },
      builder: (context, state) {
        return ListView.builder(
          itemCount: state.acknowledgeStatusList.length,
          itemBuilder: ((buildcontext, index) {
            var recipient = state.acknowledgeStatusList[index];
            return MessageRecipientTile(
              messageAcknowledgeStatus: recipient,
              isSelected: state.selectedRecipients.contains(recipient),
            );
          }),
        );
      },
    );
  }
}

//Widgets
class MessageRecipientTile extends StatelessWidget {
  const MessageRecipientTile({
    super.key,
    required this.messageAcknowledgeStatus,
    required this.isSelected,
  });
  final MessageAcknowledgeStatus messageAcknowledgeStatus;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    var language = AppLocalizations.of(context);

    return ListTile(
      onTap: () {
        context
            .read<MessageRecipientsCubit>()
            .recipientTapped(messageAcknowledgeStatus);
      },
      onLongPress: () {
        showRecipientDetailView(context, messageAcknowledgeStatus, language);
      },
      leading: CCAvatar(senderName: messageAcknowledgeStatus.fullName),
      title: Text(messageAcknowledgeStatus.fullName),
      subtitle: AcknowledgeStatusText(
        language: language!,
        largeText: true,
        messageAcknowledgeStatus: messageAcknowledgeStatus,
      ),
      trailing: Icon(
        isSelected ? Icons.check_circle : Icons.radio_button_unchecked,
        color: isSelected ? Palette.primary : Colors.grey.shade400,
      ),
    );
  }

  Future<dynamic> showRecipientDetailView(
    BuildContext context,
    MessageAcknowledgeStatus recipient,
    AppLocalizations language,
  ) {
    return showDialog(
        context: context,
        builder: ((buildcontext) {
          return AlertDialog(
            actionsAlignment: MainAxisAlignment.center,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CCAvatar(senderName: recipient.fullName),
                const SizedBox(width: 15),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(recipient.fullName),
                    AcknowledgeStatusText(
                      language: language,
                      largeText: false,
                      messageAcknowledgeStatus: messageAcknowledgeStatus,
                    )
                  ],
                ),
              ],
            ),
            actions: <Widget>[
              Visibility(
                visible: recipient.mobileNo.isNotEmpty,
                child: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.smartphone),
                ),
              ),
              Visibility(
                visible: recipient.landline.isNotEmpty,
                child: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.phone),
                ),
              ),
              Visibility(
                visible: recipient.userEmail.isNotEmpty,
                child: IconButton(
                  onPressed: () =>
                      context.read<MessageRecipientsCubit>().onEmail(
                            email: recipient.userEmail,
                          ),
                  icon: const Icon(Icons.email),
                ),
              ),
              Visibility(
                visible: recipient.messageLat != null &&
                    recipient.messageLng != null,
                child: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.person_pin_circle),
                ),
              )
            ],
          );
        }));
  }
}

class AcknowledgeStatusText extends StatelessWidget {
  const AcknowledgeStatusText({
    Key? key,
    required this.language,
    required this.largeText,
    required this.messageAcknowledgeStatus,
  }) : super(key: key);

  final AppLocalizations language;
  final MessageAcknowledgeStatus messageAcknowledgeStatus;
  final bool largeText;

  @override
  Widget build(BuildContext context) {
    return Text(
        messageAcknowledgeStatus.isAcknowledged
            ? language.label_tab_ack
            : language.label_tab_unack,
        style: TextStyle(
          color: messageAcknowledgeStatus.isAcknowledged
              ? Colors.green
              : Colors.red,
          fontSize: largeText ? null : 12,
        ));
  }
}
