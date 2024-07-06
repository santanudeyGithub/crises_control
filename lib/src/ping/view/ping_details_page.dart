// // ignore_for_file: use_super_parameters

// import 'package:crises_control/src/core/models/communication_models/company_comms_response.dart';
// import 'package:crises_control/src/core/models/communication_models/selected_communication.dart';
// import 'package:crises_control/src/core/presentation/pages/message_replies_page.dart';
// import 'package:crises_control/src/core/presentation/styles/text/material_colors_helper.dart';
// import 'package:crises_control/src/core/presentation/widgets/cc_text_field.dart';
// import 'package:crises_control/src/core/presentation/widgets/menu_widgets.dart';
// import 'package:crises_control/src/core/router/page_arguments/page_arguments.dart';
// import 'package:crises_control/src/core/router/route_constants.dart';
// import 'package:crises_control/src/core/utils/common.dart';
// import 'package:crises_control/src/core/utils/enum_helpers.dart';
// import 'package:crises_control/src/ping/cubit/ping_details/ping_details_cubit.dart';
// import 'package:crises_control/src/ping/models/ping.dart';
// import 'package:crises_control/src/ping/repository/ping_repository.dart';
// import 'package:crises_control/src/ping/widgets/ping_details_body.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';

// /// A description for PingPage
// class PingDetailsPage extends StatefulWidget {
//   const PingDetailsPage({super.key, required this.selectedPing});
//   final PingData selectedPing;

//   @override
//   State<PingDetailsPage> createState() => _PingDetailsPageState();
// }

// class _PingDetailsPageState extends State<PingDetailsPage> {
//   /// The static route for PingPage
//   Route<dynamic> route() {
//     return MaterialPageRoute<dynamic>(
//       builder: (_) => PingDetailsPage(
//         selectedPing: widget.selectedPing,
//       ),
//     );
//   }

//   @override
//   void initState() {
//     super.initState();
//   }

//   final TextEditingController textEditingController = TextEditingController();
//   List<SelectedCommunication> selectedCommunicationPreferences = [];
//   List<MessageMethod> communicationMethods = [];

//   @override
//   Widget build(BuildContext context) {
//     var language = AppLocalizations.of(context);
//     return BlocListener<PingDetailsCubit, PingDetailsState>(
//       listener: (context, state) {
//         if (state is PingDetailsCommunicationMethodsLoaded) {
//           selectedCommunicationPreferences = state.communicationMethods;
//         }
//       },
//       child: BlocListener<PingDetailsCubit, PingDetailsState>(
//         listener: (context, state) {
//           if (state is PingDetailsCommunicationMethodsLoaded) {
//             selectedCommunicationPreferences = state.communicationMethods;
//             communicationMethods = state.allCommunicationMethods;
//           }
//         },
//         child: Scaffold(
//           appBar: AppBar(
//             title: Text(
//               widget.selectedPing.hasReplies
//                   ? language!.title_message_replies
//                   : language!.bottom_bar_ping_msg,
//             ),
//             actions: [
//               IconButton(
//                 onPressed: (() {
//                   showModalBottomSheet<void>(
//                     context: context,
//                     builder: (buildContext) {
//                       return ListView(
//                         shrinkWrap: true,
//                         children: [
//                           MessageActionTile(
//                             icon: EnumHelpers.replyTypeToIcon(ReplyType.sender),
//                             title: EnumHelpers.replyTypeToString(
//                               ReplyType.sender,
//                               context,
//                             ),
//                             isVisible: true,
//                             onPressed: () async =>
//                                 await replyDialog(context, ReplyType.sender),
//                           ),
//                           MessageActionTile(
//                             icon: EnumHelpers.replyTypeToIcon(ReplyType.all),
//                             title: EnumHelpers.replyTypeToString(
//                               ReplyType.all,
//                               context,
//                             ),
//                             isVisible: true,
//                             onPressed: () async =>
//                                 await replyDialog(context, ReplyType.all),
//                           ),
//                           MessageActionTile(
//                             icon:
//                                 EnumHelpers.replyTypeToIcon(ReplyType.renotify),
//                             title: EnumHelpers.replyTypeToString(
//                               ReplyType.renotify,
//                               context,
//                             ),
//                             isVisible: widget.selectedPing.isAcknowledgedByAll,
//                             onPressed: () async =>
//                                 replyDialog(context, ReplyType.renotify),
//                           ),
//                           MessageActionTile(
//                             icon: Icons.people,
//                             title: language.title_ack_msg_status,
//                             isVisible: true,
//                             onPressed: () => Navigator.pushNamed(
//                               context,
//                               RouteConstants.messageRecipientsPage,
//                               arguments: MessageRecipientsListPageArguments(
//                                 widget.selectedPing.messageId,
//                               ),
//                             ),
//                           ),
//                         ],
//                       );
//                     },
//                   );
//                 }),
//                 icon: const Icon(Icons.more_horiz),
//               )
//             ],
//           ),
//           floatingActionButtonLocation:
//               FloatingActionButtonLocation.centerFloat,
//           floatingActionButton: FloatingAcknowledgedButton(
//               onPressed: () => context
//                   .read<PingDetailsCubit>()
//                   .acknowledgePing(ping: widget.selectedPing)),
//           body: widget.selectedPing.hasReplies
//               ? MessageRepliesBody()
//               : PingDetailsBody(
//                   selectedPing: widget.selectedPing,
//                 ),
//         ),
//       ),
//     );
//   }

//   replyDialog(BuildContext context, ReplyType replyTo) {
//     var language = AppLocalizations.of(context);
//     var title = replyTo == ReplyType.all
//         ? language!.label_replyall
//         : language!.label_reply;

//     return showDialog(
//       context: context,
//       builder: (buildContext) {
//         return StatefulBuilder(
//           builder: (BuildContext _, void Function(void Function()) setState) {
//             return SimpleDialog(
//               title: Text(title),
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: MessageTextField(
//                     textEditingController: textEditingController,
//                     type: MessageTextFieldType.reply,
//                   ),
//                 ),
//                 ListTile(
//                   title: Text(language.label_communication_messages),
//                   leading: const Icon(Icons.podcasts),
//                   subtitle: Text(
//                     ListHelpers.selectedMessageMethodListToString(
//                       selectedCommunicationPreferences,
//                     ),
//                     style: TextStyle(color: Colors.grey.shade800),
//                   ),
//                   iconColor: Palette.primary,
//                   onTap: () async {
//                     final result = await _onCommunicationChannels(
//                       context,
//                       selectedCommunicationPreferences,
//                       communicationMethods,
//                     );
//                     setState(() {
//                       selectedCommunicationPreferences = result;
//                     });
//                   },
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   children: [
//                     TextButton(
//                       onPressed: (() {
//                         Navigator.pop(context);
//                       }),
//                       child: Text(language.cancel),
//                     ),
//                     TextButton(
//                       onPressed: (() {
//                         Navigator.pop(context);
//                         if (replyTo == ReplyType.renotify) {
//                           context
//                               .read<PingDetailsCubit>()
//                               .renotifyUnacknowledged(
//                                 message: textEditingController.text,
//                                 ping: widget.selectedPing,
//                                 cascadingPlanId: 0,
//                                 messageMethods: selectedCommunicationPreferences
//                                     .map((e) => e.id)
//                                     .toList(),
//                               );
//                         } else {
//                           context.read<PingDetailsCubit>().replyToPing(
//                                 message: textEditingController.text,
//                                 ping: widget.selectedPing,
//                                 messageMethods: selectedCommunicationPreferences
//                                     .map((e) => e.id)
//                                     .toList(),
//                                 replyTo: ReplyType.sender,
//                               );
//                         }
//                       }),
//                       child: Text(language.ok),
//                     )
//                   ],
//                 ),
//               ],
//             );
//           },
//         );
//       },
//     );
//   }

//   Future<List<SelectedCommunication>> _onCommunicationChannels(
//     BuildContext context,
//     List<SelectedCommunication> selectedCommunicationPreferences,
//     List<MessageMethod> allCommunicationPreferences,
//   ) async {
//     final result = await Navigator.pushNamed(
//       context,
//       RouteConstants.communicationPrefencesListPage,
//       arguments: CommunicationPrefencesListPageArguments(
//         allCommunicationPreferences,
//         selectedCommunicationPreferences,
//         [],
//       ),
//     ) as List<SelectedCommunication>;
//     return result;
//   }
// }

// class MessageActionTile extends StatelessWidget {
//   const MessageActionTile({
//     Key? key,
//     required this.icon,
//     required this.title,
//     required this.isVisible,
//     required this.onPressed,
//   }) : super(key: key);
//   final IconData icon;
//   final String title;
//   final bool isVisible;
//   final VoidCallback onPressed;

//   @override
//   Widget build(BuildContext context) {
//     return Visibility(
//       visible: isVisible,
//       child: ListTile(
//         leading: Icon(icon),
//         title: Text(title),
//         iconColor: Palette.primary,
//         onTap: onPressed,
//       ),
//     );
//   }
// }
// *******************************/
import 'dart:ui';

import 'package:crises_control/src/ping/view/replydialog_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:crises_control/src/core/models/communication_models/company_comms_response.dart';
import 'package:crises_control/src/core/models/communication_models/selected_communication.dart';
import 'package:crises_control/src/core/presentation/pages/message_replies_page.dart';
import 'package:crises_control/src/core/presentation/styles/text/material_colors_helper.dart';
import 'package:crises_control/src/core/presentation/widgets/cc_text_field.dart';
import 'package:crises_control/src/core/presentation/widgets/menu_widgets.dart';
import 'package:crises_control/src/core/router/page_arguments/page_arguments.dart';
import 'package:crises_control/src/core/router/route_constants.dart';
import 'package:crises_control/src/core/utils/common.dart';
import 'package:crises_control/src/core/utils/enum_helpers.dart';
import 'package:crises_control/src/ping/cubit/ping_details/ping_details_cubit.dart';
import 'package:crises_control/src/ping/models/ping.dart';
import 'package:crises_control/src/ping/repository/ping_repository.dart';
import 'package:crises_control/src/ping/widgets/ping_details_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/svg.dart';

class PingDetailsPage extends StatefulWidget {
  const PingDetailsPage({super.key, required this.selectedPing});
  final PingData selectedPing;

  @override
  State<PingDetailsPage> createState() => _PingDetailsPageState();
}

class _PingDetailsPageState extends State<PingDetailsPage> {
  final TextEditingController textEditingController = TextEditingController();
  List<SelectedCommunication> selectedCommunicationPreferences = [];
  List<MessageMethod> communicationMethods = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var language = AppLocalizations.of(context);
    return BlocListener<PingDetailsCubit, PingDetailsState>(
      listener: (context, state) {
        if (state is PingDetailsCommunicationMethodsLoaded) {
          selectedCommunicationPreferences = state.communicationMethods;
        }
      },
      child: BlocListener<PingDetailsCubit, PingDetailsState>(
        listener: (context, state) {
          if (state is PingDetailsCommunicationMethodsLoaded) {
            selectedCommunicationPreferences = state.communicationMethods;
            communicationMethods = state.allCommunicationMethods;
          }
        },
        child: Scaffold(
          body: Stack(
            children: [
              Container(
                //height: kToolbarHeight + MediaQuery.of(context).padding.top,
                height: 300,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                        'assets/images/img_group_10.png'), // Replace with your image path
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Scaffold(
                backgroundColor:
                    Colors.transparent, // Make scaffold transparent
                appBar: AppBar(
                  iconTheme: IconThemeData(color: Colors.white),
                  backgroundColor:
                      Colors.transparent, // Make AppBar transparent
                  elevation: 0,
                  title: Text(
                      widget.selectedPing.hasReplies
                          ? language!.title_message_replies
                          : language!.bottom_bar_ping_msg,
                      style: TextStyle(color: Colors.white)),
                  // actions: [
                  //   IconButton(
                  //     onPressed: (() {
                  //       showModalBottomSheet<void>(
                  //         context: context,
                  //         builder: (buildContext) {
                  //           return ListView(
                  //             shrinkWrap: true,
                  //             children: [
                  //               MessageActionTile(
                  //                 icon: EnumHelpers.replyTypeToIcon(
                  //                     ReplyType.sender),
                  //                 title: EnumHelpers.replyTypeToString(
                  //                   ReplyType.sender,
                  //                   context,
                  //                 ),
                  //                 isVisible: true,
                  //                 onPressed: () async => await replyDialog(
                  //                     context, ReplyType.sender),
                  //               ),
                  //               MessageActionTile(
                  //                 icon: EnumHelpers.replyTypeToIcon(
                  //                     ReplyType.all),
                  //                 title: EnumHelpers.replyTypeToString(
                  //                   ReplyType.all,
                  //                   context,
                  //                 ),
                  //                 isVisible: true,
                  //                 onPressed: () async =>
                  //                     await replyDialog(context, ReplyType.all),
                  //               ),
                  //               MessageActionTile(
                  //                 icon: EnumHelpers.replyTypeToIcon(
                  //                     ReplyType.renotify),
                  //                 title: EnumHelpers.replyTypeToString(
                  //                   ReplyType.renotify,
                  //                   context,
                  //                 ),
                  //                 isVisible:
                  //                     widget.selectedPing.isAcknowledgedByAll,
                  //                 onPressed: () async =>
                  //                     replyDialog(context, ReplyType.renotify),
                  //               ),
                  //               MessageActionTile(
                  //                 icon: Icons.people,
                  //                 title: language.title_ack_msg_status,
                  //                 isVisible: true,
                  //                 onPressed: () => Navigator.pushNamed(
                  //                   context,
                  //                   RouteConstants.messageRecipientsPage,
                  //                   arguments:
                  //                       MessageRecipientsListPageArguments(
                  //                     widget.selectedPing.messageId,
                  //                   ),
                  //                 ),
                  //               ),
                  //             ],
                  //           );
                  //         },
                  //       );
                  //     }),
                  //     icon: const Icon(Icons.menu),
                  //   ),
                  // ],
                  actions: [
                    IconButton(
                      onPressed: () {
                        // showDialog(
                        //   context: context,
                        //   builder: (BuildContext context) {
                        //     return AlertDialog(
                        //       content: SingleChildScrollView(
                        //         child: ListBody(
                        //           children: [
                        //             MessageActionTile(
                        //               icon: EnumHelpers.replyTypeToIcon(
                        //                   ReplyType.sender),
                        //               title: EnumHelpers.replyTypeToString(
                        //                   ReplyType.sender, context),
                        //               isVisible: true,
                        //               onPressed: () async => await replyDialog(
                        //                   context, ReplyType.sender),
                        //             ),
                        //             MessageActionTile(
                        //               icon: EnumHelpers.replyTypeToIcon(
                        //                   ReplyType.all),
                        //               title: EnumHelpers.replyTypeToString(
                        //                   ReplyType.all, context),
                        //               isVisible: true,
                        //               onPressed: () async => await replyDialog(
                        //                   context, ReplyType.all),
                        //             ),
                        //             MessageActionTile(
                        //               icon: EnumHelpers.replyTypeToIcon(
                        //                   ReplyType.renotify),
                        //               title: EnumHelpers.replyTypeToString(
                        //                   ReplyType.renotify, context),
                        //               isVisible: widget
                        //                   .selectedPing.isAcknowledgedByAll,
                        //               onPressed: () async => replyDialog(
                        //                   context, ReplyType.renotify),
                        //             ),
                        //             MessageActionTile(
                        //               icon: Icons.people,
                        //               title: language!.title_ack_msg_status,
                        //               isVisible: true,
                        //               onPressed: () => Navigator.pushNamed(
                        //                 context,
                        //                 RouteConstants.messageRecipientsPage,
                        //                 arguments:
                        //                     MessageRecipientsListPageArguments(
                        //                   widget.selectedPing.messageId,
                        //                 ),
                        //               ),
                        //             ),
                        //           ],
                        //         ),
                        //       ),
                        //     );
                        //   },
                        // );

                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return BackdropFilter(
                              filter:
                                  ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                              child: AlertDialog(
                                backgroundColor: Colors.white,
                                content: SizedBox(
                                  width: 300.0, // Adjust the width as needed
                                  height: 200.0, // Adjust the height as needed
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Material(
                                        color: Colors.transparent,
                                        child: InkWell(
                                          // onTap: () async => await replyDialog(
                                          //     context, ReplyType.sender),
                                          onTap: () => Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    ReplyDialogPage(
                                                  replyTo: ReplyType.all,
                                                  selectedPing:
                                                      widget.selectedPing,
                                                ),
                                              )),
                                          child: Row(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    bottom: 25),
                                                child: SvgPicture.asset(
                                                  'assets/images/img_vuesax_linear_r.svg',
                                                  width: 30,
                                                  height: 30,
                                                ),
                                              ),
                                              const SizedBox(width: 10),
                                              const Padding(
                                                padding:
                                                    EdgeInsets.only(bottom: 25),
                                                child: Text('Reply All'),
                                              ),
                                              const Spacer(),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    bottom: 25),
                                                child: SvgPicture.asset(
                                                  'assets/images/img_arrow_right.svg',
                                                  width: 25,
                                                  height: 25,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Material(
                                        color: Colors.transparent,
                                        child: InkWell(
                                          onTap: () async => await replyDialog(
                                              context, ReplyType.renotify),
                                          child: Row(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    bottom: 25),
                                                child: SvgPicture.asset(
                                                  'assets/images/img_vuesax_linear_r.svg',
                                                  width: 30,
                                                  height: 30,
                                                ),
                                              ),
                                              const SizedBox(width: 10),
                                              const Padding(
                                                padding:
                                                    EdgeInsets.only(bottom: 25),
                                                child: Text(
                                                    "Renotify Unacknowledged Use"),
                                              ),
                                              const Spacer(),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    bottom: 25),
                                                child: SvgPicture.asset(
                                                  'assets/images/img_arrow_right.svg',
                                                  width: 25,
                                                  height: 25,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Material(
                                        color: Colors.transparent,
                                        child: InkWell(
                                          onTap: () => Navigator.pushNamed(
                                            context,
                                            RouteConstants
                                                .messageRecipientsPage,
                                            arguments:
                                                MessageRecipientsListPageArguments(
                                              widget.selectedPing.messageId,
                                            ),
                                          ),
                                          child: Row(
                                            children: [
                                              SvgPicture.asset(
                                                'assets/images/img_lock.svg',
                                                width: 30,
                                                height: 30,
                                              ),
                                              const SizedBox(width: 10),
                                              const Text('Messages Recipients'),
                                              const Spacer(),
                                              SvgPicture.asset(
                                                'assets/images/img_arrow_right.svg',
                                                width: 25,
                                                height: 25,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      },
                      icon: const Icon(Icons.menu),
                    ),
                  ],
                ),
                floatingActionButtonLocation:
                    FloatingActionButtonLocation.centerFloat,
                floatingActionButton: FloatingAcknowledgedButton(
                    onPressed: () => context
                        .read<PingDetailsCubit>()
                        .acknowledgePing(ping: widget.selectedPing)),
                // body: widget.selectedPing.hasReplies
                //     ? MessageRepliesBody()
                //     : PingDetailsBody(selectedPing: widget.selectedPing),
                // body: Center(
                //     child: Padding(
                //   padding: const EdgeInsets.all(16.0),
                //   child: Container(
                //     height: 400, // Set the desired height
                //     decoration: BoxDecoration(
                //       color: Colors.white,
                //       border: Border.all(
                //         color: const Color.fromARGB(255, 237, 236, 236),
                //         width: 3,
                //       ),
                //       borderRadius: BorderRadius.circular(18),
                //       boxShadow: [
                //         BoxShadow(
                //           color: Colors.grey.withOpacity(0.5),
                //           spreadRadius: 0,
                //           blurRadius: 7,
                //           offset: Offset(0, 3), // Changes position of shadow
                //         ),
                //       ],
                //     ),
                //     padding: const EdgeInsets.all(16.0),
                //     child: widget.selectedPing.hasReplies
                //         ? MessageRepliesBody()
                //         : PingDetailsBody(selectedPing: widget.selectedPing),
                //   ),
                // )),
                // ********************/

                body: Center(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(
                        20.0, 40.0, 20.0, 150.0), // Reduced top padding
                    child: Container(
                      constraints: BoxConstraints(
                        maxWidth: 600, // Set the desired max width
                      ),
                      //height: 400, // Set the desired height
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                          color: const Color.fromARGB(255, 237, 236, 236),
                          width: 3,
                        ),
                        borderRadius: BorderRadius.circular(18),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 0,
                            blurRadius: 7,
                            offset: Offset(0, 3), // Changes position of shadow
                          ),
                        ],
                      ),
                      padding: const EdgeInsets.all(40.0),
                      // child: widget.selectedPing.hasReplies
                      //     ? MessageRepliesBody()
                      //     : PingDetailsBody(selectedPing: widget.selectedPing),
                      child: MessageRepliesBody(),
                    ),
                  ),
                ),
// ******************
                // body: Padding(
                //   padding: const EdgeInsets.all(16.0),
                //   child: Container(
                //     // decoration: BoxDecoration(
                //     //   border: Border.all(color: Colors.grey),
                //     //   borderRadius: BorderRadius.circular(8.0),
                //     //   color: Colors.white, // Background color for the box
                //     // ),
                //     decoration: BoxDecoration(
                //       color: Colors.white,
                //       border: Border.all(
                //           color: const Color.fromARGB(255, 237, 236, 236),
                //           width: 3),
                //       borderRadius: BorderRadius.circular(18),
                //       boxShadow: [
                //         BoxShadow(
                //           color: Colors.grey.withOpacity(0.5),
                //           spreadRadius: 0,
                //           blurRadius: 7,
                //           offset: Offset(0, 3), // changes position of shadow
                //         ),
                //       ],
                //     ),
                //     padding: const EdgeInsets.all(16.0),
                //     child: widget.selectedPing.hasReplies
                //         ? MessageRepliesBody()
                //         : PingDetailsBody(selectedPing: widget.selectedPing),
                //   ),
                // ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  replyDialog(BuildContext context, ReplyType replyTo) {
    var language = AppLocalizations.of(context);
    var title = replyTo == ReplyType.all
        ? language!.label_replyall
        : language!.label_reply;

    return showDialog(
      context: context,
      builder: (buildContext) {
        return StatefulBuilder(
          builder: (BuildContext _, void Function(void Function()) setState) {
            return SimpleDialog(
              title: Text(title),
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: MessageTextField(
                    textEditingController: textEditingController,
                    type: MessageTextFieldType.reply,
                  ),
                ),
                ListTile(
                  title: Text(language.label_communication_messages),
                  leading: const Icon(Icons.podcasts),
                  subtitle: Text(
                    ListHelpers.selectedMessageMethodListToString(
                      selectedCommunicationPreferences,
                    ),
                    style: TextStyle(color: Colors.grey.shade800),
                  ),
                  iconColor: Palette.primary,
                  onTap: () async {
                    final result = await _onCommunicationChannels(
                      context,
                      selectedCommunicationPreferences,
                      communicationMethods,
                    );
                    setState(() {
                      selectedCommunicationPreferences = result;
                    });
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextButton(
                      onPressed: (() {
                        Navigator.pop(context);
                      }),
                      child: Text(language.cancel),
                    ),
                    TextButton(
                      onPressed: (() {
                        Navigator.pop(context);
                        if (replyTo == ReplyType.renotify) {
                          context
                              .read<PingDetailsCubit>()
                              .renotifyUnacknowledged(
                                message: textEditingController.text,
                                ping: widget.selectedPing,
                                cascadingPlanId: 0,
                                messageMethods: selectedCommunicationPreferences
                                    .map((e) => e.id)
                                    .toList(),
                              );
                        } else {
                          context.read<PingDetailsCubit>().replyToPing(
                                message: textEditingController.text,
                                ping: widget.selectedPing,
                                messageMethods: selectedCommunicationPreferences
                                    .map((e) => e.id)
                                    .toList(),
                                replyTo: ReplyType.sender,
                              );
                        }
                      }),
                      child: Text(language.ok),
                    ),
                  ],
                ),
              ],
            );
          },
        );
      },
    );
  }

  Future<List<SelectedCommunication>> _onCommunicationChannels(
    BuildContext context,
    List<SelectedCommunication> selectedCommunicationPreferences,
    List<MessageMethod> allCommunicationPreferences,
  ) async {
    final result = await Navigator.pushNamed(
      context,
      RouteConstants.communicationPrefencesListPage,
      arguments: CommunicationPrefencesListPageArguments(
        allCommunicationPreferences,
        selectedCommunicationPreferences,
        [],
      ),
    ) as List<SelectedCommunication>;
    return result;
  }
}

class MessageActionTile extends StatelessWidget {
  const MessageActionTile({
    Key? key,
    required this.icon,
    required this.title,
    required this.isVisible,
    required this.onPressed,
  }) : super(key: key);
  final IconData icon;
  final String title;
  final bool isVisible;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: isVisible,
      child: ListTile(
        leading: Icon(icon),
        title: Text(title),
        iconColor: Palette.primary,
        onTap: onPressed,
      ),
    );
  }
}
