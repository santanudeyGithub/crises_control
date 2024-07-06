import 'package:crises_control/src/core/services/crises_control_rest_service.dart';
import 'package:crises_control/src/ping/repository/ping_repository.dart';
import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class EnumHelpers {
  //Reply types help
  static String replyTypeToString(ReplyType replyType, BuildContext context) {
    final language = AppLocalizations.of(context);
    switch (replyType) {
      case ReplyType.all:
        return language!.label_replyall;
      case ReplyType.sender:
        return language!.label_reply;
      case ReplyType.renotify:
        return language!.label_renotify;
    }
  }

  static IconData replyTypeToIcon(ReplyType replyType) {
    switch (replyType) {
      case ReplyType.all:
        return Icons.reply_all;
      case ReplyType.sender:
        return Icons.reply;
      case ReplyType.renotify:
        return Icons.notifications_active;
    }
  }

  static String cascadingPlanTypeToString(CascadingPlanType cascadingPlanType) {
    switch (cascadingPlanType) {
      case CascadingPlanType.all:
        return 'ALL';
      case CascadingPlanType.ping:
        return 'Ping';
      case CascadingPlanType.incident:
        return 'Incident';
    }
  }
}
