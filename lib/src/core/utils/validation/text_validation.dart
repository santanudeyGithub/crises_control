import 'package:crises_control/src/core/constants.dart';

class TextValidator {
  static String? canNotBeEmpty(String? value) {
    if (value == null || value.isEmpty) {
      return FrontEndConstants.canNotBeEmpty;
    }
    return null;
  }
}
