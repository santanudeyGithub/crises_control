import 'package:flutter/material.dart';

class CustomizedButton extends StatelessWidget {
  final String? buttonText;
  final Color? buttonColor;
  final Color? textColor;
  final VoidCallback? onPressed;

  const CustomizedButton(
      {super.key,
      this.buttonText,
      this.buttonColor,
      this.onPressed,
      this.textColor});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: InkWell(
        onTap: onPressed,
        child: Container(
          height: 60,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              color: buttonColor,
              border: Border.all(width: 1, color: Colors.white),
              borderRadius: BorderRadius.circular(10)),
          child: Center(
            child: Text(
              buttonText!,
              style: TextStyle(color: textColor, fontSize: 20),
            ),
          ),
        ),
      ),
    );
  }
}
