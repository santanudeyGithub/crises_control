import 'dart:ui';

import 'package:crises_control/src/core/models/authentication_credentials.dart';
import 'package:crises_control/src/login/bloc/login_bloc/login_bloc.dart';
import 'package:crises_control/src/login/view/pages/customer_id_page.dart';
import 'package:crises_control/src/login/view/pages/forgot_password.dart';
import 'package:crises_control/src/login/view/pages/launched_incident_three.dart';
import 'package:crises_control/src/login/view/pages/login_page.dart';
import 'package:crises_control/src/theme/palette.dart';
import 'package:crises_control/src/theme/theme_helper.dart';
import 'package:flutter/material.dart';
// ignore: unnecessary_import
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

class ResponsivenessScale extends StatefulWidget {
  const ResponsivenessScale({super.key});

  @override
  State<ResponsivenessScale> createState() => _ResponsivenessScaleState();
}

class _ResponsivenessScaleState extends State<ResponsivenessScale> {
  // TextEditingController _customerIdController = TextEditingController();
  // ignore: prefer_final_fields
  // TextEditingController _emailController = TextEditingController();
  bool isMale = true;
  bool isIncidentScreen = true;
  bool isSignupScreen = false;
  bool isRememberMe = false;
  int badgeCount = 0;
  int badgeCountTwo = 0;

  void incrementBadgeCount() {
    setState(() {
      badgeCount++;
    });
  }

  void incrementBadgeCountSecond() {
    setState(() {
      badgeCountTwo++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(
          'Transputec USA',
          style: GoogleFonts.urbanist(
              fontSize: 22, fontWeight: FontWeight.w600, color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh_outlined, color: Colors.white),
            onPressed: () {},
          ),
        ],
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: const BoxDecoration(
                color: Colors.blue,
              ),
              child: Row(
                children: [
                  Container(
                    child: const CircleAvatar(
                      radius: 25,
                      backgroundColor: Colors.white,
                      child: Text(
                        'SS',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: Container(
                      child: const Text(
                        'Santosh Singh', // Name
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Incident'),
              onTap: () {
                // Handle Home item tap
                incrementBadgeCount(); // Close the drawer
              },
            ),
            ListTile(
              leading: const Icon(Icons.account_circle),
              //title: const Text('Ping Messages'),
              onTap: () {
                // Handle Profile item tap
                incrementBadgeCountSecond(); // Close the drawer
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Settings'),
              onTap: () {
                // Handle Settings item tap
                Navigator.pop(context); // Close the drawer
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Logout'),
              onTap: () {
                /*Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => LoginPage(
                          customerId: "cc-eec-tw",
                          authenticationCredentials: AuthenticationCredentials(
                            "",
                            "",
                            "",
                            false,
                            "",
                            "",
                          ))),
                );*/
              },
            ),
          ],
        ),
      ),
      backgroundColor: Palette.backgroundColor,
      body: Stack(
        children: [
          Positioned(
            top: 0,
            right: 0,
            left: 0,
            child: Container(
              height: 250,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/images/img_group_10.png"),
                      fit: BoxFit.fill)),
              child: Container(
                padding: const EdgeInsets.only(top: 70, left: 20),
                color: const Color(0xFF1A5AA2).withOpacity(.0),
                child: const Column(
                  children: [
                    Row(
                      children: [],
                    )
                  ],
                ),
              ),
            ),
          ),

          Positioned(
            top: 150,
            child: Container(
              height: 240,
              padding: const EdgeInsets.all(65),
              width: MediaQuery.of(context).size.width - 40,
              margin: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        blurRadius: 15,
                        spreadRadius: 5),
                  ]),
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(top: 198, left: 92),
            child: Container(
              child: const Text(
                "Responsiveness Scale",
                style: TextStyle(fontSize: 22),
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(top: 247, left: 45),
            child: Container(
              child: const Text(
                "Incidents",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(top: 230, left: 200),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 40),
              child: const Text(
                "Lorem ipsum dolor sit. ",
                style: TextStyle(
                  fontSize: 12,
                  color: Color(0xff0B223C),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(top: 290, left: 239),
            child: Container(
              child: Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Row(
                  children: [
                    Container(
                      height: 5,
                      width: 15,
                      decoration: BoxDecoration(color: appTheme.greenA70001),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 5),
                      child: Container(
                        height: 5,
                        width: 15,
                        decoration: BoxDecoration(color: appTheme.greenA70001),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 5),
                      child: Container(
                        height: 5,
                        width: 15,
                        decoration: BoxDecoration(color: appTheme.amber600),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 5),
                      child: Container(
                        height: 5,
                        width: 15,
                        // decoration: BoxDecoration(color: appTheme.amber600),
                        decoration: BoxDecoration(color: appTheme.amber600),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 5),
                      child: Container(
                        height: 5,
                        width: 15,
                        decoration: BoxDecoration(color: appTheme.blackD71D53),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(top: 247, left: 235),
            child: Container(
              child: const Text(
                "Pings",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(top: 230, left: 10),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 40),
              child: const Text(
                "Lorem ipsum dolor sit. ",
                style: TextStyle(
                  fontSize: 12,
                  color: Color(0xff0B223C),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(top: 290, left: 48),
            child: Container(
              child: Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Row(
                  children: [
                    Container(
                      height: 5,
                      width: 15,
                      decoration: BoxDecoration(color: appTheme.greenA70001),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 5),
                      child: Container(
                        height: 5,
                        width: 15,
                        decoration: BoxDecoration(color: appTheme.greenA70001),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 5),
                      child: Container(
                        height: 5,
                        width: 15,
                        decoration:
                            BoxDecoration(color: appTheme.blueGray10001),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 5),
                      child: Container(
                        height: 5,
                        width: 15,
                        // decoration: BoxDecoration(color: appTheme.amber600),
                        decoration:
                            BoxDecoration(color: appTheme.blueGray10001),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 5),
                      child: Container(
                        height: 5,
                        width: 15,
                        decoration:
                            BoxDecoration(color: appTheme.blueGray10001),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          Positioned(
            // top: 300,
            child: Container(
              padding: const EdgeInsets.only(top: 410),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      Container(
                        width: 150,
                        height: 180,
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
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            children: [
                              // Badge Count
                              Padding(
                                padding: const EdgeInsets.only(
                                  left: 25,
                                ),
                                child: Badge(count: badgeCount),
                              ),
                              Container(
                                width: 55,
                                height: 55,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color:
                                        const Color(0xffF5F5F5), // Border color
                                    width: 5.0, // Border width
                                  ),
                                  color: const Color(0xff1E60AA),
                                ),
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              LaunchedIncidentThree()),
                                    );
                                  },
                                  child: const Image(
                                    image: AssetImage(
                                        'assets/images/incident_message_two.png'),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 8,
                                width: 15,
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            LaunchedIncidentThree()),
                                  );
                                },
                                child: Text(
                                  "Incidents",
                                  style: GoogleFonts.urbanist(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: const Color(0xff0B223C)),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            LaunchedIncidentThree()),
                                  );
                                },
                                child: GestureDetector(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      "View",
                                      style: GoogleFonts.urbanist(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                          color: const Color(0xff16A1ED)),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  //Column(
                  // children: [
                  //Container(
                  //  width: 00,
                  // height: 00,
                  //  child: Icon(
                  //  Icons.file_upload_outlined,
                  // color: Colors.green,
                  //  ),
                  // decoration: BoxDecoration(
                  //  color: Colors.white,
                  //   borderRadius: BorderRadius.circular(15),
                  //  boxShadow: [
                  // BoxShadow(
                  // color: Colors.black.withOpacity(0.3),
                  //  blurRadius: 15,
                  // spreadRadius: 5),
                  // ]),
                  // ),
                  // SizedBox(
                  //  height: 8,
                  // ),
                  // Text("data")
                  // ],
                  //  ),
                  Column(
                    children: [
                      Container(
                        width: 150,
                        height: 180,
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
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                  left: 25,
                                ),
                                child: Badge(count: badgeCountTwo),
                              ),
                              Container(
                                width: 55,
                                height: 55,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color:
                                        const Color(0xffF5F5F5), // Border color
                                    width: 5.0, // Border width
                                  ),
                                  color: const Color(0xffFFFFFF),
                                ),
                                child: GestureDetector(
                                  onTap: () {},
                                  // child: const Image(
                                  //   image: AssetImage(
                                  //       'assets/images/ping_message.png'),
                                  //   height: 40,
                                  //   width: 30,
                                  // ),
                                ),
                              ),
                              const SizedBox(
                                height: 8,
                                width: 15,
                              ),
                              Text(
                                "Ping Messages",
                                style: GoogleFonts.urbanist(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: const Color(0xff0B223C)),
                              ),
                              GestureDetector(
                                onTap: () {},
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "View",
                                    style: GoogleFonts.urbanist(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        color: const Color(0xff16A1ED)),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
          // buildBottomHalfContainer(true),

          Positioned(
            // top: 300,
            child: Container(
              padding: const EdgeInsets.only(top: 610),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: 150,
                          height: 180,
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
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              children: [
                                Container(
                                  width: 60,
                                  height: 60,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: const Color(
                                          0xffF5F5F5), // Border color
                                      width: 5.0, // Border width
                                    ),
                                    color: Colors.white,
                                  ),
                                  child: GestureDetector(
                                    onTap: () {
                                      showDialog(
                                        context: context,
                                        builder: (context) =>
                                            const CustomDialogWidget(),
                                      );
                                    },
                                    child: const Icon(
                                      Icons.sos,
                                      size: 30,
                                      color: Color(0xff1E60AA),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 8,
                                  width: 15,
                                ),
                                Text(
                                  "Emergency",
                                  style: GoogleFonts.urbanist(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: const Color(0xff0B223C)),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "View",
                                    style: GoogleFonts.urbanist(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        color: const Color(0xff16A1ED)),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  //Column(
                  // children: [
                  //Container(
                  //  width: 00,
                  // height: 00,
                  //  child: Icon(
                  //  Icons.file_upload_outlined,
                  // color: Colors.green,
                  //  ),
                  // decoration: BoxDecoration(
                  //  color: Colors.white,
                  //   borderRadius: BorderRadius.circular(15),
                  //  boxShadow: [
                  // BoxShadow(
                  // color: Colors.black.withOpacity(0.3),
                  //  blurRadius: 15,
                  // spreadRadius: 5),
                  // ]),
                  // ),
                  // SizedBox(
                  //  height: 8,
                  // ),
                  // Text("data")
                  // ],
                  //  ),
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 10, bottom: 0, left: 10, right: 10),
                        child: Container(
                          width: 150,
                          height: 180,
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
                            padding: const EdgeInsets.all(25.0),
                            child: Column(
                              children: [
                                Container(
                                  width: 58,
                                  height: 58,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: const Color(
                                          0xffF5F5F5), // Border color
                                      width: 5.0, // Border width
                                    ),
                                    color: const Color.fromARGB(
                                        255, 255, 255, 255),
                                  ),
                                  child: GestureDetector(
                                    onTap: () {
                                      showDialog(
                                        context: context,
                                        builder: (context) =>
                                            const CustomDialogWidget(),
                                      );
                                    },
                                    child: const Image(
                                      image:
                                          AssetImage('assets/images/task.png'),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 8,
                                  width: 15,
                                ),
                                Text(
                                  "Tasks",
                                  style: GoogleFonts.urbanist(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: const Color(0xff0B223C)),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "View",
                                    style: GoogleFonts.urbanist(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        color: const Color(0xff16A1ED)),
                                  ),
                                ),
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

          Positioned(
            top: 125,
            child: Padding(
              padding: const EdgeInsets.only(
                left: 165,
                bottom: 98,
              ),
              child: Container(
                width: 80,
                height: 80,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color.fromARGB(255, 255, 255, 255),
                ),
                child: const Image(
                  image: AssetImage('assets/images/headerimg500.png'),
                  height: 3,
                  width: 3,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CustomDialogWidget extends StatelessWidget {
  const CustomDialogWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
      child: Dialog(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 100),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Image(
                image: AssetImage('assets/images/sos_img.png'),
                width: 95,
              ),
              const SizedBox(
                height: 54,
              ),
              Text(
                "Send SOS123",
                style: GoogleFonts.urbanist(
                    fontSize: 22, fontWeight: FontWeight.w700),
              ),
              const SizedBox(
                height: 4,
              ),
              Text(
                "Are you sure you want to send SOS message? Preferred Call Back Options",
                textAlign: TextAlign.center,
                style: GoogleFonts.urbanist(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xff0B223C)),
              ),
              const SizedBox(height: 32),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        vertical: 8,
                        horizontal: 32,
                      ),
                      foregroundColor: const Color(0xff1E60AA),
                      side: const BorderSide(
                        color: Color(0xff1E60AA),
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('Cancel'),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          vertical: 8,
                          horizontal: 45,
                        ),
                        backgroundColor: const Color(0xff1E60AA),
                        foregroundColor: Colors.white),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text("Yes"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Badge extends StatelessWidget {
  final int count;

  const Badge({super.key, required this.count});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      decoration: const BoxDecoration(
        color: Color(0xffD71D53),
        shape: BoxShape.circle,
      ),
      child: Text(
        count.toString(),
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
