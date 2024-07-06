// // ignore_for_file: public_member_api_docs, sort_constructors_first, use_super_parameters
// import 'package:crises_control/src/core/presentation/styles/text/material_colors_helper.dart';
// import 'package:crises_control/src/incident/models/all_active_incident.dart';
// import 'package:crises_control/src/incident/widgets/incident_messages_body.dart';
// import 'package:crises_control/src/incident/widgets/widgets.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';

// class IncidentsMessagePage extends StatefulWidget {
//   const IncidentsMessagePage({
//     Key? key,
//     required this.incident,
//   }) : super(key: key);
//   final AllActiveIncidentData incident;

//   @override
//   State<IncidentsMessagePage> createState() => _IncidentsMessagePageState();
// }

// class _IncidentsMessagePageState extends State<IncidentsMessagePage> {
//   Route<dynamic> route() {
//     return MaterialPageRoute<dynamic>(
//       builder: (_) => IncidentsMessagePage(
//         incident: widget.incident,
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     var language = AppLocalizations.of(context);
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(language!.title_incident_messages),
//         actions: [_IncidentActions(language: language)],
//       ),
//       bottomNavigationBar: IncidentActionTabBar(language: language),
//       body: IncidentMessageBody(incident: widget.incident),
//     );
//   }
// }

// class _IncidentActions extends StatelessWidget {
//   const _IncidentActions({
//     Key? key,
//     required this.language,
//   }) : super(key: key);

//   final AppLocalizations language;

//   @override
//   Widget build(BuildContext context) {
//     return PopupMenuButton(
//       icon: const Icon(Icons.more_vert),
//       itemBuilder: (BuildContext context) => <PopupMenuEntry>[
//         PopupMenuItem(
//           child: ListTile(
//             leading: const Icon(
//               Icons.wifi,
//               color: Palette.primary,
//             ),
//             title: Text(language.title_incident_update),
//           ),
//         ),
//         PopupMenuItem(
//           child: ListTile(
//             leading: const Icon(
//               Icons.cancel,
//               color: Palette.primary,
//             ),
//             title: Text(language.lim_option_close),
//           ),
//         ),
//       ],
//     );
//   }
// }

//New code

// ignore_for_file: public_member_api_docs, sort_constructors_first, use_super_parameters
import 'dart:ui';

import 'package:crises_control/src/CustomAppbar.dart';
import 'package:crises_control/src/core/presentation/styles/text/material_colors_helper.dart';
import 'package:crises_control/src/core/router/page_arguments/page_arguments.dart';
import 'package:crises_control/src/core/router/route_constants.dart';
import 'package:crises_control/src/incident/models/all_active_incident.dart';
import 'package:crises_control/src/incident/models/incident_list_model.dart';
import 'package:crises_control/src/incident/view/close.dart';
import 'package:crises_control/src/incident/view/event_log.dart';
import 'package:crises_control/src/incident/view/incident_update.dart';
import 'package:crises_control/src/incident/widgets/incident_messages_body.dart';
import 'package:crises_control/src/incident/widgets/widgets.dart';
import 'package:crises_control/src/login/view/widgets/custom_image_view.dart';
import 'package:crises_control/src/login/view/widgets/image_constant.dart';
import 'package:crises_control/src/theme/custom_text_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:path/path.dart';

class IncidentsMessagePage extends StatefulWidget {
  const IncidentsMessagePage({
    Key? key,
    required this.incident,
  }) : super(key: key);
  final AllActiveIncidentData incident;

  @override
  State<IncidentsMessagePage> createState() => _IncidentsMessagePageState();
}

class _IncidentsMessagePageState extends State<IncidentsMessagePage> {
  Route<dynamic> route() {
    return MaterialPageRoute<dynamic>(
      builder: (_) => IncidentsMessagePage(
        incident: widget.incident,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var language = AppLocalizations.of(context);
    return Scaffold(
      // appBar: AppBar(
      //   title: Text(language!.title_incident_messages),
      //   actions: [_IncidentActions(language: language)],
      // ),
      // bottomNavigationBar: IncidentActionTabBar(language: language),
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: CustomHeader(
              title: language!.title_incident_messages,
              actionIcon: GestureDetector(
                onTap: () async {
                  showCustomDialog(context, 3);
                },
                child: Icon(
                  Icons.menu,
                  color: Colors.white,
                  size: 35,
                ),
              ),
            ),
          ),
          Positioned(
            top: 135, // Adjust to control the overlap
            left: 16,
            right: 16,
            bottom: 50,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    height: 245,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 30),
                      child: Container(
                        margin: EdgeInsets.only(
                            top: 5,
                            left: 15,
                            right: 15), // Adjust this to position the box
                        padding: EdgeInsets.all(16.0),
                        width: 350,
                        height: 225,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 2,
                              blurRadius: 7,
                              offset:
                                  Offset(0, 3), // changes position of shadow
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(height: 20), // Space for the circle
                            Text(
                              'Pandemic Incident',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.urbanist(
                                fontSize: 22,
                                color: Color(0xff0B223C),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: 6),
                            Container(
                              height: 110,
                              width: 300,
                              child: Column(
                                children: [
                                  Center(
                                    child: Row(
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 40),
                                          child: Container(
                                            child: Image(
                                              image: AssetImage(
                                                  'assets/images/location.png'),
                                              height: 45,
                                              width: 45,
                                            ),
                                          ),
                                        ),
                                        Opacity(
                                          opacity: 0.5,
                                          child: Text(
                                            'Tunisia, 798 Arufa Key',
                                            style: GoogleFonts.urbanist(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500,
                                                color: Color(0xff0B223C)),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 25),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          width: 28,
                                          height: 5,
                                          decoration: BoxDecoration(
                                            color: const Color(0xff00B60D),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                        ),
                                        Container(
                                          width: 28,
                                          height: 5,
                                          decoration: BoxDecoration(
                                            color: const Color(0xff00B60D),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                        ),
                                        Container(
                                          width: 28,
                                          height: 5,
                                          decoration: BoxDecoration(
                                            color: const Color(0xffFFB500),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                        ),
                                        Container(
                                          width: 28,
                                          height: 5,
                                          decoration: BoxDecoration(
                                            color: const Color(0xffFFB500),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                        ),
                                        Container(
                                          width: 28,
                                          height: 5,
                                          decoration: BoxDecoration(
                                            color: const Color(0xffD71D53),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      child: Text('12 Mar  3:03 PM'),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 15),
                  Container(
                    width: 350,
                    height: 165,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 7,
                          offset: Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 18, top: 12),
                              child: CustomImageView(
                                imagePath: ImageConstant.imgOval,
                                height: 50,
                                width: 50,
                                radius: BorderRadius.circular(25),
                              ),
                            ),
                            SizedBox(
                                width:
                                    5), // Adding space between the icon and text
                            Padding(
                              padding: const EdgeInsets.only(left: 20, top: 10),
                              child: Text(
                                'Dominic Warner',
                                style: GoogleFonts.urbanist(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xff0B223C)),
                              ),
                            ),
                          ],
                        ),
                        Opacity(
                          opacity: 0.5,
                          child: Text(
                            "In publishing and graphic design, Lorem ipsum \nis a placeholder text commonly used to the \nvisual form of a document or a typeface \nwithout relying.",
                            maxLines: 4,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.urbanist(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Color(0xff0B223C)),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 15),
                  Container(
                    width: 350,
                    height: 130,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 7,
                          offset: Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 30, top: 10),
                              child: Text(
                                'Rodney Newton',
                                style: GoogleFonts.urbanist(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xff0B223C)),
                              ),
                            ),
                            SizedBox(
                                width:
                                    5), // Adding space between the icon and text
                            Opacity(
                              opacity: 0.5,
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(left: 55, top: 10),
                                child: Text(
                                  '12 Mar  3:03 PM',
                                  style: GoogleFonts.urbanist(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xff0B223C)),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 4),
                            child: Container(
                              width: 310,
                              height: 82,
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(
                                    255, 250, 253, 255), // Background color
                                borderRadius: BorderRadius.circular(
                                    35), // Rounded corners
                                border: Border.all(
                                  color: Color.fromARGB(
                                      255, 16, 141, 250), // Border color
                                  width: 1.0, // Border width
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color:
                                        const Color.fromARGB(255, 228, 225, 225)
                                            .withOpacity(0.5),
                                    spreadRadius: 5,
                                    blurRadius: 7,
                                    offset: Offset(0, 3), // Shadow position
                                  ),
                                ],
                              ),
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 25),
                                    child: Container(
                                      child: Icon(
                                        Icons.play_arrow,
                                        color:
                                            Color.fromARGB(255, 16, 141, 250),
                                        size: 50,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    child: Image(
                                        image: AssetImage(
                                            'assets/images/rcordline.png'),
                                        width: 135),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 25),
                                    child: Container(
                                      child: Text(
                                        '0:30',
                                        style: GoogleFonts.urbanist(
                                            fontSize: 10,
                                            fontWeight: FontWeight.w400,
                                            color: Color(0xff16A1ED)),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 18),
                  ElevatedButton(
                    onPressed: () {
                      // Navigator.pop(context, _selectedDepartments);
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: const Color(0xff1E60AA), // Text color
                      elevation: 5, // Elevation
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(8), // Button border radius
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 120, vertical: 18),
                    ),
                    child: Text(
                      'Acknowledge'.toUpperCase(),
                      style: GoogleFonts.urbanist(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 145,
            left: 168,
            child: Container(
              width: 70, // Adjust size
              height: 70, // Adjust size
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Color.fromARGB(255, 255, 255, 255), // Border color
                  width: 4.0, // Border width
                ),
              ),
              child: CircleAvatar(
                  radius: 55, // Half the width/height minus the border width
                  backgroundColor: Color.fromARGB(255, 255, 255, 255),
                  child: Image(
                      image: AssetImage(
                          'assets/images/img_settings_primary.png'))),
            ),
          ),
        ],
      ),
      bottomNavigationBar: IncidentActionTabBar(language: language),
    );
  }
}

void showCustomDialog(BuildContext context, int times) {
  if (times > 0) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
          child: Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25.0),
            ),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white, // Set the background color to white
                borderRadius: BorderRadius.circular(25.0),
              ),
              width: MediaQuery.of(context).size.width * 0.8,
              height: MediaQuery.of(context).size.height * 0.3,
              padding: EdgeInsets.all(20.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(height: 25),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => UpdateIncident()),
                      );
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Image(
                          image:
                              AssetImage('assets/images/incident_update.png'),
                          height: 55,
                          width: 55,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 85),
                          child: Text(
                            'Incident Update',
                            style: GoogleFonts.urbanist(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Color(0xff1E60AA)),
                          ),
                        ),
                        Icon(Icons.keyboard_arrow_right,
                            size: 28, color: Color(0xff0B223C)),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ClosePage()),
                      );
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Image(
                          image: AssetImage('assets/images/close.png'),
                          height: 60,
                          width: 60,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 143),
                          child: Text(
                            'Close',
                            style: GoogleFonts.urbanist(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Color(0xff0B223C)),
                          ),
                        ),
                        Icon(Icons.keyboard_arrow_right,
                            size: 28, color: Color(0xff0B223C)),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => EventLog()),
                      );
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Image(
                          image: AssetImage('assets/images/event_log.png'),
                          height: 60,
                          width: 60,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 120),
                          child: Text(
                            'Event Log',
                            style: GoogleFonts.urbanist(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Color(0xff0B223C)),
                          ),
                        ),
                        Icon(Icons.keyboard_arrow_right,
                            size: 28, color: Color(0xff0B223C)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _IncidentActions extends StatelessWidget {
  const _IncidentActions({
    Key? key,
    required this.language,
  }) : super(key: key);

  final AppLocalizations language;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      icon: const Icon(Icons.more_vert),
      itemBuilder: (BuildContext context) => <PopupMenuEntry>[
        PopupMenuItem(
          child: ListTile(
            leading: const Icon(
              Icons.wifi,
              color: Palette.primary,
            ),
            title: Text(language.title_incident_update),
          ),
        ),
        PopupMenuItem(
          child: ListTile(
            leading: const Icon(
              Icons.cancel,
              color: Palette.primary,
            ),
            title: Text(language.lim_option_close),
          ),
        ),
      ],
    );
  }
}
