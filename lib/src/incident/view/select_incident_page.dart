import 'package:crises_control/src/incident/widgets/select_incident_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:crises_control/src/CustomAppbar.dart';

class SelectIncidentPage extends StatefulWidget {
  const SelectIncidentPage({super.key});

  static Route<dynamic> route() {
    return MaterialPageRoute<dynamic>(
      builder: (_) => const SelectIncidentPage(),
    );
  }

  @override
  State<SelectIncidentPage> createState() => _SelectIncidentPageState();
}

class _SelectIncidentPageState extends State<SelectIncidentPage> {
  bool isSearching = false;

  String searchQuery = "";

  @override
  Widget build(BuildContext context) {
    var language = AppLocalizations.of(context);
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: CustomHeader(title: language!.title_select_incident),
          ),
          Positioned(
            top: 75, // Adjust to control the overlap
            left: 16,
            right: 16,
            bottom: 0,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 75, bottom: 0),
                  child: CircularSearchBox(
                    onSearchChanged: (query) {
                      setState(() {
                        searchQuery = query;
                      });
                    },
                  ),
                ),
                Expanded(
                  child: const SelectIncidentBody(),
                ),
              ],
            ),
          ),
          // Positioned(
          //   top: 38,
          //   right: 16,
          //   child: IconButton(
          //     onPressed: () {
          //       setState(() {
          //         isSearching = !isSearching;
          //       });
          //     },
          //     icon: isSearching
          //         ? const Icon(Icons.search_off)
          //         : const Image(
          //             image: AssetImage('assets/images/searchicon.png'),
          //             height: 70,
          //             width: 70,
          //           ),
          //   ),
          // ),
        ],
      ),
    );
  }
}

class CircularSearchBox extends StatelessWidget {
  final ValueChanged<String> onSearchChanged;

  CircularSearchBox({required this.onSearchChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30.0),
        border: Border.all(color: Colors.grey),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 5.0,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Search...',
          border: InputBorder.none,
          icon: Icon(Icons.search),
        ),
        onChanged: onSearchChanged,
      ),
    );
  }
}
