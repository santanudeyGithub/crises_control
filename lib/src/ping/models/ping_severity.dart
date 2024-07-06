import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

enum PingSeverity { low, medium, high }

class PriorityHelper {
  static String pingIndexToPriorityLabel(int index, BuildContext context) {
    var language = AppLocalizations.of(context);
    switch (index) {
      case 0:
        return language!.label_low;
      case 1:
        return language!.label_medium;
      case 2:
        return language!.label_high;
      default:
        return language!.label_low;
    }
  }

  static int pingIndexToPriorityValue(int index) {
    switch (index) {
      case 0:
        return 100;
      case 1:
        return 500;
      case 2:
        return 999;
      default:
        return 100;
    }
  }

  static MaterialColor pingIndexToPriorityColor(int index) {
    switch (index) {
      case 0:
        return Colors.grey;
      case 1:
        return Colors.amber;
      case 2:
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
}
