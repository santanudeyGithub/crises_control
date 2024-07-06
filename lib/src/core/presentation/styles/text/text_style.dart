import 'package:flutter/material.dart';

class CustomTextStyle {
  static TextStyle? lightGreyBodyText(BuildContext context) {
    return Theme.of(context)
        .textTheme
        .bodyMedium
        ?.copyWith(color: Colors.grey[600]);
  }
}

extension CustomStyles on TextTheme {
  TextStyle get lightGreyText {
    return TextStyle(color: Colors.grey[600]);
  }
}
