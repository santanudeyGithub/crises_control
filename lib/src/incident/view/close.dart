import 'package:crises_control/src/CustomAppbar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ClosePage extends StatefulWidget {
  const ClosePage({super.key});

  @override
  State<ClosePage> createState() => _ClosePageState();
}

class _ClosePageState extends State<ClosePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: CustomHeader(
              title: 'Close',
            ),
          ),
          Positioned(
            top: 165,
            child: Container(
              height: 320,
              padding: const EdgeInsets.all(65),
              width: MediaQuery.of(context).size.width - 40,
              margin: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(25),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        blurRadius: 15,
                        spreadRadius: 5),
                  ]),
            ),
          ),
          const Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 190, left: 35),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Enter the reason…',
                    // Using UnderlineInputBorder for border
                    border: InputBorder.none, // No border
                  ),
                ),
              ),
            ],
          ),
          Center(
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Padding(
                padding: const EdgeInsets.only(top: 735, right: 185),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 60, vertical: 20),
                  decoration: BoxDecoration(
                    color: const Color(0xffD1DCE2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    'CANCEL',
                    style: GoogleFonts.urbanist(
                      fontSize: 16,
                      color: const Color(0xff0B223C),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Center(
            child: GestureDetector(
              onTap: () {
                print('Custom flat button pressed');
              },
              child: Padding(
                padding: const EdgeInsets.only(top: 735, left: 190),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 76, vertical: 20),
                  decoration: BoxDecoration(
                    color: const Color(0xff1E60AA),
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 6,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Text(
                    'OK',
                    style: GoogleFonts.urbanist(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
