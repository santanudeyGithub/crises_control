// ignore_for_file: deprecated_member_use, prefer_const_constructors

import 'package:crises_control/src/core/constants.dart';
import 'package:crises_control/src/core/presentation/styles/text/text_style.dart';
import 'package:crises_control/src/core/utils/common.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class PrivacyPolicyText extends StatelessWidget {
  const PrivacyPolicyText({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
      child: Align(
        alignment: Alignment.centerRight,
        child: TextButton(
          child: RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              text: 'By Continuing you accept our ',
              style: CustomTextStyle.lightGreyBodyText(context),
              children: [
                TextSpan(
                  text: 'Privacy Policy',
                  recognizer: TapGestureRecognizer()..onTap = (){launch('https://www.crises-control.com/privacy-policy/');} ,
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.black),
                ),
                TextSpan(
                  text: ' and ',
                  style: CustomTextStyle.lightGreyBodyText(context),
                ),
                TextSpan(
                  text: 'Terms of Use',
                  recognizer: TapGestureRecognizer()..onTap = (){launch('https://www.crises-control.com/terms-of-use/');} ,                  
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.black),
                ),
              ],
            ),
          ),
          onPressed: () {
            showAboutCrisesControlDialog(context);
          },
        ),
      ),
    );
  }
}
