import 'package:crises_control/src/core/models/communication_models/company_comms_response.dart';
import 'package:crises_control/src/core/models/communication_models/selected_communication.dart';
import 'package:crises_control/src/ping/models/ping.dart';
import 'package:crises_control/src/ping/repository/ping_repository.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:crises_control/src/core/models/communication_models/company_comms_response.dart';
import 'package:crises_control/src/core/models/communication_models/selected_communication.dart';
import 'package:crises_control/src/core/presentation/pages/message_replies_page.dart';
import 'package:crises_control/src/core/presentation/styles/text/material_colors_helper.dart';
import 'package:crises_control/src/core/presentation/widgets/cc_text_field.dart';
import 'package:crises_control/src/core/presentation/widgets/menu_widgets.dart';
import 'package:crises_control/src/core/router/page_arguments/page_arguments.dart';
import 'package:crises_control/src/core/router/route_constants.dart';
import 'package:crises_control/src/core/utils/common.dart';
import 'package:crises_control/src/core/utils/enum_helpers.dart';
import 'package:crises_control/src/ping/cubit/ping_details/ping_details_cubit.dart';
import 'package:crises_control/src/ping/models/ping.dart';
import 'package:crises_control/src/ping/repository/ping_repository.dart';
import 'package:crises_control/src/ping/widgets/ping_details_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/svg.dart';

class ReplyDialogPage extends StatefulWidget {
  final ReplyType replyTo;
  final PingData selectedPing;

  ReplyDialogPage({required this.replyTo, required this.selectedPing});

  @override
  _ReplyDialogPageState createState() => _ReplyDialogPageState();
}

class _ReplyDialogPageState extends State<ReplyDialogPage> {
  final TextEditingController textEditingController = TextEditingController();
  List<SelectedCommunication> selectedCommunicationPreferences = [];
  List<MessageMethod> communicationMethods = [];

  @override
  Widget build(BuildContext context) {
    var language = AppLocalizations.of(context);
    var title = widget.replyTo == ReplyType.all
        ? language!.label_replyall
        : language!.label_reply;

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            MessageTextField(
              textEditingController: textEditingController,
              type: MessageTextFieldType.reply,
            ),
            ListTile(
              title: Text(language.label_communication_messages),
              leading: const Icon(Icons.podcasts),
              subtitle: Text(
                ListHelpers.selectedMessageMethodListToString(
                  selectedCommunicationPreferences,
                ),
                style: TextStyle(color: Colors.grey.shade800),
              ),
              iconColor: Palette.primary,
              onTap: () async {
                final result = await _onCommunicationChannels(
                  context,
                  selectedCommunicationPreferences,
                  communicationMethods,
                );
                setState(() {
                  selectedCommunicationPreferences = result;
                });
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(language.cancel),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    if (widget.replyTo == ReplyType.renotify) {
                      context.read<PingDetailsCubit>().renotifyUnacknowledged(
                            message: textEditingController.text,
                            ping: widget.selectedPing,
                            cascadingPlanId: 0,
                            messageMethods: selectedCommunicationPreferences
                                .map((e) => e.id)
                                .toList(),
                          );
                    } else {
                      context.read<PingDetailsCubit>().replyToPing(
                            message: textEditingController.text,
                            ping: widget.selectedPing,
                            messageMethods: selectedCommunicationPreferences
                                .map((e) => e.id)
                                .toList(),
                            replyTo: ReplyType.sender,
                          );
                    }
                  },
                  child: Text(language.ok),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<List<SelectedCommunication>> _onCommunicationChannels(
    BuildContext context,
    List<SelectedCommunication> selectedCommunicationPreferences,
    List<MessageMethod> communicationMethods,
  ) async {
    final result = await Navigator.pushNamed(
      context,
      RouteConstants.communicationPrefencesListPage,
      arguments: CommunicationPrefencesListPageArguments(
        communicationMethods,
        selectedCommunicationPreferences,
        [],
      ),
    ) as List<SelectedCommunication>;
    return result;
  }
}
