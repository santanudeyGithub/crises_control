// ignore_for_file: use_super_parameters

import 'package:badges/badges.dart' as badges;
import 'package:crises_control/src/core/constants.dart';
import 'package:crises_control/src/core/presentation/styles/text/material_colors_helper.dart';
import 'package:crises_control/src/core/presentation/widgets/custom_widgets.dart';
import 'package:crises_control/src/core/router/page_arguments/page_arguments.dart';
import 'package:crises_control/src/core/router/route_constants.dart';
import 'package:crises_control/src/incident/models/active_incident.dart';
import 'package:crises_control/src/incident/models/all_active_incident.dart';
import 'package:crises_control/src/incident/models/incident_menu.dart';
import 'package:crises_control/src/incident/models/incident_message_details.dart';
import 'package:crises_control/src/incident/widgets/impact_location.dart';
import 'package:crises_control/src/incident/widgets/incident_managers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

export 'incidents_body.dart';

class IncidentCell extends StatelessWidget {
  const IncidentCell({
    Key? key,
    required this.incident,
    required this.showChervon,
  }) : super(key: key);

  final AllActiveIncidentData incident;
  final bool showChervon;

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      const SizedBox(width: 10),
      Row(
        children: [
          badges.Badge(
            position: badges.BadgePosition.topEnd(top: -2, end: -3),
            badgeContent: Text(
              1.toString(),
              style: const TextStyle(color: Colors.white),
            ),
            child: Image.asset(
              'assets/images/logo_high_res.png',
              width: 60,
              height: 60,
            ),
          ),
          const SizedBox(
            width: 0,
          ),
          // IncidentSeverityScale(severity: incident.severity),
        ],
      ),
      SizedBox(width: 25),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            incident.name,
            style: Theme.of(context).textTheme.titleSmall,
          ),
          const SizedBox(
            height: 2,
          ),
          Row(
            children: [
              // Icon(
              //   Icons.location_on_outlined,
              //   // color: Colors.green.shade700,
              //   color: Colors.blue,
              //   size: 35,
              // ),
              Image(
                image: AssetImage('assets/images/location_new_icon.png'),
                height: 37,
                width: 37,
              ),
              Text(
                incident.impactedLocation,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
          const SizedBox(
            height: 4,
          ),
          CCDateTime(date: incident.launchedOnToString),
          //New code 26-05-2024 progress bar
          SizedBox(height: 0),
          IncidentSeverityScale(severity: incident.severity),
          // Positioned(
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //     children: [
          //       Container(
          //         width: 25,
          //         height: 5,
          //         decoration: BoxDecoration(
          //           color: const Color(0xff00B60D),
          //           borderRadius: BorderRadius.circular(10),
          //         ),
          //       ),
          //       Container(
          //         width: 25,
          //         height: 5,
          //         decoration: BoxDecoration(
          //           color: const Color(0xff00B60D),
          //           borderRadius: BorderRadius.circular(10),
          //         ),
          //       ),
          //       Container(
          //         width: 25,
          //         height: 5,
          //         decoration: BoxDecoration(
          //           color: const Color(0xffCCCCCC),
          //           borderRadius: BorderRadius.circular(10),
          //         ),
          //       ),
          //       Container(
          //         width: 25,
          //         height: 5,
          //         decoration: BoxDecoration(
          //           color: const Color(0xffCCCCCC),
          //           borderRadius: BorderRadius.circular(10),
          //         ),
          //       ),
          //       Container(
          //         width: 25,
          //         height: 5,
          //         decoration: BoxDecoration(
          //           color: const Color(0xffCCCCCC),
          //           borderRadius: BorderRadius.circular(10),
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
        ],
      ),
      const Spacer(),
      if (showChervon) const Icon(Icons.navigate_next)
    ]);
  }
}

class IncidentSeverityScale extends StatelessWidget {
  const IncidentSeverityScale({
    Key? key,
    required this.severity,
  }) : super(key: key);
  final int severity;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        // Text(
        //   severity.toString(),
        //   style: TextStyle(color: getColorForSeverity(severity)),
        // ),

        Padding(
          padding: const EdgeInsets.only(top: 15),
          child: Positioned(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  width: 25.0,
                  height: 3.0,
                  decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colors.orange.shade100),
                    color:
                        severity >= 5 ? Colors.orange.shade100 : Colors.white,
                    shape: BoxShape.rectangle,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: 25.0,
                    height: 4.0,
                    decoration: BoxDecoration(
                      border:
                          Border.all(width: 1, color: Colors.yellow.shade500),
                      color:
                          severity >= 4 ? Colors.yellow.shade500 : Colors.white,
                      shape: BoxShape.rectangle,
                    ),
                  ),
                ),
                Container(
                  width: 25.0,
                  height: 5.0,
                  decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colors.orange),
                    color: severity >= 3 ? Colors.orange : Colors.white,
                    shape: BoxShape.rectangle,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: 25.0,
                    height: 6.0,
                    decoration: BoxDecoration(
                      border: Border.all(width: 1, color: Colors.red),
                      color: severity >= 2 ? Colors.red : Colors.white,
                      shape: BoxShape.rectangle,
                    ),
                  ),
                ),
                Container(
                  width: 25.0,
                  height: 7.0,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 218, 218, 218),
                    shape: BoxShape.rectangle,
                  ),
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0, top: 1),
                    child: Container(
                      width: 22,
                      height: 22,
                      decoration: BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.red,
                          width: 4,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 10,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Center(
                        child: Text(
                          severity.toString(),
                          style:
                              //TextStyle(color: getColorForSeverity(severity)),
                              TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  static Color getColorForSeverity(int number) {
    switch (number) {
      case 1:
        return Colors.orange.shade100;
      case 2:
        return Colors.orange.shade300;
      case 3:
        return Colors.orange;
      case 4:
        return Colors.red;
      case 5:
        return Colors.red.shade700;
      default:
        return Colors.orange.shade100;
    }
  }
}

class IncidentMessageBottomMenu extends StatelessWidget {
  const IncidentMessageBottomMenu({
    Key? key,
  }) : super(key: key);
  final double _spacing = 10;

  @override
  Widget build(BuildContext context) {
    return ListView(shrinkWrap: true, children: [
      SizedBox(height: _spacing),
      PopupMenuItem(
        value: IncidentMenu.actionPlan,
        child: MenuItemRow(
          icon: Icons.description,
          text: Text(AppLocalizations.of(context)!.title_action_plan),
        ),
      ),
      SizedBox(height: _spacing),
      PopupMenuItem(
        value: IncidentMenu.incidentManagers,
        child: MenuItemRow(
          icon: Icons.supervised_user_circle,
          text: Text(AppLocalizations.of(context)!.label_key_contacts),
        ),
      ),
      SizedBox(height: _spacing),
      PopupMenuItem(
        value: IncidentMenu.impactedLocation,
        child: MenuItemRow(
          icon: Icons.pin_drop,
          text: Text(AppLocalizations.of(context)!.label_impacted_location),
        ),
      ),
      SizedBox(height: _spacing),
      PopupMenuItem(
        value: IncidentMenu.mediaAssets,
        child: MenuItemRow(
          icon: Icons.attach_file,
          text: Text(AppLocalizations.of(context)!.bottom_bar_media_assets),
        ),
      ),
    ]);
  }
}

class IncidentMessageListTile extends StatelessWidget {
  const IncidentMessageListTile({
    Key? key,
    required this.incidentMessage,
    this.isMessageDetails = false,
  }) : super(key: key);
  final MessageDetails incidentMessage;
  final bool isMessageDetails;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () => isMessageDetails
          ? null
          : Navigator.pushNamed(
              context,
              RouteConstants.messageDetailsPage,
            ),
      title: Padding(
        padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
        child: SenderInfo(
            hasAttachment: incidentMessage.hasAttachment,
            date: incidentMessage.launchDate,
            senderName: incidentMessage.fullName),
      ),
      subtitle: Padding(
        padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
        child: Text(
          incidentMessage.messageText,
          style: Theme.of(context).textTheme.bodyMedium?.apply(
                color: Colors.red,
              ),
          maxLines: 4,
          overflow: TextOverflow.ellipsis,
        ),
      ),
      trailing: isMessageDetails
          ? null
          : const Icon(Icons.navigate_next, color: Palette.primary),
    );
  }
}

class IncidentActionTabBar extends StatelessWidget {
  const IncidentActionTabBar({
    Key? key,
    required this.language,
  }) : super(key: key);

  final AppLocalizations language;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      onTap: (index) {
        switch (index) {
          case 0:
            Navigator.pushNamed(
              context,
              RouteConstants.pdfPage,
              arguments: PdfViewerPageArguments(MockData.pdfUrl),
            );
            break;
          case 1:
            // Navigator.pushNamed(context, RouteConstants.messageRecipientsPage);
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => IncidentManagerPage()),
            );
            break;
          case 2:
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ImpactLocation()),
            );
            break;
          case 3:
            Navigator.pushNamed(
              context,
              RouteConstants.incidentMediaAssetsPage,
            );
            break;
          default:
        }
      },
      unselectedItemColor: Palette.primary,
      type: BottomNavigationBarType.fixed,
      unselectedFontSize: 8,
      selectedFontSize: 8,
      iconSize: 24,
      items: [
        BottomNavigationBarItem(
          icon: const Icon(
            Icons.description,
            color: Palette.primary,
          ),
          label: language.title_action_plan,
        ),
        BottomNavigationBarItem(
          icon: const Icon(
            Icons.supervised_user_circle,
            color: Palette.primary,
          ),
          label: language.label_key_contacts,
        ),
        BottomNavigationBarItem(
          icon: const Icon(
            Icons.pin_drop,
            color: Palette.primary,
          ),
          label: language.label_impacted_location,
        ),
        BottomNavigationBarItem(
          icon: const Icon(
            Icons.attach_file,
            color: Palette.primary,
          ),
          label: language.bottom_bar_media_assets,
        ),
      ],
    );
  }
}
