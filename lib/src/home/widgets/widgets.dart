// ************** OLD CODE *****************//
// // ignore_for_file: use_super_parameters

// import 'dart:developer' as developer;
// import 'package:crises_control/src/core/constants.dart';
// import 'package:crises_control/src/core/presentation/styles/text/material_colors_helper.dart';
// import 'package:crises_control/src/core/repository/crises_control_core_repository.dart';
// import 'package:crises_control/src/core/router/page_arguments/page_arguments.dart';
// import 'package:crises_control/src/core/router/route_constants.dart';
// import 'package:crises_control/src/home/models/home_item.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';
// import 'package:badges/badges.dart' as badges;
// export 'home_body.dart';

// class HomeIcon extends StatelessWidget {
//   const HomeIcon({
//     Key? key,
//     required this.badgeNumber,
//     required this.homeItem,
//     this.isEnabled = true,
//   }) : super(key: key);

//   final int badgeNumber;
//   final HomeItemType homeItem;
//   final bool isEnabled;

//   @override
//   Widget build(BuildContext context) {
//     var language = AppLocalizations.of(context);
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         TextButton(
//           onPressed: () {
//             if (!isEnabled) return;
//             ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
//             switch (homeItem) {
//               case HomeItemType.incidents:
//                 developer.log('Incident Pressed');
//                 Navigator.pushNamed(context, RouteConstants.incidentsPage,
//                     arguments: IncidentsPageArgument(
//                       false,
//                     ));
//                 break;
//               case HomeItemType.pingMessages:
//                 developer.log('Pings Pressed');
//                 Navigator.pushNamed(context, RouteConstants.pingListPage);
//                 break;
//               case HomeItemType.emergency:
//                 developer.log('SOS tapped');
//                 displaySOSDialog(context);
//                 break;
//               case HomeItemType.tasks:
//                 developer.log('Tasks tapped');
//                 Navigator.pushNamed(
//                   context,
//                   RouteConstants.webViewPage,
//                   arguments: WebViewPageArguments(
//                       RepositoryProvider.of<CrisesControlCoreRepository>(
//                                   context)
//                               .retrieveHomeData()
//                               ?.data
//                               .myTaskUrl ??
//                           CrisesControlUrls.portal,
//                       language!.label_tasks),
//                 );
//                 break;
//               case HomeItemType.chat:
//                 developer.log('chat tapped');
//                 break;
//               case HomeItemType.analytics:
//                 developer.log('chat tapped');
//                 break;
//             }
//           },
//           child: badges.Badge(
//             showBadge: badgeNumber >= 1,
//             badgeContent: Text(
//               badgeNumber.toString(),
//               style: const TextStyle(
//                 color: Colors.white,
//               ),
//             ),
//             child: Container(
//               width: MediaQuery.of(context).size.width / 2.5,
//               height: MediaQuery.of(context).size.height / 5.5,
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(18),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.grey.shade600.withOpacity(0.5),
//                     spreadRadius: 2,
//                     blurRadius: 12,
//                     offset: const Offset(-2, 2), // changes position of shadow
//                   ),
//                 ],
//               ),
//               child: Center(
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Icon(
//                       HomeItemHelper.getIconData(homeItem),
//                       color: Palette.primary,
//                       size: 60,
//                     ),
//                     const SizedBox(height: 10),
//                     Text(
//                       HomeItemHelper.getText(homeItem, context),
//                       textAlign: TextAlign.center,
//                       style: TextStyle(
//                         fontWeight: FontWeight.w600,
//                         fontSize: 18,
//                         color: Colors.grey.shade700,
//                       ),
//                     )
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }

//   Future<void> displaySOSDialog(context) async {
//     var language = AppLocalizations.of(context);

//     return showDialog<void>(
//       context: context,
//       barrierDismissible: true,
//       builder: (BuildContext buildcontext) {
//         return AlertDialog(
//           shape: const RoundedRectangleBorder(
//             borderRadius: BorderRadius.all(
//               Radius.circular(UIConstants.defaultCornerRadius),
//             ),
//           ),
//           actionsAlignment: MainAxisAlignment.start,
//           title: Text(language!.alert_title_sos),
//           content: SingleChildScrollView(
//             child: ListBody(
//               children: [
//                 Text(language.alert_sos_message),
//               ],
//             ),
//           ),
//           actions: const [
//             SOSActionsPrompt(),
//           ],
//         );
//       },
//     );
//   }
// }

// class SOSActionsPrompt extends StatefulWidget {
//   const SOSActionsPrompt({super.key});

//   @override
//   State<SOSActionsPrompt> createState() => _SOSPromptState();
// }

// class _SOSPromptState extends State<SOSActionsPrompt> {
//   bool phoneSelected = false;
//   bool textSelected = false;
//   @override
//   Widget build(BuildContext context) {
//     var language = AppLocalizations.of(context);
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 14),
//           child: Text(language!.label_call_back_options),
//         ),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.start,
//           children: [
//             Row(
//               children: [
//                 IconButton(
//                   onPressed: () {
//                     setState(() {
//                       phoneSelected = !phoneSelected;
//                     });
//                   },
//                   icon: Icon(
//                     phoneSelected
//                         ? Icons.check_circle
//                         : Icons.radio_button_unchecked,
//                     color: phoneSelected ? Palette.primary : Colors.grey,
//                   ),
//                 ),
//                 Text(language.label_sos_phone)
//               ],
//             ),
//             Row(
//               children: [
//                 IconButton(
//                   onPressed: () {
//                     setState(() {
//                       textSelected = !textSelected;
//                     });
//                   },
//                   icon: Icon(
//                     textSelected
//                         ? Icons.check_circle
//                         : Icons.radio_button_unchecked,
//                     color: textSelected ? Palette.primary : Colors.grey,
//                   ),
//                 ),
//                 Text(language.label_sos_text)
//               ],
//             ),
//           ],
//         ),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.end,
//           children: [
//             TextButton(
//               onPressed: () => Navigator.pop(context),
//               child: Text(
//                 language.cancel,
//                 style: TextStyle(color: Colors.grey.shade700),
//               ),
//             ),
//             TextButton(
//               onPressed: () => Navigator.pop(context),
//               child: Text(language.btn_submit),
//             )
//           ],
//         ),
//       ],
//     );
//   }
// }

// ********************** NEW CODE **********************************//

// // ignore_for_file: use_super_parameters

// import 'dart:developer' as developer;
// import 'dart:ui';
// import 'package:crises_control/src/core/constants.dart';
// import 'package:crises_control/src/core/presentation/styles/text/material_colors_helper.dart';
// import 'package:crises_control/src/core/repository/crises_control_core_repository.dart';
// import 'package:crises_control/src/core/router/page_arguments/page_arguments.dart';
// import 'package:crises_control/src/core/router/route_constants.dart';
// import 'package:crises_control/src/home/models/home_item.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';
// import 'package:badges/badges.dart' as badges;
// import 'package:google_fonts/google_fonts.dart';
// export 'home_body.dart';

// class HomeIcon extends StatelessWidget {
//   const HomeIcon({
//     Key? key,
//     required this.badgeNumber,
//     required this.homeItem,
//     this.isEnabled = true,
//   }) : super(key: key);

//   final int badgeNumber;
//   final HomeItemType homeItem;
//   final bool isEnabled;

//   @override
//   Widget build(BuildContext context) {
//     var language = AppLocalizations.of(context);
//     bool phoneSelected = false;
//     bool textSelected = false;
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         TextButton(
//           onPressed: () {
//             if (!isEnabled) return;
//             ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
//             switch (homeItem) {
//               case HomeItemType.incidents:
//                 developer.log('Incident Pressed');
//                 Navigator.pushNamed(context, RouteConstants.incidentsPage,
//                     arguments: IncidentsPageArgument(
//                       false,
//                     ));
//                 break;
//               case HomeItemType.pingMessages:
//                 developer.log('Pings Pressed');
//                 Navigator.pushNamed(context, RouteConstants.pingListPage);
//                 break;
//               case HomeItemType.emergency:
//                 developer.log('SOS tapped');
//                 showDialog(
//                   context: context,
//                   builder: (context) => CustomDialogWidget(
//                     phoneSelected: phoneSelected,
//                     textSelected: textSelected,
//                     onPhoneSelected: () {
//                       // Handle phone selection logic here
//                     },
//                     onTextSelected: () {
//                       // Handle text selection logic here
//                     },
//                   ),
//                 );
//                 break;
//               // displaySOSDialog(context);
//               // onTap:
//               // () {
//               //   showDialog(
//               //     context: context,
//               //     builder: (context) => const CustomDialogWidget(),
//               //   );
//               // };
//               //break;
//               case HomeItemType.tasks:
//                 developer.log('Tasks tapped');
//                 Navigator.pushNamed(
//                   context,
//                   RouteConstants.webViewPage,
//                   arguments: WebViewPageArguments(
//                       RepositoryProvider.of<CrisesControlCoreRepository>(
//                                   context)
//                               .retrieveHomeData()
//                               ?.data
//                               .myTaskUrl ??
//                           CrisesControlUrls.portal,
//                       language!.label_tasks),
//                 );
//                 break;
//               case HomeItemType.chat:
//                 developer.log('chat tapped');
//                 break;
//               case HomeItemType.analytics:
//                 developer.log('chat tapped');
//                 break;
//             }
//           },
//           child: badges.Badge(
//             showBadge: badgeNumber >= 1,
//             badgeContent: Text(
//               badgeNumber.toString(),
//               style: const TextStyle(
//                 color: Colors.white,
//               ),
//             ),
//             child: Container(
//               width: MediaQuery.of(context).size.width / 2.5,
//               height: MediaQuery.of(context).size.height / 5.5,
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(18),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.grey.shade600.withOpacity(0.5),
//                     spreadRadius: 2,
//                     blurRadius: 12,
//                     offset: const Offset(-2, 2), // changes position of shadow
//                   ),
//                 ],
//               ),
//               child: Center(
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Icon(
//                       HomeItemHelper.getIconData(homeItem),
//                       color: Palette.primary,
//                       size: 60,
//                     ),
//                     const SizedBox(height: 10),
//                     Text(
//                       HomeItemHelper.getText(homeItem, context),
//                       textAlign: TextAlign.center,
//                       style: TextStyle(
//                         fontWeight: FontWeight.w600,
//                         fontSize: 18,
//                         color: Colors.grey.shade700,
//                       ),
//                     )
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }

//   // Future<void> displaySOSDialog(context) async {
//   //   var language = AppLocalizations.of(context);

//   //   return showDialog<void>(
//   //     context: context,
//   //     barrierDismissible: true,
//   //     builder: (BuildContext buildcontext) {
//   //       return AlertDialog(
//   //         shape: const RoundedRectangleBorder(
//   //           borderRadius: BorderRadius.all(
//   //             Radius.circular(UIConstants.defaultCornerRadius),
//   //           ),
//   //         ),
//   //         actionsAlignment: MainAxisAlignment.center,
//   //         title: Text(language!.alert_title_sos),
//   //         content: SingleChildScrollView(
//   //           child: ListBody(
//   //             children: [
//   //               Text(language!.alert_sos_message),
//   //             ],
//   //           ),
//   //         ),
//   //         actions: const [
//   //           SOSActionsPrompt(),
//   //         ],
//   //       );
//   //     },
//   //   );
//   // }
// }

// // class CustomDialogWidget extends StatelessWidget {
// //   const CustomDialogWidget({super.key});

// //   @override
// //   Widget build(BuildContext context) {
// //     var language = AppLocalizations.of(context);
// //     return BackdropFilter(
// //       filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
// //       child: Dialog(
// //         child: Container(
// //           padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 100),
// //           decoration: BoxDecoration(
// //             color: Colors.white,
// //             borderRadius: BorderRadius.circular(12),
// //           ),
// //           child: Column(
// //             mainAxisSize: MainAxisSize.min,
// //             children: [
// //               const Image(
// //                 image: AssetImage('assets/images/sos_img.png'),
// //                 width: 95,
// //               ),
// //               const SizedBox(
// //                 height: 24,
// //               ),
// //               // Text(
// //               //   "Send SOS123",
// //               //   style: GoogleFonts.urbanist(
// //               //       fontSize: 22, fontWeight: FontWeight.w700),
// //               // ),
// //               Text(language!.alert_title_sos),
// //               const SizedBox(
// //                 height: 4,
// //               ),
// //               // Text(
// //               //   "Are you sure you want to send SOS message? Preferred Call Back Options",
// //               //   textAlign: TextAlign.center,
// //               //   style: GoogleFonts.urbanist(
// //               //       fontSize: 16,
// //               //       fontWeight: FontWeight.w500,
// //               //       color: const Color(0xff0B223C)),
// //               // ),
// //               Text(language!.alert_sos_message),
// //               const SizedBox(height: 32),
// //               Row(
// //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //                 children: [
// //                   OutlinedButton(
// //                     style: OutlinedButton.styleFrom(
// //                       padding: const EdgeInsets.symmetric(
// //                         vertical: 8,
// //                         horizontal: 32,
// //                       ),
// //                       foregroundColor: const Color(0xff1E60AA),
// //                       side: const BorderSide(
// //                         color: Color(0xff1E60AA),
// //                       ),
// //                     ),
// //                     onPressed: () {},
// //                     child: const Text('CANCEL'),
// //                   ),
// //                   ElevatedButton(
// //                     style: ElevatedButton.styleFrom(
// //                         padding: const EdgeInsets.symmetric(
// //                           vertical: 8,
// //                           horizontal: 45,
// //                         ),
// //                         backgroundColor: const Color(0xff1E60AA),
// //                         foregroundColor: Colors.white),
// //                     onPressed: () {},
// //                     child: const Text("SUBMIT"),
// //                   ),
// //                 ],
// //               ),
// //             ],
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// // }
// ////////////////
// // class CustomDialogWidget extends StatelessWidget {
// //   const CustomDialogWidget({super.key});

// //   @override
// //   Widget build(BuildContext context) {
// //     var language = AppLocalizations.of(context);
// //     return BackdropFilter(
// //       filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
// //       child: Dialog(
// //         shape: RoundedRectangleBorder(
// //           borderRadius: BorderRadius.circular(12),
// //         ),
// //         child: Container(
// //           padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
// //           decoration: BoxDecoration(
// //             color: Colors.white,
// //             borderRadius: BorderRadius.circular(12),
// //           ),
// //           child: Column(
// //             mainAxisSize: MainAxisSize.min,
// //             children: [
// //               Padding(
// //                 padding: const EdgeInsets.only(top: 24, bottom: 16),
// //                 child: const Image(
// //                   image: AssetImage('assets/images/sos_img.png'),
// //                   width: 95,
// //                 ),
// //               ),
// //               Text(
// //                 language!.alert_title_sos,
// //                 style: GoogleFonts.urbanist(
// //                   fontSize: 22,
// //                   fontWeight: FontWeight.w700,
// //                 ),
// //               ),
// //               const SizedBox(
// //                 height: 8,
// //               ),
// //               Text(
// //                 language.alert_sos_message,
// //                 textAlign: TextAlign.center,
// //                 style: GoogleFonts.urbanist(
// //                   fontSize: 16,
// //                   fontWeight: FontWeight.w500,
// //                   color: const Color(0xff0B223C),
// //                 ),
// //               ),
// //               const SizedBox(height: 32),
// //               Row(
// //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //                 children: [
// //                   Expanded(
// //                     child: OutlinedButton(
// //                       style: OutlinedButton.styleFrom(
// //                         padding: const EdgeInsets.symmetric(
// //                           vertical: 12,
// //                         ),
// //                         foregroundColor: const Color(0xff1E60AA),
// //                         side: const BorderSide(
// //                           color: Color(0xff1E60AA),
// //                         ),
// //                       ),
// //                       onPressed: () {
// //                         Navigator.of(context).pop();
// //                       },
// //                       child: Text(language.cancel.toUpperCase()),
// //                     ),
// //                   ),
// //                   const SizedBox(width: 16),
// //                   Expanded(
// //                     child: ElevatedButton(
// //                       style: ElevatedButton.styleFrom(
// //                         padding: const EdgeInsets.symmetric(
// //                           vertical: 12,
// //                         ),
// //                         backgroundColor: const Color(0xff1E60AA),
// //                         foregroundColor: Colors.white,
// //                       ),
// //                       onPressed: () {
// //                         Navigator.of(context).pop();
// //                       },
// //                       child: Text(language.btn_submit.toUpperCase()),
// //                     ),
// //                   ),
// //                 ],
// //               ),
// //             ],
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// // }

// ///////////////
// // class CustomDialogWidget extends StatelessWidget {
// //   const CustomDialogWidget({super.key});

// //   @override
// //   Widget build(BuildContext context) {
// //     var language = AppLocalizations.of(context);
// //     return BackdropFilter(
// //       filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
// //       child: Dialog(
// //         shape: RoundedRectangleBorder(
// //           borderRadius: BorderRadius.circular(12),
// //         ),
// //         child: Container(
// //           padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
// //           decoration: BoxDecoration(
// //             color: Colors.white,
// //             borderRadius: BorderRadius.circular(12),
// //           ),
// //           child: Column(
// //             mainAxisSize: MainAxisSize.min,
// //             children: [
// //               Padding(
// //                 padding: const EdgeInsets.only(top: 16, bottom: 24),
// //                 child: const Image(
// //                   image: AssetImage('assets/images/sos_img.png'),
// //                   width: 95,
// //                 ),
// //               ),
// //               Text(
// //                 language!.alert_title_sos,
// //                 style: GoogleFonts.urbanist(
// //                   fontSize: 22,
// //                   fontWeight: FontWeight.w700,
// //                 ),
// //               ),
// //               const SizedBox(
// //                 height: 8,
// //               ),
// //               Text(
// //                 language.alert_sos_message,
// //                 textAlign: TextAlign.center,
// //                 style: GoogleFonts.urbanist(
// //                   fontSize: 16,
// //                   fontWeight: FontWeight.w500,
// //                   color: const Color(0xff0B223C),
// //                 ),
// //               ),
// //               const SizedBox(height: 32),
// //               Row(
// //                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
// //                 children: [
// //                   _buildContactOption(
// //                     context,
// //                     'assets/images/mobile.png', // Replace with your mobile image asset
// //                     // language!.mobile_alert,
// //                     'Mobile',
// //                     onPressed: () {
// //                       // Add your onPressed logic for email
// //                     },
// //                   ),
// //                   _buildContactOption(
// //                     context,
// //                     'assets/images/email.png', // Replace with your email image asset
// //                     //language!.email_alert,
// //                     'Email Alert',
// //                     onPressed: () {
// //                       // Add your onPressed logic for email
// //                     },
// //                   ),
// //                 ],
// //               ),
// //               const SizedBox(height: 32),
// //               Row(
// //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //                 children: [
// //                   Expanded(
// //                     child: OutlinedButton(
// //                       style: OutlinedButton.styleFrom(
// //                         padding: const EdgeInsets.symmetric(
// //                           vertical: 12,
// //                         ),
// //                         foregroundColor: const Color(0xff1E60AA),
// //                         side: const BorderSide(
// //                           color: Color(0xff1E60AA),
// //                         ),
// //                       ),
// //                       onPressed: () {
// //                         Navigator.of(context).pop();
// //                       },
// //                       child: Text(language.cancel.toUpperCase()),
// //                     ),
// //                   ),
// //                   const SizedBox(width: 16),
// //                   Expanded(
// //                     child: ElevatedButton(
// //                       style: ElevatedButton.styleFrom(
// //                         padding: const EdgeInsets.symmetric(
// //                           vertical: 12,
// //                         ),
// //                         backgroundColor: const Color(0xff1E60AA),
// //                         foregroundColor: Colors.white,
// //                       ),
// //                       onPressed: () {
// //                         Navigator.of(context).pop();
// //                       },
// //                       child: Text(language.btn_submit.toUpperCase()),
// //                     ),
// //                   ),
// //                 ],
// //               ),
// //             ],
// //           ),
// //         ),
// //       ),
// //     );
// //   }

// //   // Widget _buildContactOption(
// //   //     BuildContext context, String imagePath, String label) {
// //   //   return Column(
// //   //     children: [
// //   //       Image.asset(
// //   //         imagePath,
// //   //         width: 70,
// //   //         height: 70,
// //   //       ),
// //   //       const SizedBox(height: 10),
// //   //       Text(
// //   //         label,
// //   //         style: GoogleFonts.urbanist(
// //   //           fontSize: 16,
// //   //           fontWeight: FontWeight.w600,
// //   //         ),
// //   //       ),
// //   //     ],
// //   //   );
// //   // }
// //   ///////
// //   // Widget _buildContactOption(
// //   //     BuildContext context, String imagePath, String label) {
// //   //   return Container(
// //   //     width: 100,
// //   //     decoration: BoxDecoration(
// //   //       borderRadius: BorderRadius.circular(10),
// //   //       border: Border.all(
// //   //         color: Colors.grey.withOpacity(0.3),
// //   //         width: 1,
// //   //       ),
// //   //     ),
// //   //     padding: const EdgeInsets.all(8),
// //   //     child: Container(
// //   //       padding: const EdgeInsets.symmetric(vertical: 5),
// //   //       child: Column(
// //   //         mainAxisAlignment: MainAxisAlignment.center,
// //   //         children: [
// //   //           Image.asset(
// //   //             imagePath,
// //   //             width: 80,
// //   //             height: 80,
// //   //           ),
// //   //           const SizedBox(height: 10),
// //   //           Text(
// //   //             label,
// //   //             style: GoogleFonts.urbanist(
// //   //               fontSize: 16,
// //   //               fontWeight: FontWeight.w600,
// //   //             ),
// //   //           ),
// //   //         ],
// //   //       ),
// //   //     ),
// //   //   );
// //   // }
// //   Widget _buildContactOption(
// //       BuildContext context, String imagePath, String label,
// //       {VoidCallback? onPressed}) {
// //     return GestureDetector(
// //       onTap: onPressed,
// //       child: Container(
// //         width: 100,
// //         decoration: BoxDecoration(
// //           borderRadius: BorderRadius.circular(8),
// //           border: Border.all(
// //             color: Colors.grey.withOpacity(0.5),
// //             width: 1,
// //           ),
// //         ),
// //         padding: EdgeInsets.symmetric(
// //             vertical: 8), // Horizontal and vertical padding within the border
// //         child: Container(
// //           padding: EdgeInsets.symmetric(
// //               vertical: 8), // Additional vertical padding for the content
// //           child: Column(
// //             mainAxisAlignment: MainAxisAlignment.center,
// //             children: [
// //               GestureDetector(
// //                 onTap: onPressed,
// //                 child: Image.asset(
// //                   imagePath,
// //                   width: 50,
// //                   height: 50,
// //                 ),
// //               ),
// //               const SizedBox(height: 8),
// //               Text(
// //                 label,
// //                 style: GoogleFonts.urbanist(
// //                   fontSize: 16,
// //                   fontWeight: FontWeight.w600,
// //                 ),
// //               ),
// //             ],
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// // }

// class CustomDialogWidget extends StatelessWidget {
//   const CustomDialogWidget({
//     Key? key,
//     required this.phoneSelected,
//     required this.textSelected,
//     required this.onPhoneSelected,
//     required this.onTextSelected,
//   }) : super(key: key);

//   final bool phoneSelected;
//   final bool textSelected;
//   final VoidCallback onPhoneSelected;
//   final VoidCallback onTextSelected;

//   @override
//   Widget build(BuildContext context) {
//     var language = AppLocalizations.of(context);
//     return BackdropFilter(
//       filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
//       child: Dialog(
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(12),
//         ),
//         child: Container(
//           padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
//           decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.circular(12),
//           ),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Padding(
//                 padding: const EdgeInsets.only(top: 16, bottom: 24),
//                 child: const Image(
//                   image: AssetImage('assets/images/sos_img.png'),
//                   width: 95,
//                 ),
//               ),
//               Text(
//                 language!.alert_title_sos,
//                 style: GoogleFonts.urbanist(
//                   fontSize: 22,
//                   fontWeight: FontWeight.w700,
//                 ),
//               ),
//               const SizedBox(
//                 height: 8,
//               ),
//               Text(
//                 language.alert_sos_message,
//                 textAlign: TextAlign.center,
//                 style: GoogleFonts.urbanist(
//                   fontSize: 16,
//                   fontWeight: FontWeight.w500,
//                   color: const Color(0xff0B223C),
//                 ),
//               ),
//               const SizedBox(height: 32),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: [
//                   _buildContactOption(
//                     context,
//                     'assets/images/mobile.png', // Replace with your mobile image asset
//                     // language!.mobile_alert,
//                     'Mobile',
//                     onPressed: onPhoneSelected,
//                   ),
//                   _buildContactOption(
//                     context,
//                     'assets/images/email.png', // Replace with your email image asset
//                     //language!.email_alert,
//                     'Email Alert',
//                     onPressed: onTextSelected,
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 32),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Expanded(
//                     child: OutlinedButton(
//                       style: OutlinedButton.styleFrom(
//                         padding: const EdgeInsets.symmetric(
//                           vertical: 12,
//                         ),
//                         foregroundColor: const Color(0xff1E60AA),
//                         side: const BorderSide(
//                           color: Color(0xff1E60AA),
//                         ),
//                       ),
//                       onPressed: () {
//                         Navigator.of(context).pop();
//                       },
//                       child: Text(language.cancel.toUpperCase()),
//                     ),
//                   ),
//                   const SizedBox(width: 16),
//                   Expanded(
//                     child: ElevatedButton(
//                       style: ElevatedButton.styleFrom(
//                         padding: const EdgeInsets.symmetric(
//                           vertical: 12,
//                         ),
//                         backgroundColor: const Color(0xff1E60AA),
//                         foregroundColor: Colors.white,
//                       ),
//                       onPressed: () {
//                         Navigator.of(context).pop();
//                       },
//                       child: Text(language.btn_submit.toUpperCase()),
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildContactOption(
//       BuildContext context, String imagePath, String label,
//       {VoidCallback? onPressed}) {
//     return GestureDetector(
//       onTap: onPressed,
//       child: Container(
//         width: 100,
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(8),
//           border: Border.all(
//             color: Colors.grey.withOpacity(0.5),
//             width: 1,
//           ),
//         ),
//         padding: EdgeInsets.symmetric(
//             vertical: 8), // Horizontal and vertical padding within the border
//         child: Container(
//           padding: EdgeInsets.symmetric(
//               vertical: 8), // Additional vertical padding for the content
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               GestureDetector(
//                 onTap: onPressed,
//                 child: Image.asset(
//                   imagePath,
//                   width: 50,
//                   height: 50,
//                 ),
//               ),
//               const SizedBox(height: 8),
//               Text(
//                 label,
//                 style: GoogleFonts.urbanist(
//                   fontSize: 16,
//                   fontWeight: FontWeight.w600,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// ///////////
// class SOSActionsPrompt extends StatefulWidget {
//   const SOSActionsPrompt({super.key});

//   @override
//   State<SOSActionsPrompt> createState() => _SOSPromptState();
// }

// class _SOSPromptState extends State<SOSActionsPrompt> {
//   bool phoneSelected = false;
//   bool textSelected = false;
//   @override
//   Widget build(BuildContext context) {
//     var language = AppLocalizations.of(context);
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 14),
//           child: Text(language!.label_call_back_options),
//         ),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.start,
//           children: [
//             Row(
//               children: [
//                 IconButton(
//                   onPressed: () {
//                     setState(() {
//                       phoneSelected = !phoneSelected;
//                     });
//                   },
//                   icon: Icon(
//                     phoneSelected
//                         ? Icons.check_circle
//                         : Icons.radio_button_unchecked,
//                     color: phoneSelected ? Palette.primary : Colors.grey,
//                   ),
//                 ),
//                 Text(language.label_sos_phone)
//               ],
//             ),
//             Row(
//               children: [
//                 IconButton(
//                   onPressed: () {
//                     setState(() {
//                       textSelected = !textSelected;
//                     });
//                   },
//                   icon: Icon(
//                     textSelected
//                         ? Icons.check_circle
//                         : Icons.radio_button_unchecked,
//                     color: textSelected ? Palette.primary : Colors.grey,
//                   ),
//                 ),
//                 Text(language.label_sos_text)
//               ],
//             ),
//           ],
//         ),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.end,
//           children: [
//             TextButton(
//               onPressed: () => Navigator.pop(context),
//               child: Text(
//                 language.cancel,
//                 style: TextStyle(color: Colors.grey.shade700),
//               ),
//             ),
//             TextButton(
//               onPressed: () => Navigator.pop(context),
//               child: Text(language.btn_submit),
//             )
//           ],
//         ),
//       ],
//     );
//   }
// }
//**************//
// import 'dart:developer' as developer;
// import 'dart:ui';
// import 'package:crises_control/src/core/constants.dart';
// import 'package:crises_control/src/core/presentation/styles/text/material_colors_helper.dart';
// import 'package:crises_control/src/core/repository/crises_control_core_repository.dart';
// import 'package:crises_control/src/core/router/page_arguments/page_arguments.dart';
// import 'package:crises_control/src/core/router/route_constants.dart';
// import 'package:crises_control/src/home/models/home_item.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';
// import 'package:badges/badges.dart' as badges;
// import 'package:google_fonts/google_fonts.dart';
// export 'home_body.dart';

// class HomeIcon extends StatelessWidget {
//   const HomeIcon({
//     Key? key,
//     required this.badgeNumber,
//     required this.homeItem,
//     this.isEnabled = true,
//   }) : super(key: key);

//   final int badgeNumber;
//   final HomeItemType homeItem;
//   final bool isEnabled;

//   @override
//   Widget build(BuildContext context) {
//     var language = AppLocalizations.of(context);
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         TextButton(
//           onPressed: () {
//             if (!isEnabled) return;
//             ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
//             switch (homeItem) {
//               case HomeItemType.incidents:
//                 developer.log('Incident Pressed');
//                 Navigator.pushNamed(context, RouteConstants.incidentsPage,
//                     arguments: IncidentsPageArgument(
//                       false,
//                     ));
//                 break;
//               case HomeItemType.pingMessages:
//                 developer.log('Pings Pressed');
//                 Navigator.pushNamed(context, RouteConstants.pingListPage);
//                 break;
//               case HomeItemType.emergency:
//                 developer.log('SOS tapped');
//                 showDialog(
//                   context: context,
//                   builder: (context) => StatefulBuilder(
//                     builder: (context, setState) {
//                       bool phoneSelected = false;
//                       bool textSelected = false;

//                       return CustomDialogWidget(
//                         phoneSelected: phoneSelected,
//                         textSelected: textSelected,
//                         onPhoneSelected: () {
//                           setState(() {
//                             phoneSelected = !phoneSelected;
//                             if (phoneSelected) textSelected = false;
//                           });
//                         },
//                         onTextSelected: () {
//                           setState(() {
//                             textSelected = !textSelected;
//                             if (textSelected) phoneSelected = false;
//                           });
//                         },
//                         onSubmit: () {
//                           developer.log('Submit Pressed');
//                           developer.log('Phone Selected: $phoneSelected');
//                           developer.log('Text Selected: $textSelected');
//                           Navigator.of(context).pop();
//                         },
//                       );
//                     },
//                   ),
//                 );
//                 break;
//               case HomeItemType.tasks:
//                 developer.log('Tasks tapped');
//                 Navigator.pushNamed(
//                   context,
//                   RouteConstants.webViewPage,
//                   arguments: WebViewPageArguments(
//                       RepositoryProvider.of<CrisesControlCoreRepository>(
//                                   context)
//                               .retrieveHomeData()
//                               ?.data
//                               .myTaskUrl ??
//                           CrisesControlUrls.portal,
//                       language!.label_tasks),
//                 );
//                 break;
//               case HomeItemType.chat:
//                 developer.log('chat tapped');
//                 break;
//               case HomeItemType.analytics:
//                 developer.log('chat tapped');
//                 break;
//             }
//           },
//           child: badges.Badge(
//             showBadge: badgeNumber >= 1,
//             badgeContent: Text(
//               badgeNumber.toString(),
//               style: const TextStyle(
//                 color: Colors.white,
//               ),
//             ),
//             child: Container(
//               width: MediaQuery.of(context).size.width / 2.5,
//               height: MediaQuery.of(context).size.height / 5.5,
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(18),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.grey.shade600.withOpacity(0.5),
//                     spreadRadius: 2,
//                     blurRadius: 12,
//                     offset: const Offset(-2, 2), // changes position of shadow
//                   ),
//                 ],
//               ),
//               child: Center(
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Icon(
//                       HomeItemHelper.getIconData(homeItem),
//                       color: Palette.primary,
//                       size: 60,
//                     ),
//                     const SizedBox(height: 10),
//                     Text(
//                       HomeItemHelper.getText(homeItem, context),
//                       textAlign: TextAlign.center,
//                       style: TextStyle(
//                         fontWeight: FontWeight.w600,
//                         fontSize: 18,
//                         color: Colors.grey.shade700,
//                       ),
//                     )
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }

// class CustomDialogWidget extends StatelessWidget {
//   const CustomDialogWidget({
//     Key? key,
//     required this.phoneSelected,
//     required this.textSelected,
//     required this.onPhoneSelected,
//     required this.onTextSelected,
//     required this.onSubmit,
//   }) : super(key: key);

//   final bool phoneSelected;
//   final bool textSelected;
//   final VoidCallback onPhoneSelected;
//   final VoidCallback onTextSelected;
//   final VoidCallback onSubmit;

//   @override
//   Widget build(BuildContext context) {
//     var language = AppLocalizations.of(context);
//     return BackdropFilter(
//       filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
//       child: Dialog(
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(12),
//         ),
//         child: Container(
//           padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
//           decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.circular(12),
//           ),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               const Padding(
//                 padding: EdgeInsets.only(top: 16, bottom: 24),
//                 child: Image(
//                   image: AssetImage('assets/images/sos_img.png'),
//                   width: 95,
//                 ),
//               ),
//               Text(
//                 language!.alert_title_sos,
//                 style: GoogleFonts.urbanist(
//                   fontSize: 22,
//                   fontWeight: FontWeight.w700,
//                 ),
//               ),
//               const SizedBox(
//                 height: 8,
//               ),
//               Text(
//                 language.alert_sos_message,
//                 textAlign: TextAlign.center,
//                 style: GoogleFonts.urbanist(
//                   fontSize: 16,
//                   fontWeight: FontWeight.w500,
//                   color: const Color(0xff0B223C),
//                 ),
//               ),
//               const SizedBox(height: 32),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: [
//                   _buildContactOption(
//                     context,
//                     'assets/images/mobile.png', // Replace with your mobile image asset
//                     'Mobile',
//                     isSelected: phoneSelected,
//                     onPressed: onPhoneSelected,
//                   ),
//                   _buildContactOption(
//                     context,
//                     'assets/images/email.png', // Replace with your email image asset
//                     'Email Alert',
//                     isSelected: textSelected,
//                     onPressed: onTextSelected,
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 32),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Expanded(
//                     child: OutlinedButton(
//                       style: OutlinedButton.styleFrom(
//                         padding: const EdgeInsets.symmetric(
//                           vertical: 12,
//                         ),
//                         foregroundColor: const Color(0xff1E60AA),
//                         side: const BorderSide(
//                           color: Color(0xff1E60AA),
//                         ),
//                       ),
//                       onPressed: () {
//                         Navigator.of(context).pop();
//                       },
//                       child: Text(language.cancel.toUpperCase()),
//                     ),
//                   ),
//                   const SizedBox(width: 16),
//                   Expanded(
//                     child: ElevatedButton(
//                       style: ElevatedButton.styleFrom(
//                         padding: const EdgeInsets.symmetric(
//                           vertical: 12,
//                         ),
//                         backgroundColor: const Color(0xff1E60AA),
//                         foregroundColor: Colors.white,
//                       ),
//                       onPressed: onSubmit,
//                       child: Text(language.btn_submit.toUpperCase()),
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildContactOption(
//       BuildContext context, String imagePath, String label,
//       {required bool isSelected, VoidCallback? onPressed}) {
//     return GestureDetector(
//       onTap: onPressed,
//       child: Container(
//         width: 100,
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(8),
//           border: Border.all(
//             color: isSelected ? Colors.blue : Colors.grey.withOpacity(0.5),
//             width: 1,
//           ),
//         ),
//         padding: const EdgeInsets.symmetric(
//             vertical: 8), // Horizontal and vertical padding within the border
//         child: Container(
//           padding: const EdgeInsets.symmetric(
//               vertical: 8), // Additional vertical padding for the content
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Image.asset(
//                 imagePath,
//                 width: 50,
//                 height: 50,
//               ),
//               const SizedBox(height: 8),
//               Text(
//                 label,
//                 style: GoogleFonts.urbanist(
//                   fontSize: 16,
//                   fontWeight: FontWeight.w600,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
// ********************

// import 'dart:developer' as developer;
// import 'dart:ui';
// import 'package:crises_control/src/core/constants.dart';
// import 'package:crises_control/src/core/presentation/styles/text/material_colors_helper.dart';
// import 'package:crises_control/src/core/repository/crises_control_core_repository.dart';
// import 'package:crises_control/src/core/router/page_arguments/page_arguments.dart';
// import 'package:crises_control/src/core/router/route_constants.dart';
// import 'package:crises_control/src/home/models/home_item.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';
// import 'package:badges/badges.dart' as badges;
// import 'package:google_fonts/google_fonts.dart';
// export 'home_body.dart';

// class HomeIcon extends StatelessWidget {
//   const HomeIcon({
//     Key? key,
//     required this.badgeNumber,
//     required this.homeItem,
//     this.isEnabled = true,
//   }) : super(key: key);

//   final int badgeNumber;
//   final HomeItemType homeItem;
//   final bool isEnabled;

//   @override
//   Widget build(BuildContext context) {
//     var language = AppLocalizations.of(context);
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         TextButton(
//           onPressed: () {
//             if (!isEnabled) return;
//             ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
//             switch (homeItem) {
//               case HomeItemType.incidents:
//                 developer.log('Incident Pressed');
//                 Navigator.pushNamed(context, RouteConstants.incidentsPage,
//                     arguments: IncidentsPageArgument(
//                       false,
//                     ));
//                 break;
//               case HomeItemType.pingMessages:
//                 developer.log('Pings Pressed');
//                 Navigator.pushNamed(context, RouteConstants.pingListPage);
//                 break;
//               case HomeItemType.emergency:
//                 developer.log('SOS tapped');
//                 showDialog(
//                   context: context,
//                   builder: (context) => StatefulBuilder(
//                     builder: (context, setState) {
//                       bool phoneSelected = false;
//                       bool textSelected = false;

//                       return CustomDialogWidget(
//                         phoneSelected: phoneSelected,
//                         textSelected: textSelected,
//                         onPhoneSelected: () {
//                           setState(() {
//                             phoneSelected = !phoneSelected;
//                             if (phoneSelected) textSelected = false;
//                           });
//                         },
//                         onTextSelected: () {
//                           setState(() {
//                             textSelected = !textSelected;
//                             if (textSelected) phoneSelected = false;
//                           });
//                         },
//                         onSubmit: () {
//                           developer.log('Submit Pressed');
//                           developer.log('Phone Selected: $phoneSelected');
//                           developer.log('Text Selected: $textSelected');
//                           Navigator.of(context).pop();
//                         },
//                       );
//                     },
//                   ),
//                 );
//                 break;
//               case HomeItemType.tasks:
//                 developer.log('Tasks tapped');
//                 Navigator.pushNamed(
//                   context,
//                   RouteConstants.webViewPage,
//                   arguments: WebViewPageArguments(
//                       RepositoryProvider.of<CrisesControlCoreRepository>(
//                                   context)
//                               .retrieveHomeData()
//                               ?.data
//                               .myTaskUrl ??
//                           CrisesControlUrls.portal,
//                       language!.label_tasks),
//                 );
//                 break;
//               case HomeItemType.chat:
//                 developer.log('chat tapped');
//                 break;
//               case HomeItemType.analytics:
//                 developer.log('chat tapped');
//                 break;
//             }
//           },
//           child: badges.Badge(
//             showBadge: badgeNumber >= 1,
//             badgeContent: Text(
//               badgeNumber.toString(),
//               style: const TextStyle(
//                 color: Colors.white,
//               ),
//             ),
//             child: Container(
//               width: MediaQuery.of(context).size.width / 2.5,
//               height: MediaQuery.of(context).size.height / 5.5,
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(18),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.grey.shade600.withOpacity(0.5),
//                     spreadRadius: 2,
//                     blurRadius: 12,
//                     offset: const Offset(-2, 2), // changes position of shadow
//                   ),
//                 ],
//               ),
//               child: Center(
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Icon(
//                       HomeItemHelper.getIconData(homeItem),
//                       color: Palette.primary,
//                       size: 60,
//                     ),
//                     const SizedBox(height: 10),
//                     Text(
//                       HomeItemHelper.getText(homeItem, context),
//                       textAlign: TextAlign.center,
//                       style: TextStyle(
//                         fontWeight: FontWeight.w600,
//                         fontSize: 18,
//                         color: Colors.grey.shade700,
//                       ),
//                     )
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }

// class CustomDialogWidget extends StatelessWidget {
//   const CustomDialogWidget({
//     Key? key,
//     required this.phoneSelected,
//     required this.textSelected,
//     required this.onPhoneSelected,
//     required this.onTextSelected,
//     required this.onSubmit,
//   }) : super(key: key);

//   final bool phoneSelected;
//   final bool textSelected;
//   final VoidCallback onPhoneSelected;
//   final VoidCallback onTextSelected;
//   final VoidCallback onSubmit;

//   @override
//   Widget build(BuildContext context) {
//     var language = AppLocalizations.of(context);
//     return BackdropFilter(
//       filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
//       child: Dialog(
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(12),
//         ),
//         child: Container(
//           padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
//           decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.circular(12),
//           ),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               const Padding(
//                 padding: EdgeInsets.only(top: 16, bottom: 24),
//                 child: Image(
//                   image: AssetImage('assets/images/sos_img.png'),
//                   width: 95,
//                 ),
//               ),
//               Text(
//                 language!.alert_title_sos,
//                 style: GoogleFonts.urbanist(
//                   fontSize: 22,
//                   fontWeight: FontWeight.w700,
//                 ),
//               ),
//               const SizedBox(
//                 height: 8,
//               ),
//               Text(
//                 language.alert_sos_message,
//                 textAlign: TextAlign.center,
//                 style: GoogleFonts.urbanist(
//                   fontSize: 16,
//                   fontWeight: FontWeight.w500,
//                   color: const Color(0xff0B223C),
//                 ),
//               ),
//               const SizedBox(height: 32),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: [
//                   _buildContactOption(
//                     context,
//                     'assets/images/mobile.png', // Replace with your mobile image asset
//                     'Mobile',
//                     isSelected: phoneSelected,
//                     onPressed: onPhoneSelected,
//                   ),
//                   _buildContactOption(
//                     context,
//                     'assets/images/email.png', // Replace with your email image asset
//                     'Email Alert',
//                     isSelected: textSelected,
//                     onPressed: onTextSelected,
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 32),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Expanded(
//                     child: OutlinedButton(
//                       style: OutlinedButton.styleFrom(
//                         padding: const EdgeInsets.symmetric(
//                           vertical: 12,
//                         ),
//                         foregroundColor: const Color(0xff1E60AA),
//                         side: const BorderSide(
//                           color: Color(0xff1E60AA),
//                         ),
//                       ),
//                       onPressed: () {
//                         Navigator.of(context).pop();
//                       },
//                       child: Text(language.cancel.toUpperCase()),
//                     ),
//                   ),
//                   const SizedBox(width: 16),
//                   Expanded(
//                     child: ElevatedButton(
//                       style: ElevatedButton.styleFrom(
//                         padding: const EdgeInsets.symmetric(
//                           vertical: 12,
//                         ),
//                         backgroundColor: const Color(0xff1E60AA),
//                         foregroundColor: Colors.white,
//                       ),
//                       onPressed: onSubmit,
//                       child: Text(language.btn_submit.toUpperCase()),
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildContactOption(
//       BuildContext context, String imagePath, String label,
//       {required bool isSelected, VoidCallback? onPressed}) {
//     return GestureDetector(
//       onTap: onPressed,
//       child: Container(
//         width: 100,
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(8),
//           border: Border.all(
//             color: isSelected ? Colors.blue : Colors.grey.withOpacity(0.5),
//             width: 1,
//           ),
//         ),
//         padding: const EdgeInsets.symmetric(
//             vertical: 8), // Horizontal and vertical padding within the border
//         child: Container(
//           padding: const EdgeInsets.symmetric(
//               vertical: 8), // Additional vertical padding for the content
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Image.asset(
//                 imagePath,
//                 width: 50,
//                 height: 50,
//               ),
//               const SizedBox(height: 8),
//               Text(
//                 label,
//                 style: GoogleFonts.urbanist(
//                   fontSize: 16,
//                   fontWeight: FontWeight.w600,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
// ******************

// import 'dart:developer' as developer;
// import 'dart:ui';
// import 'package:crises_control/src/core/constants.dart';
// import 'package:crises_control/src/core/presentation/styles/text/material_colors_helper.dart';
// import 'package:crises_control/src/core/repository/crises_control_core_repository.dart';
// import 'package:crises_control/src/core/router/page_arguments/page_arguments.dart';
// import 'package:crises_control/src/core/router/route_constants.dart';
// import 'package:crises_control/src/home/models/home_item.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';
// import 'package:badges/badges.dart' as badges;
// import 'package:google_fonts/google_fonts.dart';
// export 'home_body.dart';

// class HomeIcon extends StatelessWidget {
//   const HomeIcon({
//     Key? key,
//     required this.badgeNumber,
//     required this.homeItem,
//     this.isEnabled = true,
//   }) : super(key: key);

//   final int badgeNumber;
//   final HomeItemType homeItem;
//   final bool isEnabled;

//   @override
//   Widget build(BuildContext context) {
//     var language = AppLocalizations.of(context);
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         TextButton(
//           onPressed: () {
//             if (!isEnabled) return;
//             ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
//             switch (homeItem) {
//               case HomeItemType.incidents:
//                 developer.log('Incident Pressed');
//                 Navigator.pushNamed(context, RouteConstants.incidentsPage,
//                     arguments: IncidentsPageArgument(
//                       false,
//                     ));
//                 break;
//               case HomeItemType.pingMessages:
//                 developer.log('Pings Pressed');
//                 Navigator.pushNamed(context, RouteConstants.pingListPage);
//                 break;
//               case HomeItemType.emergency:
//                 developer.log('SOS tapped');
//                 showDialog(
//                   context: context,
//                   builder: (context) {
//                     bool phoneSelected = false;
//                     bool textSelected = false;

//                     return StatefulBuilder(
//                       builder: (context, setState) {
//                         return CustomDialogWidget(
//                           phoneSelected: phoneSelected,
//                           textSelected: textSelected,
//                           onPhoneSelected: () {
//                             setState(() {
//                               phoneSelected = true;
//                               textSelected = false;
//                             });
//                           },
//                           onTextSelected: () {
//                             setState(() {
//                               textSelected = true;
//                               phoneSelected = false;
//                             });
//                           },
//                           onSubmit: () {
//                             developer.log('Submit Pressed');
//                             developer.log('Phone Selected: $phoneSelected');
//                             developer.log('Text Selected: $textSelected');
//                             Navigator.of(context).pop();
//                           },
//                         );
//                       },
//                     );
//                   },
//                 );
//                 break;
//               case HomeItemType.tasks:
//                 developer.log('Tasks tapped');
//                 Navigator.pushNamed(
//                   context,
//                   RouteConstants.webViewPage,
//                   arguments: WebViewPageArguments(
//                       RepositoryProvider.of<CrisesControlCoreRepository>(
//                                   context)
//                               .retrieveHomeData()
//                               ?.data
//                               .myTaskUrl ??
//                           CrisesControlUrls.portal,
//                       language!.label_tasks),
//                 );
//                 break;
//               case HomeItemType.chat:
//                 developer.log('chat tapped');
//                 break;
//               case HomeItemType.analytics:
//                 developer.log('chat tapped');
//                 break;
//             }
//           },
//           child: badges.Badge(
//             showBadge: badgeNumber >= 1,
//             badgeContent: Text(
//               badgeNumber.toString(),
//               style: const TextStyle(
//                 color: Colors.white,
//               ),
//             ),
//             child: Container(
//               width: MediaQuery.of(context).size.width / 2.5,
//               height: MediaQuery.of(context).size.height / 5.5,
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(18),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.grey.shade600.withOpacity(0.5),
//                     spreadRadius: 2,
//                     blurRadius: 12,
//                     offset: const Offset(-2, 2), // changes position of shadow
//                   ),
//                 ],
//               ),
//               child: Center(
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Icon(
//                       HomeItemHelper.getIconData(homeItem),
//                       color: Palette.primary,
//                       size: 60,
//                     ),
//                     const SizedBox(height: 10),
//                     Text(
//                       HomeItemHelper.getText(homeItem, context),
//                       textAlign: TextAlign.center,
//                       style: TextStyle(
//                         fontWeight: FontWeight.w600,
//                         fontSize: 18,
//                         color: Colors.grey.shade700,
//                       ),
//                     )
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }

// class CustomDialogWidget extends StatelessWidget {
//   const CustomDialogWidget({
//     Key? key,
//     required this.phoneSelected,
//     required this.textSelected,
//     required this.onPhoneSelected,
//     required this.onTextSelected,
//     required this.onSubmit,
//   }) : super(key: key);

//   final bool phoneSelected;
//   final bool textSelected;
//   final VoidCallback onPhoneSelected;
//   final VoidCallback onTextSelected;
//   final VoidCallback onSubmit;

//   @override
//   Widget build(BuildContext context) {
//     var language = AppLocalizations.of(context);
//     return BackdropFilter(
//       filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
//       child: Dialog(
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(12),
//         ),
//         child: Container(
//           padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
//           decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.circular(12),
//           ),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               const Padding(
//                 padding: EdgeInsets.only(top: 16, bottom: 24),
//                 child: Image(
//                   image: AssetImage('assets/images/sos_img.png'),
//                   width: 95,
//                 ),
//               ),
//               Text(
//                 language!.alert_title_sos,
//                 style: GoogleFonts.urbanist(
//                   fontSize: 22,
//                   fontWeight: FontWeight.w700,
//                 ),
//               ),
//               const SizedBox(
//                 height: 8,
//               ),
//               Text(
//                 language.alert_sos_message,
//                 textAlign: TextAlign.center,
//                 style: GoogleFonts.urbanist(
//                   fontSize: 16,
//                   fontWeight: FontWeight.w500,
//                   color: const Color(0xff0B223C),
//                 ),
//               ),
//               const SizedBox(height: 32),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: [
//                   _buildContactOption(
//                     context,
//                     'assets/images/mobile.png', // Replace with your mobile image asset
//                     'Mobile',
//                     isSelected: phoneSelected,
//                     onPressed: onPhoneSelected,
//                   ),
//                   _buildContactOption(
//                     context,
//                     'assets/images/email.png', // Replace with your email image asset
//                     'Email Alert',
//                     isSelected: textSelected,
//                     onPressed: onTextSelected,
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 32),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Expanded(
//                     child: OutlinedButton(
//                       style: OutlinedButton.styleFrom(
//                         padding: const EdgeInsets.symmetric(
//                           vertical: 12,
//                         ),
//                         foregroundColor: const Color(0xff1E60AA),
//                         side: const BorderSide(
//                           color: Color(0xff1E60AA),
//                         ),
//                       ),
//                       onPressed: () {
//                         Navigator.of(context).pop();
//                       },
//                       child: Text(language.cancel.toUpperCase()),
//                     ),
//                   ),
//                   const SizedBox(width: 16),
//                   Expanded(
//                     child: ElevatedButton(
//                       style: ElevatedButton.styleFrom(
//                         padding: const EdgeInsets.symmetric(
//                           vertical: 12,
//                         ),
//                         backgroundColor: const Color(0xff1E60AA),
//                         foregroundColor: Colors.white,
//                       ),
//                       onPressed: onSubmit,
//                       child: Text(language.btn_submit.toUpperCase()),
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildContactOption(
//       BuildContext context, String imagePath, String label,
//       {required bool isSelected, VoidCallback? onPressed}) {
//     return GestureDetector(
//       onTap: onPressed,
//       child: Container(
//         width: 100,
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(15),
//           border: Border.all(
//             color: isSelected ? Colors.blue : Colors.grey.withOpacity(0.5),
//             width: 1,
//           ),
//         ),
//         padding: const EdgeInsets.symmetric(
//             vertical: 10,
//             horizontal: 8), // Horizontal and vertical padding within the border
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Image.asset(
//               imagePath,
//               width: 70,
//               height: 70,
//             ),
//             const SizedBox(height: 10),
//             Text(
//               label,
//               style: GoogleFonts.urbanist(
//                 fontSize: 16,
//                 fontWeight: FontWeight.w600,
//                 color: isSelected ? Colors.blue : Colors.black,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//*********** */

import 'dart:developer' as developer;
import 'dart:ui';
import 'package:badges/badges.dart';
import 'package:crises_control/src/core/constants.dart';
import 'package:crises_control/src/core/presentation/styles/text/material_colors_helper.dart';
import 'package:crises_control/src/core/repository/crises_control_core_repository.dart';
import 'package:crises_control/src/core/router/page_arguments/page_arguments.dart';
import 'package:crises_control/src/core/router/route_constants.dart';
import 'package:crises_control/src/home/models/home_item.dart';
import 'package:crises_control/src/home/widgets/select_sos.dart';
import 'package:crises_control/src/theme/theme_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:badges/badges.dart' as badges;
import 'package:google_fonts/google_fonts.dart';
export 'home_body.dart';
//import 'package:crises_control/src/config/plette.dart';

class HomeIcon extends StatelessWidget {
  const HomeIcon({
    Key? key,
    required this.badgeNumber,
    required this.homeItem,
    this.isEnabled = true,
  }) : super(key: key);

  final int badgeNumber;
  final HomeItemType homeItem;
  final bool isEnabled;

  @override
  Widget build(BuildContext context) {
    var language = AppLocalizations.of(context);
    int badgeCount = 0;
    int badgeCountTwo = 0;
    return Padding(
      padding: const EdgeInsets.only(top: 30, left: 0, right: 0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextButton(
            onPressed: () {
              if (!isEnabled) return;
              ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
              switch (homeItem) {
                case HomeItemType.incidents:
                  developer.log('Incident Pressed');
                  Navigator.pushNamed(context, RouteConstants.incidentsPage,
                      arguments: IncidentsPageArgument(
                        false,
                      ));
                  break;
                case HomeItemType.pingMessages:
                  developer.log('Pings Pressed');
                  Navigator.pushNamed(context, RouteConstants.pingListPage);
                  break;
                case HomeItemType.emergency:
                  developer.log('SOS tapped');
                  showDialog(
                    context: context,
                    builder: (context) {
                      bool phoneSelected = false;
                      bool textSelected = false;

                      return StatefulBuilder(
                        builder: (context, setState) {
                          return CustomDialogWidget(
                            phoneSelected: phoneSelected,
                            textSelected: textSelected,
                            onPhoneSelected: () {
                              setState(() {
                                phoneSelected = true;
                                textSelected = false;
                              });
                            },
                            onTextSelected: () {
                              setState(() {
                                textSelected = true;
                                phoneSelected = false;
                              });
                            },
                            onSubmit: () {
                              developer.log('Submit Pressed');
                              developer.log('Phone Selected: $phoneSelected');
                              developer.log('Text Selected: $textSelected');
                              Navigator.of(context).pop();
                            },
                          );
                        },
                      );
                    },
                  );
                  break;
                case HomeItemType.tasks:
                  developer.log('Tasks tapped');
                  Navigator.pushNamed(
                    context,
                    RouteConstants.webViewPage,
                    arguments: WebViewPageArguments(
                        RepositoryProvider.of<CrisesControlCoreRepository>(
                                    context)
                                .retrieveHomeData()
                                ?.data
                                .myTaskUrl ??
                            CrisesControlUrls.portal,
                        language!.label_tasks),
                  );
                  break;
                // case HomeItemType.chat:
                //   developer.log('chat tapped');
                //   break;
                // case HomeItemType.analytics:
                //   developer.log('chat tapped');
                //   break;
              }
            },
            child: badges.Badge(
              showBadge: badgeNumber >= 1,
              position: BadgePosition.topEnd(top: 8, end: 35),
              badgeContent: Text(
                badgeNumber.toString(),
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 2),
                child: Container(
                  width: 152,
                  height: 165,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(18),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade600.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 12,
                        offset:
                            const Offset(-2, 2), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Icon(
                        //   HomeItemHelper.getIconData(homeItem),
                        //   color: Palette.primary,
                        //   size: 60,
                        // ),
                        HomeItemHelper.getIconData(homeItem),
                        const SizedBox(height: 5),
                        Text(
                          HomeItemHelper.getText(homeItem, context),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                            color: Colors.grey.shade700,
                          ),
                        ),
                        Text(
                          "view",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                            color: Colors.blue.shade700,
                          ),
                        )
                      ],
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

class CustomDialogWidget extends StatelessWidget {
  const CustomDialogWidget({
    Key? key,
    required this.phoneSelected,
    required this.textSelected,
    required this.onPhoneSelected,
    required this.onTextSelected,
    required this.onSubmit,
  }) : super(key: key);

  final bool phoneSelected;
  final bool textSelected;
  final VoidCallback onPhoneSelected;
  final VoidCallback onTextSelected;
  final VoidCallback onSubmit;

  @override
  Widget build(BuildContext context) {
    var language = AppLocalizations.of(context);
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
      child: Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 10, bottom: 5),
                child: Image(
                  image: AssetImage('assets/images/sos_img.png'),
                  width: 90,
                ),
              ),
              Text(
                language!.alert_title_sos,
                style: GoogleFonts.urbanist(
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                language.alert_sos_message,
                textAlign: TextAlign.center,
                style: GoogleFonts.urbanist(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xff0B223C),
                ),
              ),
              const SizedBox(height: 32),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Expanded(
                  //   child: Padding(
                  //     padding: const EdgeInsets.only(right: 8),
                  //     child: _buildContactOption(
                  //       context,
                  //       'assets/images/mobile.png', // Replace with your mobile image asset
                  //       'Mobile',
                  //       isSelected: phoneSelected,
                  //       onPressed: onPhoneSelected,
                  //     ),
                  //   ),
                  // ),
                  // Expanded(
                  //   child: Padding(
                  //     padding: const EdgeInsets.only(left: 8),
                  //     child: _buildContactOption(
                  //       context,
                  //       'assets/images/email.png', // Replace with your email image asset
                  //       'Email Alert',
                  //       isSelected: textSelected,
                  //       onPressed: onTextSelected,
                  //     ),
                  //   ),
                  // ),

                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        CustomCheckboxWithText(
                          isChecked: true,
                          isEnabled: false,
                          onChanged: (bool value) {
                            // Handle checkbox state change
                          },
                          beforeText: 'Phone',
                          // afterText: 'Text',
                        ),
                        SizedBox(height: 20), // Add space between examples
                        CustomCheckboxWithText(
                          isChecked: false,
                          isEnabled: false,
                          onChanged: (bool value) {
                            // Handle checkbox state change
                          },
                          beforeText: 'Text',
                          // afterText: 'After',
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        backgroundColor:
                            Color(0xffDDE6EC), // Set grey background color
                        foregroundColor:
                            Color(0xff3A3A3A), // Set text color to white
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(13),
                        ),
                        side: BorderSide(
                          color: Color(0xffDDE6EC),
                        ),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text(language.cancel.toUpperCase(),
                          style: GoogleFonts.roboto(
                              fontSize: 16, fontWeight: FontWeight.w700)),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        backgroundColor: const Color(0xff2175D4),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(13),
                        ),
                      ),
                      // onPressed: onSubmit,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SelectSOSPage(),
                          ),
                        );
                      },
                      child: Text(
                        language.ok.toUpperCase(),
                        style: GoogleFonts.roboto(
                            fontSize: 16, fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContactOption(
      BuildContext context, String imagePath, String label,
      {required bool isSelected, VoidCallback? onPressed}) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: isSelected ? Colors.blue : Colors.grey.withOpacity(0.5),
            width: 1,
          ),
        ),
        padding: const EdgeInsets.symmetric(
            vertical: 20), // Horizontal and vertical padding within the border
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              imagePath,
              width: 80,
              height: 80,
            ),
            const SizedBox(height: 8),
            Text(
              label,
              style: GoogleFonts.urbanist(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: isSelected ? Colors.blue : Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomCheckboxWithText extends StatefulWidget {
  final bool isChecked;
  final bool isEnabled;
  final ValueChanged<bool> onChanged;
  final String beforeText;
  // final String afterText;

  CustomCheckboxWithText({
    required this.isChecked,
    required this.onChanged,
    required this.beforeText,
    required this.isEnabled,
    // required this.afterText,
  });

  @override
  _CustomCheckboxWithTextState createState() => _CustomCheckboxWithTextState();
}

class _CustomCheckboxWithTextState extends State<CustomCheckboxWithText> {
  late bool _isChecked;

  @override
  void initState() {
    super.initState();
    _isChecked = widget.isChecked;
  }

  void _toggleCheckbox() {
    setState(() {
      _isChecked = !_isChecked;
    });
    widget.onChanged(_isChecked);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _toggleCheckbox,
      child: Padding(
        padding: const EdgeInsets.only(right: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: Text(
                widget.beforeText,
                style: GoogleFonts.roboto(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Color(0xff3A3A3A),
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.blue, width: 2),
                borderRadius: BorderRadius.circular(8),
                color: widget.isEnabled ? Colors.white : Colors.white,
              ),
              child: _isChecked
                  ? Icon(
                      Icons.check_box,
                      color: Colors.blue,
                      size: 30,
                    )
                  : Icon(
                      Icons.check_box_outline_blank,
                      color: Colors.white,
                      size: 30,
                    ),
            ),
            // Text(widget.afterText),
          ],
        ),
      ),
    );
  }
}
