import 'package:crises_control/src/core/constants.dart';
import 'package:flutter/material.dart';

class CCButton extends StatelessWidget {
  const CCButton(this.text, {super.key, required this.onPressed});

  final String text;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Container(
        height: 75,
        padding: const EdgeInsets.all(5),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            minimumSize: const Size.fromHeight(50),
            backgroundColor: Color(0xff1E60AA),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                UIConstants.defaultCornerRadius,
              ),
            ),
          ),
          onPressed: onPressed,
          child: Text(
            text.toUpperCase(),
            style: const TextStyle(fontSize: 18, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
