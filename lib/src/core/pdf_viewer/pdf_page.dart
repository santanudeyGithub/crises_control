// import 'package:crises_control/src/core/pdf_viewer/cubit/pdf_cubit.dart';
// import 'package:crises_control/src/core/presentation/pages/empty_state.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';
// import 'package:flutter_pdfview/flutter_pdfview.dart';

// class PdfPage extends StatelessWidget {
//   const PdfPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     var language = AppLocalizations.of(context);
//     return Scaffold(
//       appBar: AppBar(title: Text(language!.title_action_plan)),
//       body: BlocBuilder<PdfCubit, PdfState>(
//         builder: (context, state) {
//           return state.pdfFilePath.isNotEmpty
//               ? PDFView(
//                   filePath: state.pdfFilePath,
//                   enableSwipe: true,
//                   swipeHorizontal: true,
//                   fitPolicy: FitPolicy.BOTH,
//                 )
//               : const EmptyState(
//                   text: 'Unable To Load Action Plan',
//                   icon: Icons.picture_as_pdf,
//                 );
//         },
//       ),
//     );
//   }
// }

import 'package:crises_control/src/CustomAppbar.dart';
import 'package:crises_control/src/core/pdf_viewer/cubit/pdf_cubit.dart';
import 'package:crises_control/src/core/presentation/pages/empty_state.dart';
import 'package:crises_control/src/login/view/widgets/custom_image_view.dart';
import 'package:crises_control/src/login/view/widgets/image_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:google_fonts/google_fonts.dart';

class PdfPage extends StatelessWidget {
  const PdfPage({super.key});

  @override
  Widget build(BuildContext context) {
    var language = AppLocalizations.of(context);
    return Scaffold(
      // appBar: AppBar(title: Text(language!.title_action_plan)),
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: CustomHeader(title: language!.title_action_plan),
          ),
          Positioned(
            top: 135, // Adjust to control the overlap
            left: 16,
            right: 16,
            bottom: 50,
            child: Column(
              children: [
                Container(
                  height: 320,
                  // width: 300,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 25),
                    child: Container(
                      margin: EdgeInsets.only(
                          top: 5, right: 15), // Adjust this to position the box
                      padding: EdgeInsets.all(16.0),
                      width: 350,
                      height: 200,
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
                                padding:
                                    const EdgeInsets.only(right: 18, top: 12),
                                child: Image(
                                  image: AssetImage(
                                      'assets/images/actionlogosmall.png'),
                                  height: 80,
                                  width: 80,
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 10, right: 35),
                                child: Text(
                                  'Standard Operating \nProcedure',
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
                            child: Padding(
                              padding: const EdgeInsets.only(left: 25),
                              child: Text(
                                "Crises Control Limited",
                                maxLines: 4,
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.urbanist(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xff1E60AA)),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 35),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Image(
                                  image: AssetImage(
                                      'assets/images/personicon.png'),
                                  height: 25,
                                  width: 25,
                                ),
                                SizedBox(
                                    width:
                                        15), // Adding space between the icon and text
                                Text(
                                  'Owner / Author',
                                  style: TextStyle(fontSize: 18),
                                ),
                                SizedBox(
                                    width:
                                        20), // Adding space between the first pair and the second pair

                                Text(
                                  'Juan-Pierre Rossouw',
                                  style: GoogleFonts.urbanist(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: Color(0xff1E60AA)),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 50),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(right: 30),
                                  child: Text(
                                    'Last Modified : 21-Apr-2024',
                                    style: GoogleFonts.urbanist(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        fontStyle: FontStyle.italic,
                                        color: Color(0xff0B223C)),
                                  ),
                                ),
                                // Adding space between the first pair and the second pair

                                Text(
                                  'Version : v5.5.2.0',
                                  style: GoogleFonts.urbanist(
                                      fontSize: 14,
                                      fontStyle: FontStyle.italic),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  width: 350,
                  height: 350,
                  margin: EdgeInsets.only(top: 10, right: 15),
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
                      Container(
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 30, left: 20, right: 20),
                          child: Opacity(
                            opacity: 0.6,
                            child: Text(
                              "In publishing and graphic design, Lorem ipsum "
                              "is a placeholder text commonly used to "
                              "demonstrate the visual form of a document or"
                              "a typeface without relying.",
                              style: GoogleFonts.urbanist(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: const Color(0xff0B223C)),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 20, left: 20, right: 20),
                          child: Opacity(
                            opacity: 0.6,
                            child: Text(
                              "In publishing and graphic design, Lorem ipsum "
                              "is a placeholder text commonly used to "
                              "demonstrate the visual form of a document or"
                              "a typeface without relying.",
                              style: GoogleFonts.urbanist(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: const Color(0xff0B223C)),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 15, left: 20, right: 20),
                          child: Opacity(
                            opacity: 0.6,
                            child: Text(
                              "In publishing and graphic design, Lorem ipsum "
                              "is a placeholder text commonly used to "
                              "demonstrate the visual form of a document or"
                              "a typeface without relying.",
                              style: GoogleFonts.urbanist(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: const Color(0xff0B223C)),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
