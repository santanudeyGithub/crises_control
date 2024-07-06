import 'package:crises_control/src/theme/app_decoration.dart';
import 'package:crises_control/src/theme/custom_text_style.dart';
import 'package:crises_control/src/theme/size_utils.dart';
import 'package:crises_control/src/theme/theme_helper.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class IncidentsItemWidget extends StatelessWidget {
  const IncidentsItemWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 15.h,
        vertical: 12.v,
      ),
      decoration: AppDecoration.outlineGray.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder14,
      ),
      width: 152.h,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Incidents",
            style: CustomTextStyles.titleSmallBluegray900SemiBold,
          ),
          //SizedBox(height: 1.v),
          Opacity(
            opacity: 0.6,
            child: Text(
              "Lorem ipsum dolor sit.",
              style: CustomTextStyles.labelLargeBluegray900_1,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Row(
              children: [
                Container(
                  height: 5,
                  width: 15,
                  decoration: BoxDecoration(color: appTheme.greenA70001),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 5),
                  child: Container(
                    height: 5,
                    width: 15,
                    decoration: BoxDecoration(color: appTheme.greenA70001),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 5),
                  child: Container(
                    height: 5,
                    width: 15,
                    decoration: BoxDecoration(color: appTheme.blueGray10001),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 5),
                  child: Container(
                    height: 5,
                    width: 15,
                    // decoration: BoxDecoration(color: appTheme.amber600),
                    decoration: BoxDecoration(color: appTheme.blueGray10001),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 5),
                  child: Container(
                    height: 5,
                    width: 15,
                    decoration: BoxDecoration(color: appTheme.blueGray10001),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
