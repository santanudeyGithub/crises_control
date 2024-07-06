import 'package:crises_control/src/core/models/communication_models/company_comms_response.dart';
import 'package:flutter/material.dart';

class IconConverter {
  static IconData communicationPreferencesToIcon(MessageMethod messageMethod) {
    switch (messageMethod.methodId) {
      case 1:
        return Icons.notifications_active;
      case 2:
        return Icons.textsms;
      case 3:
        return Icons.phone;
      case 4:
        return Icons.email;
      default: //5
        return Icons.notifications_active;
    }
  }

  static IconData messageMethodIdToIcon(int messageMethodId) {
    switch (messageMethodId) {
      case 1:
        return Icons.notifications_active;
      case 2:
        return Icons.textsms;
      case 3:
        return Icons.phone;
      case 4:
        return Icons.email;
      default: //5
        return Icons.notifications_active;
    }
  }
}
