import 'package:crises_control/src/core/presentation/widgets/custom_widgets.dart';
import 'package:crises_control/src/ping/models/ping.dart';
import 'package:flutter/material.dart';

class PingDetailsBody extends StatelessWidget {
  const PingDetailsBody({super.key, required this.selectedPing});
  final PingData selectedPing;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SenderInfo(
            date: selectedPing.sentDate,
            hasAttachment: selectedPing.hasAttachments,
            senderName: selectedPing.senderFullName,
          ),
          const SizedBox(height: 10),
          Text(selectedPing.messageText),
        ],
      ),
    );
  }
}
