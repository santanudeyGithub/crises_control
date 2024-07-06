import 'package:crises_control/src/core/presentation/pages/empty_state.dart';
import 'package:crises_control/src/core/presentation/widgets/cc_activity_indicator.dart';
import 'package:crises_control/src/core/router/page_arguments/page_arguments.dart';
import 'package:crises_control/src/core/router/route_constants.dart';
import 'package:crises_control/src/incident/cubits/launched_incidents/launched_incidents_cubit.dart';
import 'package:crises_control/src/incident/incident.dart';
import 'package:crises_control/src/incident/models/incident.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class IncidentsView extends StatelessWidget {
  IncidentsView({super.key, required this.isAwaitingLaunch});
  final bool isAwaitingLaunch;
  final _loadingOverlay = CCLoadingOverlay();

  @override
  Widget build(BuildContext context) {
    var language = AppLocalizations.of(context);
    var emptyStateMessage = isAwaitingLaunch
        ? language!.title_empty_awaiting_launch_incident
        : language!.title_empty_launched_incident;
    return BlocConsumer<LaunchedIncidentsCubit, LaunchedIncidentsState>(
      listener: (context, state) {
        if (state.error != null) {
          state.error?.displayErrorAlerts(context);
        }
        if (state.isLoading) {
          _loadingOverlay.show(context);
        } else {
          _loadingOverlay.hide();
        }
      },
      builder: (context, state) {
        if (state.activeIncidents != null &&
            state.activeIncidents!.data.data.isNotEmpty) {
          return ListView.builder(
            itemBuilder: ((context, index) {
              var incident = state.activeIncidents!.data.data[index];
              return Padding(
                  padding: const EdgeInsets.only(
                      left: 8.0, right: 8.0, top: 40, bottom: 8.0),
                  child: Container(
                    width: 150,
                    height: 140,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                          color: const Color.fromARGB(255, 237, 236, 236),
                          width: 3),
                      borderRadius: BorderRadius.circular(18),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 0,
                          blurRadius: 7,
                          offset: Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: TextButton(
                      child: IncidentCell(
                        incident: incident,
                        showChervon: true,
                      ),
                      onPressed: () {
                        if (isAwaitingLaunch) {
                          Navigator.pushNamed(
                            context,
                            RouteConstants.launchIncidentPage,
                            // arguments: LaunchIncidentPageArguments(incident),
                          );
                        } else {
                          Navigator.pushNamed(
                            context,
                            RouteConstants.incidentMessagesPage,
                            arguments: IncidentMessagesPageArguments(incident),
                          );
                        }
                      },
                    ),
                  ));
            }),
            //separatorBuilder: ((context, index) => const Divider()),
            itemCount: Incident.mockIncidents.length,
          );
        }
        if (!state.isLoading) {
          return EmptyState(text: emptyStateMessage, icon: null);
        }
        return Container();
      },
    );
  }
}
