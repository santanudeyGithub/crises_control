import 'package:crises_control/src/core/constants.dart';

extension EmailRegex on String {
  //RFC 5322 Email Regex
  bool isValidEmail() {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(this);
  }
}

class EmailValidator {
  static String? isValidEmail(String? email) {
    if (email == null || email.isEmpty) {
      return FrontEndConstants.canNotBeEmpty;
    }
    if (!email.isValidEmail()) {
      return FrontEndConstants.invalidEmailMessage;
    }
    return null;
  }
}
