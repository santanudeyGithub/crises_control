import 'package:crises_control/src/theme/size_utils.dart';
import 'package:crises_control/src/theme/theme_helper.dart';
import 'package:flutter/material.dart';

class AppDecoration {
  // Fill decorations
  static BoxDecoration get fillOnPrimary => BoxDecoration(
        color: theme.colorScheme.onPrimary.withOpacity(1),
      );

  static BoxDecoration get fillGray => BoxDecoration(
        color: appTheme.gray10004,
      );
  static BoxDecoration get fillGray10002 => BoxDecoration(
        color: appTheme.gray10002,
      );
  static BoxDecoration get fillWhiteA => BoxDecoration(
        color: appTheme.whiteA700,
      );
  static BoxDecoration get fillGray5001 => BoxDecoration(
        color: appTheme.gray5001,
      );

  static BoxDecoration get outlineGray => BoxDecoration(
        color: theme.colorScheme.onPrimary.withOpacity(1),
        border: Border.all(
          color: appTheme.gray200,
          width: 1.h,
          strokeAlign: strokeAlignCenter,
        ),
      );

  static BoxDecoration get outlineOnPrimary => BoxDecoration(
        color: theme.colorScheme.secondaryContainer,
        border: Border.all(
          color: theme.colorScheme.onPrimary.withOpacity(1),
          width: 2.h,
        ),
      );

  // Outline decorations
  static BoxDecoration get outlineIndigoD => BoxDecoration(
        color: theme.colorScheme.onPrimary.withOpacity(1),
        boxShadow: [
          BoxShadow(
            color: appTheme.indigo100D1,
            spreadRadius: 2.h,
            blurRadius: 2.h,
            offset: const Offset(
              0,
              0,
            ),
          ),
        ],
      );

  // Gradient decorations
  static BoxDecoration get gradientOnPrimaryToGray => BoxDecoration(
        gradient: LinearGradient(
          begin: const Alignment(1.14, 0.66),
          end: const Alignment(0.64, -0.16),
          colors: [
            theme.colorScheme.onPrimary.withOpacity(0),
            appTheme.gray100,
          ],
        ),
      );

  // Outline decorations
  static BoxDecoration get outlineBlue => BoxDecoration(
        color: theme.colorScheme.onPrimary.withOpacity(0.07),
        border: Border.all(
          color: appTheme.blue500,
          width: 1.h,
        ),
      );

  static BoxDecoration get outlineGray200 => BoxDecoration(
        color: theme.colorScheme.onPrimary.withOpacity(1),
        border: Border.all(
          color: appTheme.gray200,
          width: 1.h,
          strokeAlign: strokeAlignCenter,
        ),
      );
}

class BorderRadiusStyle {
  // Rounded borders
  static BorderRadius get roundedBorder101 => BorderRadius.circular(
        101.h,
      );

  static BorderRadius get roundedBorder21 => BorderRadius.circular(
        21.h,
      );

  static BorderRadius get circleBorder34 => BorderRadius.circular(
        34.h,
      );
  static BorderRadius get circleBorder40 => BorderRadius.circular(
        40.h,
      );
  static BorderRadius get circleBorder45 => BorderRadius.circular(
        45.h,
      );

  static BorderRadius get roundedBorder8 => BorderRadius.circular(
        8.h,
      );

  // Rounded borders
  static BorderRadius get roundedBorder11 => BorderRadius.circular(
        11.h,
      );
  static BorderRadius get roundedBorder14 => BorderRadius.circular(
        12.h,
      );
  static BorderRadius get roundedBorder22 => BorderRadius.circular(
        22.h,
      );
  static BorderRadius get customBorderTL22 => BorderRadius.only(
        topLeft: Radius.circular(22.h),
        topRight: Radius.circular(22.h),
        bottomRight: Radius.circular(22.h),
      );

  static BorderRadius get roundedBorder12 => BorderRadius.circular(
        12.h,
      );

  static BorderRadius get circleBorder25 => BorderRadius.circular(
        25.h,
      );

  static BorderRadius get circleBorder36 => BorderRadius.circular(
        36.h,
      );

  static BorderRadius get circleBorder31 => BorderRadius.circular(
        31.h,
      );
}

// Comment/Uncomment the below code based on your Flutter SDK version.

// For Flutter SDK Version 3.7.2 or greater.

double get strokeAlignInside => BorderSide.strokeAlignInside;

double get strokeAlignCenter => BorderSide.strokeAlignCenter;

double get strokeAlignOutside => BorderSide.strokeAlignOutside;

// For Flutter SDK Version 3.7.1 or less.

// StrokeAlign get strokeAlignInside => StrokeAlign.inside;
//
// StrokeAlign get strokeAlignCenter => StrokeAlign.center;
//
// StrokeAlign get strokeAlignOutside => StrokeAlign.outside;
