// ignore_for_file: use_super_parameters

import 'package:crises_control/src/core/presentation/widgets/custom_widgets.dart';
import 'package:crises_control/src/core/presentation/widgets/menu_widgets.dart';
import 'package:crises_control/src/incident/models/incident.dart';
import 'package:crises_control/src/incident/models/incident_message.dart';
import 'package:crises_control/src/incident/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MessageDetailsPage extends StatelessWidget {
  const MessageDetailsPage({
    super.key,
    required this.incident,
    required this.incidentMessage,
  });
  final Incident incident;
  final IncidentMessage incidentMessage;

  @override
  Widget build(BuildContext context) {
    var language = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(language!.title_launched_incident_message_details),
        actions: [
          IconButton(
            onPressed: (() {
              showModalBottomSheet(
                context: context,
                builder: (context) {
                  return const MessageBottomMenu();
                },
              );
            }),
            icon: const Icon(Icons.more_horiz),
          )
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingAcknowledgedButton(
        onPressed: () {},
      ),
      body: MessageDetailsView(
        incident: incident,
        incidentMessage: incidentMessage,
      ),
      bottomNavigationBar: IncidentActionTabBar(language: language),
    );
  }
}

class MessageDetailsView extends StatelessWidget {
  const MessageDetailsView({
    super.key,
    required this.incident,
    required this.incidentMessage,
  });
  final Incident incident;
  final IncidentMessage incidentMessage;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Padding(
        //   padding: const EdgeInsets.all(8.0),
        //   child: IncidentCell(
        //     incident: incident,
        //     showChervon: false,
        //   ),
        // ),
        Divider(
          color: Colors.grey.shade700,
        ),
        _Message(incidentMessage: incidentMessage),
      ],
    );
  }
}

class _Message extends StatelessWidget {
  const _Message({
    Key? key,
    required this.incidentMessage,
  }) : super(key: key);

  final IncidentMessage incidentMessage;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SenderInfo(
              date: incidentMessage.date, senderName: incidentMessage.sender),
          const SizedBox(height: 20),
          Text(
            incidentMessage.message,
            style: Theme.of(context).textTheme.bodyMedium?.apply(
                  color: incidentMessage.isAcknowledged
                      ? Colors.black
                      : Colors.red,
                ),
            maxLines: 4,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
