import 'package:crises_control/src/CustomAppbar.dart';
import 'package:crises_control/src/core/errors/cc_error.dart';
import 'package:crises_control/src/core/presentation/widgets/cc_activity_indicator.dart';
import 'package:crises_control/src/incident/cubits/launch_incident/launch_incident_cubit.dart';
import 'package:crises_control/src/incident/widgets/launch_incident_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LaunchIncidentPage extends StatefulWidget {
  const LaunchIncidentPage({super.key, required this.incidentId});
  final int incidentId;

  @override
  State<LaunchIncidentPage> createState() => _LaunchIncidentPageState();
}

class _LaunchIncidentPageState extends State<LaunchIncidentPage> {
  final CCLoadingOverlay _ccLoadingOverlay = CCLoadingOverlay();

  @override
  void initState() {
    super.initState();
    context
        .read<LaunchIncidentCubit>()
        .getIncidentDetails(incidentId: widget.incidentId);
  }

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    final language = AppLocalizations.of(context);
    return Scaffold(
      body: Stack(
        children: [
          const Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: CustomHeader(
              title:
                  'Launch Incident', // Use appropriate title for LaunchIncidentPage if different
            ),
          ),
          Positioned(
            top: 150, // Adjust to control the overlap
            left: 16,
            right: 16,
            bottom: 0,
            child: BlocConsumer<LaunchIncidentCubit, LaunchIncidentState>(
              listener: (context, state) {
                handleStateChanges(state, context);
              },
              builder: (context, state) {
                if (state is LaunchIncidentDetailsLoaded) {
                  return LaunchIncidentBody(
                      incidentId: widget.incidentId,
                      launchIncidentDetailsLoaded: state);
                }
                return Container();
              },
            ),
          ),
        ],
      ),
    );
  }

  void handleStateChanges(LaunchIncidentState state, BuildContext context) {
    if (state is LaunchIncidentDetailsLoading) {
      _ccLoadingOverlay.show(context);
    } else {
      _ccLoadingOverlay.hide();
    }
    if (state is LaunchIncidentDetailsError) {
      showDialog(
        context: context,
        builder: (context) => CCError.displayErrorAlert(state.error, context),
      );
    }
  }
}
