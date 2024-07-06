// ignore_for_file: use_super_parameters

import 'dart:developer' as developer;
import 'dart:developer';
import 'package:crises_control/src/core/constants.dart';
import 'package:crises_control/src/core/presentation/styles/text/material_colors_helper.dart';
import 'package:crises_control/src/core/presentation/widgets/custom_widgets.dart';
import 'package:crises_control/src/core/router/page_arguments/page_arguments.dart';
import 'package:crises_control/src/core/router/route_constants.dart';
import 'package:crises_control/src/ping/models/ping.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
export 'ping_list_body.dart';

// class PingListTile extends StatelessWidget {
//   const PingListTile({
//     Key? key,
//     required this.ping,
//   }) : super(key: key);
//   final PingData ping;
//   @override
//   Widget build(BuildContext context) {
//     return ListTile(
//       onTap: () {
//         developer.log("${ping.senderFullName} was tapped");
//         Navigator.pushNamed(
//           context,
//           RouteConstants.pingDetailsPage,
//           arguments: PingDetailsPageArgument(ping),
//         );
//       },
//       title: Padding(
//         padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
//         child: SenderInfo(
//           senderName: ping.senderFullName,
//           date: ping.sentDate,
//           hasAttachment: ping.hasAttachments,
//         ),
//       ),
//       subtitle: Padding(
//         padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
//         child: Text(
//           ping.messageText,
//           style: Theme.of(context)
//               .textTheme
//               .bodyMedium
//               ?.apply(color: ping.isAcknowledged ? Colors.black : Colors.red),
//           maxLines: 4,
//           overflow: TextOverflow.ellipsis,
//         ),
//       ),
//       trailing: Icon(
//         ping.hasReplies
//             ? Icons.keyboard_double_arrow_right
//             : Icons.navigate_next,
//         color: Palette.primary,
//       ),
//     );
//   }
// }

class PingListTile extends StatelessWidget {
  const PingListTile({
    Key? key,
    required this.ping,
  }) : super(key: key);
  final PingData ping;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        developer.log("${ping.senderFullName} was tapped");
        Navigator.pushNamed(
          context,
          RouteConstants.pingDetailsPage,
          arguments: PingDetailsPageArgument(ping),
        );
      },
      title: Row(
        children: [
          // Avatar in the middle left
          CCAvatar(senderName: ping.senderFullName),
          const SizedBox(
              width: 10), // Add some space between the avatar and text
          // Title and subtitle on the right
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // SenderInfo widget for title
                PingMsgInfo(
                  senderName: ping.senderFullName,
                  date: ping.sentDate,
                  hasAttachment: ping.hasAttachments,
                ),
                // Text widget for subtitle
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                  // child: Text(
                  //   ping.messageText,
                  //   // style: Theme.of(context).textTheme.bodyMedium?.apply(
                  //   //     color: ping.isAcknowledged
                  //   //         ? Colors.black
                  //   //         : Color(0xff0B223C)

                  //   //         ),
                  //   style: GoogleFonts.urbanist(
                  //     color: ping.isAcknowledged
                  //         ? Colors.black
                  //         : Color(0xff0B223C),
                  //     fontSize: 14,
                  //     //fontWeight: FontWeight.w800,
                  //   ),
                  //   maxLines: 4,
                  //   overflow: TextOverflow.ellipsis,
                  // ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        ping.messageText,
                        style: GoogleFonts.urbanist(
                          color: ping.isAcknowledged
                              ? Colors.black
                              : Color(0xff0B223C),
                          fontSize: 14,
                        ),
                        maxLines: 4,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(
                          height: 5), // Add space between message and date
                      // Text(
                      //   ping.sentDate,
                      //   style: Theme.of(context).textTheme.bodySmall,
                      // ),
                      CCDateTime(
                          date: ping.sentDate,
                          hasAttachment: ping.hasAttachments)
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      trailing: Icon(
        ping.hasReplies
            ? Icons.keyboard_double_arrow_right
            : Icons.navigate_next,
        color: Palette.primary,
      ),
    );
  }
}

class AcknowledgeButton extends StatelessWidget {
  const AcknowledgeButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      padding: const EdgeInsets.all(20),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          minimumSize: const Size.fromHeight(50),
        ),
        onPressed: () {
          log('acknowledged pressed');
        },
        child: Text(
          AppLocalizations.of(context)!.btn_label_acknowledge,
          style: const TextStyle(fontSize: UIConstants.buttonTextSize),
        ),
      ),
    );
  }
}

class PingMenuItemRow extends StatelessWidget {
  const PingMenuItemRow({
    Key? key,
    required this.icon,
    required this.text,
  }) : super(key: key);
  final IconData icon;
  final Text text;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          color: Palette.primary,
        ),
        const SizedBox(width: 10),
        text
      ],
    );
  }
}
