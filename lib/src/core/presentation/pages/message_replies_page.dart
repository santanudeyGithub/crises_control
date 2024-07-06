// ignore_for_file: use_super_parameters

import 'package:crises_control/src/core/models/replies.dart';
import 'package:crises_control/src/core/presentation/widgets/cc_activity_indicator.dart';
import 'package:crises_control/src/core/presentation/widgets/custom_widgets.dart';
import 'package:crises_control/src/ping/cubit/ping_details/ping_details_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MessageRepliesBody extends StatelessWidget {
  MessageRepliesBody({super.key});
  final CCLoadingOverlay _loadingOverlay = CCLoadingOverlay();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: BlocConsumer<PingDetailsCubit, PingDetailsState>(
        listener: (context, state) {
          handleStateChanges(state, context);
        },
        builder: (context, state) {
          if (state is PingDetailsReplies) {
            return ListView.builder(
              itemCount: state.replies.length,
              itemBuilder: ((context, index) {
                var reply = state.replies[index];
                return Message(reply: reply);
              }),
            );
          }
          return Container();
        },
      ),
    );
  }

  void handleStateChanges(PingDetailsState state, BuildContext context) {
    if (state is PingDetailsLoading) {
      _loadingOverlay.show(context);
    } else {
      _loadingOverlay.hide();
    }
    if (state is PingDetailsFailure) {
      showDialog(
        context: context,
        builder: (context) => state.error.displayErrorAlerts(context),
      );
    }
  }
}

// class Message extends StatelessWidget {
//   const Message({
//     Key? key,
//     required this.reply,
//   }) : super(key: key);

//   final Reply reply;

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: Column(
//         crossAxisAlignment: reply.sentByUser
//             ? CrossAxisAlignment.end
//             : CrossAxisAlignment.start,
//         children: [
//           Row(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             mainAxisAlignment: reply.sentByUser
//                 ? MainAxisAlignment.end
//                 : MainAxisAlignment.start,
//             children: [
//               Visibility(
//                 visible: !reply.sentByUser,
//                 child: Row(
//                   children: [
//                     CCAvatar(senderName: reply.fullName),
//                     const SizedBox(width: 15),
//                   ],
//                 ),
//               ),
//               SizedBox(
//                 width: MediaQuery.of(context).size.width * 0.6,
//                 child: Column(
//                   crossAxisAlignment: reply.sentByUser
//                       ? CrossAxisAlignment.end
//                       : CrossAxisAlignment.start,
//                   children: [
//                     _MessageBody(reply: reply),
//                     const SizedBox(height: 8),
//                   ],
//                 ),
//               ),
//               Visibility(
//                 visible: reply.sentByUser,
//                 child: Row(
//                   children: [
//                     const SizedBox(width: 15),
//                     CCAvatar(senderName: reply.fullName),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//           const SizedBox(height: 8),
//           _MessageSentDate(reply: reply),
//         ],
//       ),
//     );
//   }
// }

class Message extends StatelessWidget {
  const Message({
    Key? key,
    required this.reply,
  }) : super(key: key);

  final Reply reply;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: reply.sentByUser
            ? CrossAxisAlignment.end
            : CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: reply.sentByUser
                ? MainAxisAlignment.end
                : MainAxisAlignment.start,
            children: [
              if (!reply.sentByUser)
                Row(
                  children: [
                    CCAvatar(senderName: reply.fullName),
                    const SizedBox(width: 15),
                  ],
                ),
              Flexible(
                child: Column(
                  crossAxisAlignment: reply.sentByUser
                      ? CrossAxisAlignment.end
                      : CrossAxisAlignment.start,
                  children: [
                    _MessageBody(reply: reply),
                    const SizedBox(height: 8),
                  ],
                ),
              ),
              if (reply.sentByUser)
                Row(
                  children: [
                    const SizedBox(width: 15),
                    CCAvatar(senderName: reply.fullName),
                  ],
                ),
            ],
          ),
          const SizedBox(height: 8),
          _MessageSentDate(reply: reply),
        ],
      ),
    );
  }
}

class _MessageBody extends StatelessWidget {
  const _MessageBody({
    Key? key,
    required this.reply,
  }) : super(key: key);

  final Reply reply;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: reply.sentByUser ? Colors.grey.shade400 : Colors.blue.shade800,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        reply.messageText,
        style: TextStyle(
          color: reply.sentByUser ? Colors.black : Colors.white,
        ),
      ),
    );
  }
}

class _MessageSentDate extends StatelessWidget {
  const _MessageSentDate({
    Key? key,
    required this.reply,
  }) : super(key: key);

  final Reply reply;

  @override
  Widget build(BuildContext context) {
    return Text(
      "${reply.fullName} - ${reply.sentOn}",
      style: Theme.of(context).textTheme.bodySmall?.apply(
            color: Colors.grey.shade900,
          ),
    );
  }
}

// class Message extends StatelessWidget {
//   const Message({
//     Key? key,
//     required this.isSender,
//     required this.reply,
//   }) : super(key: key);

//   final bool isSender;
//   final Reply reply;

//   @override
//   Widget build(BuildContext context) {
//     if (isSender) {
//       return Padding(
//         padding: const EdgeInsets.symmetric(vertical: 8.0),
//         child: Wrap(
//           alignment: WrapAlignment.end,
//           children: [
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.end,
//               children: [
//                 Container(
//                   width: MediaQuery.of(context).size.width * 0.6,
//                   padding: const EdgeInsets.all(20),
//                   decoration: BoxDecoration(
//                     color: Colors.blue.shade800,
//                     borderRadius: BorderRadius.circular(8),
//                   ),
//                   child: Row(
//                     crossAxisAlignment: CrossAxisAlignment.end,
//                     children: [
//                       Text(
//                         reply.messageText,
//                         style: const TextStyle(
//                           color: Colors.white,
//                         ),
//                       ),
//                       Visibility(
//                         visible: reply.hasAttachment,
//                         child: const Icon(
//                           Icons.attach_file,
//                           color: Colors.white,
//                         ),
//                       )
//                     ],
//                   ),
//                 ),
//                 const SizedBox(height: 10),
//                 RichText(
//                   text: TextSpan(
//                     text: "${reply.sentOn} - ",
//                     style: TextStyle(color: Colors.grey.shade600),
//                     children: <TextSpan>[
//                       TextSpan(
//                         text: reply.fullName,
//                         style: const TextStyle(
//                           color: Colors.black,
//                           fontWeight: FontWeight.w600,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(width: 10),
//             CCAvatar(senderName: reply.fullName),
//           ],
//         ),
//       );
//     }

//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 8.0),
//       child: Wrap(
//         children: [
//           CCAvatar(senderName: reply.fullName),
//           const SizedBox(width: 10),
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Container(
//                 width: MediaQuery.of(context).size.width * 0.6,
//                 padding: const EdgeInsets.all(20),
//                 decoration: BoxDecoration(
//                   color: Colors.grey.shade400,
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//                 child: Row(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       reply.messageText,
//                     ),
//                     const Spacer(),
//                     Visibility(
//                       visible: reply.hasAttachment,
//                       child: const Icon(
//                         Icons.attach_file,
//                         color: Colors.white,
//                       ),
//                     )
//                   ],
//                 ),
//               ),
//               const SizedBox(height: 10),
//               RichText(
//                 text: TextSpan(
//                   text: reply.fullName,
//                   style: const TextStyle(
//                     color: Colors.black,
//                     fontWeight: FontWeight.w600,
//                   ),
//                   children: <TextSpan>[
//                     TextSpan(
//                       text: " - ${reply.sentOn}",
//                       style: TextStyle(color: Colors.grey.shade600),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }
