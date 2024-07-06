import 'package:crises_control/src/CustomAppbar.dart';
import 'package:crises_control/src/login/view/widgets/custom_image_view.dart';
import 'package:crises_control/src/login/view/widgets/image_constant.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EventLog extends StatefulWidget {
  const EventLog({super.key});

  @override
  State<EventLog> createState() => _EventLogState();
}

class _EventLogState extends State<EventLog> {
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
              title: 'Event Log',
            ),
          ),
          Positioned(
            top: 165,
            child: Container(
              padding: EdgeInsets.only(
                left: 90,
                top: 165,
              ),
              child: Column(
                children: [
                  Opacity(
                    opacity: 0.66999996,
                    child: CustomImageView(
                      imagePath: ImageConstant.imgArchiveBook,
                      height: 190,
                      width: 190,
                    ),
                  ),
                  SizedBox(height: 32),
                  Text(
                    "No Event Found",
                    style: GoogleFonts.urbanist(
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                        color: Color(0xff0B223C)),
                  ),
                  SizedBox(height: 20),
                  Opacity(
                    opacity: 0.7,
                    child: SizedBox(
                      width: 220,
                      child: Text(
                        "In publishing and graphic design, Lorem \nipsum is a placeholder text commonly \nused to demonstrate.",
                        maxLines: 3,
                        // overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.urbanist(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: Color(0xff0B223C)),
                      ),
                    ),
                  ),
                  SizedBox(height: 5),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
