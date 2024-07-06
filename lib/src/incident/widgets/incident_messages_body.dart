import 'package:crises_control/src/core/presentation/widgets/cc_activity_indicator.dart';
import 'package:crises_control/src/incident/cubits/incident_messages/incident_messages_cubit.dart';
import 'package:crises_control/src/incident/models/all_active_incident.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'widgets.dart';

class IncidentMessageBody extends StatelessWidget {
  final AllActiveIncidentData incident;
  IncidentMessageBody({super.key, required this.incident});
  final CCLoadingOverlay _loadingOverlay = CCLoadingOverlay();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<IncidentMessagesCubit, IncidentMessagesState>(
      listener: (context, state) {
        handleStateChanges(state, context);
      },
      builder: (context, state) {
        if (state is IncidentMessagesLoaded) {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: IncidentCell(
                  incident: incident,
                  showChervon: false,
                ),
              ),
              Divider(
                color: Colors.grey.shade700,
              ),
              Expanded(
                child: ListView.separated(
                  itemCount: state.incidentMessages.length,
                  itemBuilder: (context, index) => IncidentMessageListTile(
                    incidentMessage: state.incidentMessages[index],
                  ),
                  separatorBuilder: (context, index) => Divider(
                    color: Colors.grey.shade700,
                  ),
                ),
              ),
            ],
          );
        }
        return Container();
      },
    );
  }

  void handleStateChanges(IncidentMessagesState state, BuildContext context) {
    if (state is IncidentMessagesLoading) {
      _loadingOverlay.show(context);
    } else {
      _loadingOverlay.hide();
    }
    if (state is IncidentMessagesFailure) {
      showDialog(
        context: context,
        builder: (context) => state.error.displayErrorAlerts(context),
      );
    }
  }
}
