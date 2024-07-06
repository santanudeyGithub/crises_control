import 'package:crises_control/src/CustomAppbar.dart';
import 'package:crises_control/src/core/router/route_constants.dart';
import 'package:flutter/material.dart';
import 'package:crises_control/src/incident/widgets/incidents_body.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/svg.dart';

/// {@template incident_page}
/// A description for IncidentPage
/// {@endtemplate}
class IncidentsPage extends StatelessWidget {
  /// {@macro incident_page}
  const IncidentsPage({super.key, this.isAwaitingIncidents = true});
  final bool isAwaitingIncidents;

  /// The static route for IncidentPage
  Route<dynamic> route() {
    return MaterialPageRoute<dynamic>(
      builder: (_) => IncidentsPage(
        isAwaitingIncidents: isAwaitingIncidents,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var language = AppLocalizations.of(context);
    return Scaffold(
      floatingActionButton: isAwaitingIncidents
          ? null
          : Padding(
              padding: const EdgeInsets.only(top: 0, bottom: 767, right: 15),
              child: InkWell(
                onTap: () => Navigator.pushNamed(
                    context, RouteConstants.selectIncidentPage),
                child: Container(
                  width: 30, // Set width of the container
                  height: 30, // Set height of the container
                  child: SvgPicture.asset(
                    'assets/images/img_plus.svg',
                    height: 25,
                    width: 25,
                  ),
                ),
              ),

              // child: FloatingActionButton.small(
              //  tooltip: language!.menu_start_incident,
              //  onPressed: () => Navigator.pushNamed(
              //  context,
              //   RouteConstants.selectIncidentPage,
              //  ),
              // child: const Icon(
              //  Icons.add,
              //  color: Colors.white,
              //  ),
              //  ),
            ),
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: CustomHeader(
              title: isAwaitingIncidents
                  ? language!.title_awaiting_launch
                  : language!.title_launched_incidents,
            ),
          ),
          Positioned(
            top: 90, // Adjust to control the overlap
            left: 16,
            right: 16,
            bottom: 0,
            child: IncidentsView(isAwaitingLaunch: isAwaitingIncidents),
          ),
        ],
      ),
    );
  }
}
