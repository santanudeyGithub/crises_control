import 'package:crises_control/src/home/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

enum HomeItemType { incidents, pingMessages, emergency, tasks }

class HomeItemHelper {
  // static IconData getIconData(HomeItemType item) {
  static Widget getIconData(HomeItemType item) {
    switch (item) {
      case HomeItemType.incidents:
        //return Icons.report_problem_outlined;
        return Image.asset('assets/images/Dashboard_Incedent.png');
      case HomeItemType.pingMessages:
        // return Icons.wifi;
        return Image.asset('assets/images/Dashboard_Message.png');
      case HomeItemType.emergency:
        // return Icons.sos_sharp;
        return Image.asset('assets/images/Dashboard_SOS.png');
      case HomeItemType.tasks:
        // return Icons.checklist_rtl_outlined;
        return Image.asset('assets/images/Dashboard_task.png');
      // case HomeItemType.chat:
      //   return Icons.forum;
      // case HomeItemType.analytics:
      //   return Icons.query_stats;
      default:
        return Container();
    }
  }

  static List<HomeIcon> homeIconsPlaceHolder = [
    const HomeIcon(
      badgeNumber: 0,
      homeItem: HomeItemType.incidents,
      isEnabled: true,
    ),
    const HomeIcon(
      badgeNumber: 0,
      homeItem: HomeItemType.pingMessages,
      isEnabled: true,
    ),
    const HomeIcon(
      badgeNumber: 0,
      homeItem: HomeItemType.emergency,
      isEnabled: true,
    ),
    const HomeIcon(
      badgeNumber: 0,
      homeItem: HomeItemType.tasks,
      isEnabled: true,
    ),
    // const HomeIcon(
    //   badgeNumber: 0,
    //   homeItem: HomeItemType.analytics,
    //   isEnabled: true,
    // ),
    // const HomeIcon(
    //   badgeNumber: 0,
    //   homeItem: HomeItemType.chat,
    //   isEnabled: true,
    // ),
  ];

  static String getDescriptionText(HomeItemType item) {
    switch (item) {
      case HomeItemType.incidents:
        return '2 Active Incidents';
      case HomeItemType.pingMessages:
        return '3 Unacknowledged Pings';
      case HomeItemType.emergency:
        return '';
      case HomeItemType.tasks:
        return '2 Uncompleted Tasks';
      // case HomeItemType.chat:
      //   return '3 New Chats';
      // case HomeItemType.analytics:
      //   return '';
    }
  }

  static String getText(HomeItemType item, BuildContext context) {
    switch (item) {
      case HomeItemType.incidents:
        return AppLocalizations.of(context)!.label_incidents;
      case HomeItemType.pingMessages:
        return AppLocalizations.of(context)!.label_ping_message;
      case HomeItemType.emergency:
        return AppLocalizations.of(context)!.label_sos;
      case HomeItemType.tasks:
        return AppLocalizations.of(context)!.label_tasks;
      // case HomeItemType.chat:
      //   return 'Chat';
      // case HomeItemType.analytics:
      //   return 'Analytics';
    }
  }
}
