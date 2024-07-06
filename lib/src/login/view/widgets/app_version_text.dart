// ignore_for_file: use_super_parameters

import 'package:crises_control/src/core/constants.dart';
import 'package:crises_control/src/core/presentation/styles/text/text_style.dart';
import 'package:crises_control/src/core/utils/common.dart';
import 'package:flutter/material.dart';

class AppVersionText extends StatelessWidget {
  const AppVersionText({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 0, bottom: 25),
      child: Align(
        alignment: Alignment.center,
        child: TextButton(
          child: Text(
            // 'Version ${CrisesControlVersions.appVersion}',
            '${CrisesControlVersions.appVersion}',
            style: CustomTextStyle.lightGreyBodyText(context),
          ),
          onPressed: () {
            showAboutCrisesControlDialog(context);
          },
        ),
      ),
    );
  }
}
