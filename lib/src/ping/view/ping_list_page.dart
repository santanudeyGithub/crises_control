import 'dart:developer';
import 'package:crises_control/src/CustomAppbar.dart';
import 'package:crises_control/src/core/router/page_arguments/page_arguments.dart';
import 'package:crises_control/src/core/router/route_constants.dart';
import 'package:crises_control/src/ping/widgets/ping_list_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

///Ping list page responsible for displaying all of the users pings.
class PingListPage extends StatelessWidget {
  /// {@macro ping_page}
  const PingListPage({super.key});

  /// The static route for PingPage
  static Route<dynamic> route() {
    return MaterialPageRoute<dynamic>(builder: (_) => const PingListPage());
  }

  @override
  Widget build(BuildContext context) {
    var language = AppLocalizations.of(context);
    return Scaffold(
      // appBar: AppBar(
      //   title: Text(AppLocalizations.of(context)!.label_ping_message),
      // ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          log('New ping pressed');
          Navigator.pushNamed(
            context,
            RouteConstants.newPingPage,
            arguments: NewPingPageArguments(selectedUsers: []),
          );
        },
      ),
      //body: PingListBody(),
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: CustomHeader(
              title: language!.title_ping_message,
            ),
          ),
          Positioned(
            top: 150, // Adjust to control the overlap
            left: 16,
            right: 16,
            bottom: 0,
            child: PingListBody(),
          ),
        ],
      ),
    );
  }
}
