import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SeverityHelper {
  static String pingIndexToSeverityLabel(int index, BuildContext context) {
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
  
  static String incidentIndexToSeverityLabel(int index, BuildContext context) {
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

  static MaterialColor pingIndexToSeverityColor(int index) {
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