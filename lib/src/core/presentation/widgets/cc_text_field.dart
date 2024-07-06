// ignore_for_file: use_super_parameters

import 'package:crises_control/src/core/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void unfocusTextField() {
  FocusManager.instance.primaryFocus?.unfocus();
}

enum MessageTextFieldType { incident, ping, reply }

class MessageTextField extends StatelessWidget {
  const MessageTextField({
    Key? key,
    required this.textEditingController,
    required this.type,
    this.onChanged,
  }) : super(key: key);
  final TextEditingController textEditingController;
  final MessageTextFieldType type;
  final void Function(String value)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: type == MessageTextFieldType.reply
          ? const EdgeInsets.all(0)
          : const EdgeInsets.all(8.0),
      child: TextFormField(
        onChanged: onChanged,
        autofocus: true,
        controller: textEditingController,
        maxLines: _getMaxLines(type),
        textAlign: TextAlign.start,
        textInputAction: TextInputAction.done,
        textCapitalization: TextCapitalization.sentences,
        keyboardType: TextInputType.text,
        //  maxLength: type == MessageTextFieldType.incident
        // ? MessageConstants.incidentMessageLength
        //  : MessageConstants.pingMessageLength,
        // decoration: InputDecoration(
        //  border: OutlineInputBorder(
        ////  borderRadius: BorderRadius.circular(
        // UIConstants.defaultCornerRadius,
        // ),
        //  ),
        //  hintText: AppLocalizations.of(context)?.enter_message,
        // ),
      ),
    );
  }

  int _getMaxLines(MessageTextFieldType type) {
    switch (type) {
      case MessageTextFieldType.incident:
        return 11;
      case MessageTextFieldType.ping:
        return 4;
      case MessageTextFieldType.reply:
        return 8;
    }
  }
}
