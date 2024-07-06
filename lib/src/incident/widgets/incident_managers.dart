import 'dart:ui';

import 'package:crises_control/src/CustomAppbar.dart';
import 'package:crises_control/src/incident/view/asset_website.dart';
import 'package:crises_control/src/incident/view/audio.dart';
import 'package:crises_control/src/incident/view/close.dart';
import 'package:crises_control/src/incident/view/documents.dart';
import 'package:crises_control/src/incident/view/event_log.dart';
import 'package:crises_control/src/incident/view/incident_messages_page.dart';
import 'package:crises_control/src/incident/view/incident_update.dart';
import 'package:crises_control/src/incident/view/videos.dart';
import 'package:crises_control/src/incident/widgets/widgets.dart';
import 'package:crises_control/src/login/view/widgets/custom_image_view.dart';
import 'package:crises_control/src/login/view/widgets/image_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class IncidentManagerPage extends StatefulWidget {
  const IncidentManagerPage({super.key});

  @override
  State<IncidentManagerPage> createState() => _IncidentManagerPageState();
}

class _IncidentManagerPageState extends State<IncidentManagerPage> {
  bool _isChecked = false;
  final List<String> items =
      List<String>.generate(20, (index) => "Item $index");

  final String recipient = 'recipient@example.com';
  final String cc = 'cc@example.com';

  void _sendEmail(String subject, String body) async {
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: recipient,
      queryParameters: {
        'cc': cc,
        'subject': subject,
        'body': body,
      },
    );

    // ignore: deprecated_member_use
    if (await canLaunch(emailLaunchUri.toString())) {
      // ignore: deprecated_member_use
      await launch(emailLaunchUri.toString());
    } else {
      throw 'Could not launch $emailLaunchUri';
    }
  }

  void _showComposeEmail(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return ComposeEmailForm(sendEmail: _sendEmail);
      },
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
              title: language!.label_key_contacts,
              // actionIcon: GestureDetector(
              //   onTap: () async {
              //     showCustomDialog(context, 3);
              //   },
              //   child: Icon(
              //     Icons.menu,
              //     color: Colors.white,
              //     size: 35,
              //   ),
              // ),
            ),
          ),
          Positioned(
            top: 145, // Adjust to control the overlap
            left: 16,
            right: 16,
            bottom: 50,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(
                        top: 35,
                        left: 15,
                        right: 15), // Adjust this to position the box
                    padding: EdgeInsets.all(16.0),
                    width: 350,
                    height: 150,
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
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(height: 16), // Space for the circle
                        Text(
                          'Lottie Morrison',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.urbanist(fontSize: 22),
                        ),

                        Padding(
                          padding: const EdgeInsets.only(left: 5, top: 5),
                          child: Container(
                            child: Text(
                              "12 Mar  3:03 PM",
                              style: TextStyle(),
                            ),
                          ),
                        ),
                        Container(
                          child: Opacity(
                            opacity: 0.6,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Opacity(
                    opacity: 0.7,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 184, top: 35),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomCheckbox(
                            value: _isChecked,
                            onChanged: (bool? value) {
                              setState(() {
                                _isChecked = value!;
                              });
                            },
                          ),
                          SizedBox(width: 10),
                          Text(
                            'Select All Alert',
                            style: GoogleFonts.urbanist(
                                color: Color(0xff0B223C),
                                fontSize: 18,
                                fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 25),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                            GestureDetector(
                              //before onTap Method
                              // onTap: () =>
                              // _onTileSelected(MediaAttachmentType.website, context),

                              /////////////////////

                              //New implement onTap method just route the page normal
                              onTap: () async {
                                showCustomDialog(context, 3);
                              },
                              child: Container(
                                width: 150,
                                height: 165,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(15),
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.black.withOpacity(0.3),
                                          blurRadius: 15,
                                          spreadRadius: 5),
                                    ]),
                                child: Padding(
                                  padding: const EdgeInsets.all(18.0),
                                  child: Column(
                                    children: [
                                      Image(
                                        image: AssetImage(
                                            'assets/images/mobile.png'),
                                        height: 100,
                                        width: 100,
                                      ),
                                      const SizedBox(
                                        height: 2,
                                        width: 5,
                                      ),
                                      Text(
                                        "Mobile",
                                        style: GoogleFonts.urbanist(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                            color: const Color(0xff0B223C)),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            GestureDetector(
                              //before onTap Method
                              // onTap: () => _onTileSelected(
                              // MediaAttachmentType.document, context),

                              /////////////////////

                              //New implement onTap method just route the page normal
                              onTap: () {
                                showCustomDialog(context, 3);
                              },
                              child: Container(
                                width: 150,
                                height: 165,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(15),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.black.withOpacity(0.3),
                                        blurRadius: 15,
                                        spreadRadius: 5),
                                  ],
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(18.0),
                                  child: Column(
                                    children: [
                                      Image(
                                        image: AssetImage(
                                            'assets/images/call_alert.png'),
                                        height: 100,
                                        width: 100,
                                      ),

                                      const SizedBox(
                                        height: 2,
                                        width: 5,
                                      ),
                                      Text(
                                        "Call Alert",
                                        style: GoogleFonts.urbanist(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                            color: const Color(0xff0B223C)),
                                      ),
                                      // Padding(
                                      //padding: const EdgeInsets.only(bottom: 10),
                                      // child: Text("View"),
                                      //),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(),
                    child: Positioned(
                      // top: 300,
                      child: Container(
                        padding: const EdgeInsets.only(top: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(
                              children: [
                                GestureDetector(
                                  //before onTap Method
                                  //onTap: () =>
                                  //_onTileSelected(MediaAttachmentType.video, context),
                                  /////////////////////

                                  //New implement onTap method just route the page normal
                                  // onTap: () {
                                  //   // Navigator.push(
                                  //   //   context,
                                  //   //   MaterialPageRoute(
                                  //   //       builder: (context) => Videos()),
                                  //   // );

                                  // },

                                  onTap: () => _showComposeEmail(context),

                                  child: Container(
                                    width: 150,
                                    height: 165,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(15),
                                        boxShadow: [
                                          BoxShadow(
                                              color:
                                                  Colors.black.withOpacity(0.3),
                                              blurRadius: 15,
                                              spreadRadius: 5),
                                        ]),
                                    child: Padding(
                                      padding: const EdgeInsets.all(18.0),
                                      child: Column(
                                        children: [
                                          Image(
                                            image: AssetImage(
                                                'assets/images/email.png'),
                                            height: 90,
                                            width: 90,
                                          ),
                                          const SizedBox(
                                            height: 2,
                                            width: 5,
                                          ),
                                          Text(
                                            "Email Alert",
                                            style: GoogleFonts.urbanist(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600,
                                                color: const Color(0xff0B223C)),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                GestureDetector(
                                  // onTap: () =>
                                  // _onTileSelected(MediaAttachmentType.audio, context),

                                  onTap: () {
                                    // Navigator.push(
                                    //   context,
                                    //   MaterialPageRoute(
                                    //       builder: (context) => Audio()),
                                    // );
                                  },
                                  child: Container(
                                    width: 150,
                                    height: 165,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(15),
                                      boxShadow: [
                                        BoxShadow(
                                            color:
                                                Colors.black.withOpacity(0.3),
                                            blurRadius: 15,
                                            spreadRadius: 5),
                                      ],
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(18.0),
                                      child: Column(
                                        children: [
                                          Image(
                                            image: AssetImage(
                                                'assets/images/location_border.png'),
                                            height: 100,
                                            width: 100,
                                          ),

                                          const SizedBox(
                                            height: 2,
                                            width: 5,
                                          ),
                                          Text(
                                            "Location",
                                            style: GoogleFonts.urbanist(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600,
                                                color: const Color(0xff0B223C)),
                                          ),
                                          // Padding(
                                          //padding: const EdgeInsets.only(bottom: 10),
                                          // child: Text("View"),
                                          //),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
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
                  image: AssetImage('assets/images/img_oval.png'),
                ),
              ),
            ),
          ),
        ],
      ),
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
              height: MediaQuery.of(context).size.height * 0.2,
              padding: EdgeInsets.all(20.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(height: 10),
                  GestureDetector(
                    onTap: () {
                      // Navigator.push(
                      // context,
                      // MaterialPageRoute(
                      //    builder: (context) => UpdateIncident()),
                      // );
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Image(
                          image: AssetImage(
                              'assets/images/Crises_Control_Call.png'),
                          height: 55,
                          width: 55,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 55),
                          child: Text(
                            'Crises Control Call',
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
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(builder: (context) => ClosePage()),
                      // );
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Image(
                          image: AssetImage('assets/images/mobile.png'),
                          height: 60,
                          width: 60,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 115),
                          child: Text(
                            'Mobile Call',
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

class CustomCheckbox extends StatelessWidget {
  final bool value;
  final ValueChanged<bool?> onChanged;

  const CustomCheckbox({
    Key? key,
    required this.value,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onChanged(!value);
      },
      child: Container(
        width: 25.0,
        height: 25.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6.0),
          border: Border.all(
            color: value ? Colors.blue : Colors.grey,
            width: 2.0,
          ),
          color: value ? Colors.blue : Colors.transparent,
        ),
        child: value
            ? Icon(
                Icons.check,
                size: 20.0,
                color: Colors.white,
              )
            : null,
      ),
    );
  }
}

class ComposeEmailForm extends StatefulWidget {
  final void Function(String, String) sendEmail;

  const ComposeEmailForm({Key? key, required this.sendEmail}) : super(key: key);

  @override
  _ComposeEmailFormState createState() => _ComposeEmailFormState();
}

class _ComposeEmailFormState extends State<ComposeEmailForm> {
  final TextEditingController _toController = TextEditingController();
  final TextEditingController _ccController = TextEditingController();
  final TextEditingController _subjectController = TextEditingController();
  final TextEditingController _bodyController = TextEditingController();

  @override
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFormField(
            controller: _toController,
            decoration: InputDecoration(
                labelText: 'To:', hintText: 'gerhard.marwe@transputec.com'),
          ),
          SizedBox(height: 12),
          TextFormField(
            controller: _ccController,
            decoration: InputDecoration(labelText: 'CC'),
          ),
          SizedBox(height: 12),
          TextFormField(
            controller: _subjectController,
            decoration: InputDecoration(labelText: 'Subject'),
          ),
          SizedBox(height: 12),
          TextFormField(
            controller: _bodyController,
            decoration: InputDecoration(labelText: 'Body'),
            maxLines: null,
          ),
          SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              widget.sendEmail(
                _subjectController.text,
                _bodyController.text,
              );
              Navigator.pop(context);
            },
            child: Text('Sent from'),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _toController.dispose();
    _ccController.dispose();
    _subjectController.dispose();
    _bodyController.dispose();
    super.dispose();
  }
}
