import 'package:crises_control/src/core/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

extension PasswordRegex on String {
  bool isPasswordSecure() {
    return RegExp(
            r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[^\da-zA-Z]).{8,}$')
        .hasMatch(this);
  }
}

class PasswordValidator {
  static String? isValidPassword(String? password, BuildContext context, [String? confirmPassword]) {
    if (password == null || password.isEmpty) {
      return FrontEndConstants.canNotBeEmpty;
    }
    if (confirmPassword != null && password != confirmPassword) {
      // return AppLocalizations.of(context).alert_new_confirm_password;
      return "Passwords do not match"; 
    }
    return null;
  }

  static String? isPasswordSecure(String? password, BuildContext context) {
    if (password == null || password.isEmpty ||!password.isPasswordSecure()) {
      return AppLocalizations.of(context)?.alert_msg_password_validation;
    }
    return null;
  }
}
