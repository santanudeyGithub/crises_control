// ignore_for_file: use_super_parameters

import 'package:crises_control/src/core/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CCAlertDialog extends StatelessWidget {
  final String? title;
  final String? description;
  final List<Widget> actions;

  const CCAlertDialog({
    Key? key,
    required this.title,
    required this.description,
    required this.actions,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      // shape: const RoundedRectangleBorder(
      //   borderRadius: BorderRadius.all(
      //     Radius.circular(UIConstants.defaultCornerRadius),
      //   ),
      // ),
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0),
      ),
      title: title != null
          ? Text(
              title!,
              textAlign: TextAlign.center,
              maxLines: 1,
              style: GoogleFonts.roboto(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Color(0xff0B223C)),
            )
          : null,
      content: description != null
          ? Text(
              description!,
              textAlign: TextAlign.center,
            )
          : null,
      actions: actions,
    );
  }
}

class OkAlertButton extends StatelessWidget {
  const OkAlertButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => Navigator.pop(context),
      child: const Text('Ok'),
    );
  }
}

class CancelAlertButton extends StatelessWidget {
  const CancelAlertButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => Navigator.pop(context),
      child: const Text('Cancel'),
    );
  }
}

class CCTextAlertDialog extends StatelessWidget {
  final String title;
  final List<Widget> actions;
  final Widget content;

  const CCTextAlertDialog({
    Key? key,
    required this.title,
    required this.actions,
    required this.content,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(UIConstants.defaultCornerRadius),
        ),
      ),
      title: Text(
        title,
        maxLines: 1,
      ),
      content: content,
      actions: actions,
    );
  }
}
