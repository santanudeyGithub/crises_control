// ignore_for_file: use_super_parameters, deprecated_member_use

import 'package:crises_control/src/CustomAppbar.dart';
import 'package:crises_control/src/core/presentation/styles/text/material_colors_helper.dart';
import 'package:crises_control/src/core/presentation/widgets/cc_text_field.dart';
import 'package:crises_control/src/core/router/route_constants.dart';
import 'package:crises_control/src/incident/cubits/message_editor_cubit/message_editor_cubit.dart';
import 'package:crises_control/src/incident/models/incident_detail.dart';
import 'package:crises_control/src/incident/widgets/message_library.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';

class MessageEditorPage extends StatefulWidget {
  const MessageEditorPage(
      {super.key, required this.message, required this.incidentMessage});
  final String message;
  final List<IncidentMessages> incidentMessage;

  @override
  State<MessageEditorPage> createState() => _MessageEditorPageState();
}

class _MessageEditorPageState extends State<MessageEditorPage> {
  @override
  Widget build(BuildContext context) {
    var language = AppLocalizations.of(context);
    return Scaffold(
      // body: Column(
      //   children: [
      //     CustomHeader(title: language!.label_message),

      // Row(
      //   mainAxisAlignment: MainAxisAlignment.end,
      //   children: [
      //     Visibility(
      //       visible: widget.incidentMessage.isNotEmpty,
      //       child: IconButton(
      //         onPressed: () {
      //           onMessageLibrary(context, messages: widget.incidentMessage);
      //         },
      //         icon: const Icon(Icons.library_books),
      //         tooltip: language.title_message_library,
      //       ),
      //     ),
      //   ],
      // ),
      // Expanded(
      //   child: _MessageEditorBody(message: widget.message),
      // ),
      //     ],
      //   ),
      body: Stack(
        children: [
          CustomHeader(title: language!.label_message),
          Padding(
            padding: const EdgeInsets.only(top: 35, right: 25),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () {
                    // onMessageLibrary(context, messages: widget.incidentMessage);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MessageLibraryScreen()),
                    );
                  },
                  // child: Visibility(
                  // visible: widget.incidentMessage.isNotEmpty,
                  // child: Tooltip(
                  //   message: language.title_message_library,

                  // ),

                  child: Image(
                    image: AssetImage('assets/images/Message.png'),
                    height: 45,
                    width: 45,
                  ),

                  // child: IconButton(
                  //   onPressed: () {
                  //     onMessageLibrary(context,
                  //         messages: widget.incidentMessage);
                  //   },
                  //   icon: const Icon(Icons.library_books),
                  //   tooltip: language.title_message_library,

                  // ),
                  // ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(
                top: 135,
                left: 23,
                right: 5), // Adjust this to position the box
            padding: EdgeInsets.all(16.0),
            width: 365,
            height: 600,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20.0),
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
                SizedBox(height: 25), // Space for the circle

                Expanded(
                  child: _MessageEditorBody(message: widget.message),
                ),

                SizedBox(height: 20),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 785, left: 20, right: 0),
            child: Container(
              child: ElevatedButton(
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
                  padding:
                      const EdgeInsets.symmetric(horizontal: 165, vertical: 18),
                ),
                child: Text(
                  'Done'.toUpperCase(),
                  style: GoogleFonts.urbanist(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> onMessageLibrary(BuildContext context,
      {required List<IncidentMessages> messages}) {
    return showModalBottomSheet<void>(
      context: context,
      builder: (buildContext) {
        return ListView.builder(
          shrinkWrap: true,
          itemCount: messages.length,
          itemBuilder: ((itemContext, index) {
            var incidentMessage = messages[index];
            return MessageLibraryListTile(
              incidentMessage: incidentMessage,
              onTap: () {
                context
                    .read<MessageEditorCubit>()
                    .addMessageFromLibrary(incidentMessage: incidentMessage);

                Navigator.pop(context);
              },
            );
          }),
        );
      },
    );
  }
}

class MessageLibraryListTile extends StatelessWidget {
  const MessageLibraryListTile({
    Key? key,
    required this.onTap,
    required this.incidentMessage,
  }) : super(key: key);

  final IncidentMessages incidentMessage;

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onTap,
      child: ListTile(
        title: Text(incidentMessage.title),
        subtitle: Text(
          incidentMessage.actionDescription,
          style:
              Theme.of(context).textTheme.bodySmall?.apply(color: Colors.grey),
        ),
        trailing: Visibility(
          visible: incidentMessage.hasParticipants,
          child: const Icon(
            Icons.person,
            color: Palette.primary,
          ),
        ),
      ),
    );
  }
}

class _MessageEditorBody extends StatefulWidget {
  const _MessageEditorBody({required this.message});
  final String message;

  @override
  State<_MessageEditorBody> createState() => __MessageEditorBodyState();
}

// class __MessageEditorBodyState extends State<_MessageEditorBody> {
//   final TextEditingController _textEditingController = TextEditingController();
//   final TextEditingController _controller = TextEditingController();

//   void _sendMessage() {
//     if (_controller.text.isNotEmpty) {
//       print(
//           _controller.text); // Here you can add your logic to send the message
//       _controller.clear();
//     }
//   }

//   @override
//   void initState() {
//     super.initState();
//     _textEditingController.text = widget.message;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//       onWillPop: () async {
//         Navigator.pop(context, _textEditingController.text);
//         return true;
//       },
//       child: BlocListener<MessageEditorCubit, MessageEditorState>(
//         listener: (context, state) {
//           if (state is LibraryMessageAdded) {
//             _textEditingController.text =
//                 state.incidentMessage.actionDescription;
//           }
//         },
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.end,
//           //children: [
//           //MessageTextField(
//           //  onChanged: ((value) {}),
//           //  textEditingController: _textEditingController,
//           //  type: MessageTextFieldType.incident,
//           //  ),
//           //  Visibility(
//           //  visible: _textEditingController.text.isNotEmpty,
//           // child: Padding(
//           //  padding: const EdgeInsets.all(8.0),
//           // child: IconButton(
//           //  onPressed: (() {
//           //setState(() {
//           //   _textEditingController.clear();
//           // });
//           //  }),
//           //  icon: const Icon(Icons.clear),
//           //  ),
//           // ),
//           // )
//           //],
//           children: [
//             Container(
//               margin: const EdgeInsets.only(
//                   top: 25,
//                   left: 20,
//                   right: 20), // Adjust this to position the box
//               // padding: const EdgeInsets.all(16.0),
//               width: 375,
//               height: 350,
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: const BorderRadiusDirectional.only(
//                   topStart: Radius.circular(25.0), // Radius for top left corner
//                   topEnd: Radius.circular(25.0), // Radius for top right corner
//                   bottomStart:
//                       Radius.circular(0), // Radius for bottom left corner
//                   bottomEnd:
//                       Radius.circular(25.0), // Radius for bottom right corner
//                 ),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.grey.withOpacity(0.5),
//                     spreadRadius: 2,
//                     blurRadius: 7,
//                     offset: const Offset(0, 3), // changes position of shadow
//                   ),
//                 ],
//               ),
//               child: Column(
//                 children: [
//                   Row(
//                     children: [
//                       Padding(
//                         padding:
//                             const EdgeInsets.only(left: 25, top: 15, bottom: 0),
//                         child: ClipRRect(
//                           borderRadius: BorderRadius.circular(16.0),
//                           child: const Image(
//                             image: AssetImage('assets/images/img_oval.png'),
//                           ),
//                         ),
//                       ),
//                       Padding(
//                         padding:
//                             const EdgeInsets.only(right: 20, left: 25, top: 10),
//                         child: Text(
//                           'Chad Salazar',
//                           style: GoogleFonts.urbanist(
//                               fontSize: 22, color: Colors.black),
//                         ),
//                       ),
//                     ],
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.only(left: 35),
//                     child: MessageTextField(
//                       onChanged: ((value) {}),
//                       textEditingController: _textEditingController,
//                       type: MessageTextFieldType.incident,
//                     ),
//                   ),
//                   Visibility(
//                     visible: _textEditingController.text.isNotEmpty,
//                     child: const Padding(
//                       padding: EdgeInsets.all(8.0),
//                       //  child: IconButton(
//                       // onPressed: (() {
//                       //  setState(() {
//                       //   _textEditingController.clear();
//                       // });
//                       // }),
//                       //  icon: const Icon(Icons.clear),
//                       //),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             Column(
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.only(
//                       top: 150, left: 25, right: 25, bottom: 25),
//                   child: Container(
//                     decoration: BoxDecoration(
//                       color: Color.fromARGB(255, 255, 255, 255),
//                       borderRadius: BorderRadius.circular(8.0),
//                       boxShadow: [
//                         BoxShadow(
//                           color: Colors.grey.withOpacity(0.5),
//                           spreadRadius: 2,
//                           blurRadius: 5,
//                           offset: const Offset(0, 3),
//                         ),
//                       ],
//                     ),
//                     padding: const EdgeInsets.symmetric(horizontal: 15.0),
//                     child: Row(
//                       children: [
//                         Expanded(
//                           child: TextField(
//                             controller: _controller,
//                             decoration: const InputDecoration(
//                               hintText: 'Type a message',
//                               border: InputBorder.none,
//                             ),
//                             onSubmitted: (value) => _sendMessage(),
//                           ),
//                         ),
//                         IconButton(
//                           icon: const Icon(Icons.send),
//                           onPressed: _sendMessage,
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//                 Row(
//                   children: [
//                     Text(
//                       "Type  your message…",
//                       style: GoogleFonts.urbanist(fontSize: 16),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

class __MessageEditorBodyState extends State<_MessageEditorBody> {
  final TextEditingController _textEditingController = TextEditingController();
  final TextEditingController _controller = TextEditingController();

  void _sendMessage() {
    if (_controller.text.isNotEmpty) {
      print(
          _controller.text); // Here you can add your logic to send the message
      _controller.clear();
    }
  }

  @override
  void initState() {
    super.initState();
    _textEditingController.text = widget.message;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context, _textEditingController.text);
        return true;
      },
      child: BlocListener<MessageEditorCubit, MessageEditorState>(
        listener: (context, state) {
          if (state is LibraryMessageAdded) {
            _textEditingController.text =
                state.incidentMessage.actionDescription;
          }
        },
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight,
                ),
                child: IntrinsicHeight(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(
                            top: 0,
                            left: 20,
                            right: 20), // Adjust this to position the box
                        // padding: const EdgeInsets.all(16.0),
                        width: double.infinity,
                        // decoration: BoxDecoration(
                        //   color: Colors.white,
                        //   borderRadius: const BorderRadiusDirectional.only(
                        //     topStart: Radius.circular(
                        //         25.0), // Radius for top left corner
                        //     topEnd: Radius.circular(
                        //         25.0), // Radius for top right corner
                        //     bottomStart: Radius.circular(
                        //         0), // Radius for bottom left corner
                        //     bottomEnd: Radius.circular(
                        //         25.0), // Radius for bottom right corner
                        //   ),
                        //   boxShadow: [
                        //     BoxShadow(
                        //       color: Colors.grey.withOpacity(0.5),
                        //       spreadRadius: 2,
                        //       blurRadius: 7,
                        //       offset: const Offset(
                        //           0, 3), // changes position of shadow
                        //     ),
                        //   ],
                        // ),
                        child: Column(
                          children: [
                            // Row(
                            //   children: [
                            //     Padding(
                            //       padding: const EdgeInsets.only(
                            //           left: 25, top: 15, bottom: 0),
                            //       child: ClipRRect(
                            //         borderRadius: BorderRadius.circular(16.0),
                            //         child: const Image(
                            //           image: AssetImage(
                            //               'assets/images/img_oval.png'),
                            //         ),
                            //       ),
                            //     ),
                            //     Padding(
                            //       padding: const EdgeInsets.only(
                            //           right: 20, left: 25, top: 10),
                            //     ),
                            //   ],
                            // ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 35, top: 100),
                              child: MessageTextField(
                                onChanged: ((value) {}),
                                textEditingController: _textEditingController,
                                type: MessageTextFieldType.incident,
                              ),
                            ),
                            Visibility(
                              visible: _textEditingController.text.isNotEmpty,
                              child: const Padding(
                                padding: EdgeInsets.all(8.0),
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Spacer(),
                      // Padding(
                      //   padding: const EdgeInsets.all(20.0),
                      //   child: Container(
                      //     decoration: BoxDecoration(
                      //       color: Colors.white,
                      //       borderRadius: BorderRadius.circular(8.0),
                      //       boxShadow: [
                      //         BoxShadow(
                      //           color: Colors.grey.withOpacity(0.5),
                      //           spreadRadius: 2,
                      //           blurRadius: 5,
                      //           offset: const Offset(0, 3),
                      //         ),
                      //       ],
                      //     ),
                      //     padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      //     child: Row(
                      //       children: [
                      //         Expanded(
                      //           child: TextField(
                      //             controller: _controller,
                      //             decoration: const InputDecoration(
                      //               hintText: 'Type a message',
                      //               border: InputBorder.none,
                      //             ),
                      //             onSubmitted: (value) => _sendMessage(),
                      //           ),
                      //         ),
                      //         IconButton(
                      //           icon: const Icon(Icons.send),
                      //           onPressed: _sendMessage,
                      //         ),
                      //       ],
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
