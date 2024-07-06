import 'package:crises_control/src/theme/theme_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class LaunchedIncidentThree extends StatelessWidget {
  LaunchedIncidentThree({super.key});

  final TextEditingController _customerIdController = TextEditingController();
  // ignore: prefer_final_fields
  TextEditingController _emailController = TextEditingController();
  bool isMale = true;
  bool isIncidentScreen = true;
  bool isSignupScreen = false;
  bool isRememberMe = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appTheme.gray10004,
      body: Stack(
        children: [
          Positioned(
            top: 0,
            right: 0,
            left: 0,
            child: Container(
              height: 300,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/images/img_group_10.png"),
                      fit: BoxFit.fill)),
              child: Container(
                padding: const EdgeInsets.only(top: 90, left: 20),
                color: const Color(0xFF1A5AA2).withOpacity(.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          child: IconButton(
                            icon: const Icon(Icons.arrow_back_rounded),
                            color: Colors.white,
                            onPressed: () => Navigator.of(context).pop(),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 40),
                          child: Container(
                            child: const Text(
                              "Launched Incidents",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 35),
                          child: Container(
                            child: SvgPicture.asset(
                              'assets/images/img_plus.svg',
                              width: 25,
                              height: 25,
                            ),

                            // color: Colors.white,
                            //color: Colors.white,
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
          // buildBottomHalfContainer(true),
          Positioned(
            top: 170,
            child: Container(
              height: 210,
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
          Opacity(
            opacity: 0.8,
            child: Padding(
              padding: const EdgeInsets.only(top: 255, left: 160),
              child: Container(
                child: Text(
                  "Tunisia, 798 Arufa Key",
                  style: GoogleFonts.urbanist(
                      fontSize: 16, fontWeight: FontWeight.w500),
                ),
              ),
            ),
          ),
          Positioned(
            child: Padding(
              padding: const EdgeInsets.only(top: 215, left: 135),
              child: Container(
                child: Text(
                  "Marcus Incident",
                  style: GoogleFonts.urbanist(
                      fontSize: 22, fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ),
          const Positioned(
            child: Padding(
              padding: EdgeInsets.only(top: 250, left: 128),
              child: SizedBox(
                width: 30,
                height: 30,
                child: Icon(
                  Icons.room_outlined,
                  size: 30,
                  color: Color(0xff16A1ED),
                ),
              ),
            ),
          ),
          Positioned(
            child: Padding(
              padding: const EdgeInsets.only(top: 285, left: 138),
              child: Container(
                child: Text(
                  "12 Mar  3:03 PM",
                  style: GoogleFonts.urbanist(
                      fontSize: 13, fontWeight: FontWeight.w400),
                ),
              ),
            ),
          ),
          Positioned(
            child: Padding(
              padding: const EdgeInsets.only(top: 315, right: 100, left: 128),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: 25,
                    height: 5,
                    decoration: BoxDecoration(
                      color: const Color(0xff00B60D),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  Container(
                    width: 25,
                    height: 5,
                    decoration: BoxDecoration(
                      color: const Color(0xff00B60D),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  Container(
                    width: 25,
                    height: 5,
                    decoration: BoxDecoration(
                      color: const Color(0xffFFB500),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  Container(
                    width: 25,
                    height: 5,
                    decoration: BoxDecoration(
                      color: const Color(0xffCCCCCC),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  Container(
                    width: 25,
                    height: 5,
                    decoration: BoxDecoration(
                      color: const Color(0xffCCCCCC),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            child: Padding(
              padding: const EdgeInsets.only(top: 215, left: 35),
              child: SizedBox(
                width: 85,
                height: 85,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: SvgPicture.asset(
                    'assets/images/img_settings_white_a700.svg',
                    width: 15,
                    height: 15,
                  ),
                ),
              ),
            ),
          ),

          //2nd stage create

          Positioned(
            top: 415,
            child: Container(
              height: 210,
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
          Opacity(
            opacity: 0.8,
            child: Padding(
              padding: const EdgeInsets.only(top: 500, left: 160),
              child: Container(
                child: Text(
                  "Tunisia, 798 Arufa Key",
                  style: GoogleFonts.urbanist(
                      fontSize: 16, fontWeight: FontWeight.w500),
                ),
              ),
            ),
          ),
          Positioned(
            child: Padding(
              padding: const EdgeInsets.only(top: 456, left: 135),
              child: Container(
                child: Text(
                  "Marcus Incident",
                  style: GoogleFonts.urbanist(
                      fontSize: 22, fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ),
          const Positioned(
            child: Padding(
              padding: EdgeInsets.only(top: 492, left: 128),
              child: SizedBox(
                width: 30,
                height: 30,
                child: Icon(
                  Icons.room_outlined,
                  size: 30,
                  color: Color(0xff16A1ED),
                ),
              ),
            ),
          ),
          Positioned(
            child: Padding(
              padding: const EdgeInsets.only(top: 525, left: 138),
              child: Container(
                child: Text(
                  "12 Mar  3:03 PM",
                  style: GoogleFonts.urbanist(
                      fontSize: 13, fontWeight: FontWeight.w400),
                ),
              ),
            ),
          ),
          Positioned(
            child: Padding(
              padding: const EdgeInsets.only(top: 554, right: 100, left: 128),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: 25,
                    height: 5,
                    decoration: BoxDecoration(
                      color: const Color(0xff00B60D),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  Container(
                    width: 25,
                    height: 5,
                    decoration: BoxDecoration(
                      color: const Color(0xff00B60D),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  Container(
                    width: 25,
                    height: 5,
                    decoration: BoxDecoration(
                      color: const Color(0xffFFB500),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  Container(
                    width: 25,
                    height: 5,
                    decoration: BoxDecoration(
                      color: const Color(0xffCCCCCC),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  Container(
                    width: 25,
                    height: 5,
                    decoration: BoxDecoration(
                      color: const Color(0xffCCCCCC),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            child: Padding(
              padding: const EdgeInsets.only(top: 455, left: 35),
              child: SizedBox(
                width: 85,
                height: 85,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: SvgPicture.asset(
                    'assets/images/img_close_3.svg',
                    width: 15,
                    height: 15,
                  ),
                ),
              ),
            ),
          ),

          Container(
            child: const Row(
              // mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
