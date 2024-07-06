import 'package:crises_control/src/core/models/user_info.dart';
import 'package:crises_control/src/core/router/route_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DrawerItem {
  DrawerItem(this.title, this.icon, this.isEnabled, this.type);

  final String title;
  final Icon icon;
  final bool isEnabled;
  final DrawerItemTypes type;

  static List<DrawerItem> generateUsersDrawer(BuildContext context,
      List<SecurityItem> securityItems, bool hasAccounts) {
    var language = AppLocalizations.of(context);

    var newPingSecurityItem = securityItems
        .where((element) => element.securityKey == 'New_Ping')
        .first;

    var awaitingLaunchSecurityItem = securityItems
        .where((element) => element.securityKey == 'AwtLaunch_Incidents')
        .first;

    var incidentSecurityItem = securityItems
        .where((element) => element.securityKey == 'Incidents')
        .first;

    return [
      DrawerItem(
          language!.bb_home, const Icon(Icons.home), true, DrawerItemTypes.home),
      DrawerItem(
        language.menu_start_incident,
        const Icon(Icons.warning_amber_outlined),
        incidentSecurityItem.hasAccessBool,
        DrawerItemTypes.startIncident,
      ),
      DrawerItem(
        language.menu_awaiting_launch,
        const Icon(Icons.rocket_outlined),
        awaitingLaunchSecurityItem.hasAccessBool,
        DrawerItemTypes.awaitingIncident,
      ),
      DrawerItem(
        language.menu_new_ping,
        const Icon(Icons.wifi_outlined),
        newPingSecurityItem.hasAccessBool,
        DrawerItemTypes.newPing,
      ),
      DrawerItem(
        language.menu_settings,
        const Icon(Icons.settings_outlined),
        true,
        DrawerItemTypes.settings,
      ),
      DrawerItem(
        language.menu_help,
        const Icon(Icons.help_outline_outlined),
        true,
        DrawerItemTypes.help,
      ),
      DrawerItem(
        language.switch_companies,
        const Icon(Icons.switch_account_outlined),
        hasAccounts,
        DrawerItemTypes.switchAccounts,
      ),
      DrawerItem(
        language.menu_logout,
        const Icon(Icons.logout_outlined),
        true,
        DrawerItemTypes.logout,
      ),
    ];
  }

  static List<DrawerItem> mockData = [
    DrawerItem(
      'Home',
      const Icon(Icons.home),
      true,
      DrawerItemTypes.home,
    ),
    DrawerItem(
      'Start Incident',
      const Icon(Icons.warning_amber_outlined),
      true,
      DrawerItemTypes.startIncident,
    ),
    DrawerItem(
      'Awaiting Launch',
      const Icon(Icons.rocket_outlined),
      true,
      DrawerItemTypes.awaitingIncident,
    ),
    DrawerItem(
      'New Ping',
      const Icon(Icons.wifi_outlined),
      true,
      DrawerItemTypes.newPing,
    ),
    DrawerItem(
      'Settings',
      const Icon(Icons.settings_outlined),
      true,
      DrawerItemTypes.settings,
    ),
    DrawerItem(
      'Help',
      const Icon(Icons.help_outline_outlined),
      true,
      DrawerItemTypes.help,
    ),
    DrawerItem(
      'Switch Companies',
      const Icon(Icons.switch_account_outlined),
      true,
      DrawerItemTypes.switchAccounts,
    ),
    DrawerItem(
      'Logout',
      const Icon(Icons.logout_outlined),
      true,
      DrawerItemTypes.logout,
    )
  ];

  //Navigation helper.
  static String getRoute(DrawerItemTypes drawerItemType) {
    switch (drawerItemType) {
      case DrawerItemTypes.home:
        return RouteConstants.homePage;
      case DrawerItemTypes.startIncident:
        return RouteConstants.selectIncidentPage;
      case DrawerItemTypes.awaitingIncident:
        return RouteConstants.incidentsPage;
      case DrawerItemTypes.newPing:
        return RouteConstants.newPingPage;
      case DrawerItemTypes.settings:
        return RouteConstants.settingsPage;
      case DrawerItemTypes.help:
        return RouteConstants.helpPage;
      case DrawerItemTypes.logout:
        return '';     
      case DrawerItemTypes.switchAccounts:
        return RouteConstants.companiesPage;
    }
  }
}

enum DrawerItemTypes {
  home,
  startIncident,
  awaitingIncident,
  newPing,
  settings,
  help,
  switchAccounts,
  logout,
}
