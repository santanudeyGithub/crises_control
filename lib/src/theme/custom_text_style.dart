import 'package:crises_control/src/theme/size_utils.dart';
import 'package:crises_control/src/theme/theme_helper.dart';
import 'package:flutter/material.dart';

/// A collection of pre-defined text styles for customizing text appearance,

/// categorized by different font families and weights.

/// Additionally, this class includes extensions on [TextStyle] to easily apply specific font families to text.

class CustomTextStyles {
  static get bodyLargeBluegray400 => theme.textTheme.bodyLarge!.copyWith(
        color: appTheme.blueGray400,
      );

  // Body text style

  static get bodyLargeBlack900 => theme.textTheme.bodyLarge!.copyWith(
        color: appTheme.black900,
        fontSize: 18.fSize,
      );

  static get titleLargeBlack900 => theme.textTheme.titleLarge!.copyWith(
        color: appTheme.black900,
        fontSize: 20.fSize,
        fontWeight: FontWeight.w400,
      );

  static get titleMediumOnPrimaryBold18 =>
      theme.textTheme.titleMedium!.copyWith(
        color: theme.colorScheme.onPrimary.withOpacity(1),
        fontSize: 18.fSize,
        fontWeight: FontWeight.w700,
      );

  static get bodyLargeff0b223c => theme.textTheme.bodyLarge!.copyWith(
        color: const Color(0XFF0B223C),
      );

  static get titleMediumBluegray900Medium =>
      theme.textTheme.bodyLarge!.copyWith(
        color: const Color(0XFF0B223C),
      );

  static get titleLargeBluegray900Bold => theme.textTheme.bodyLarge!.copyWith(
        color: const Color(0XFF0B223C),
      );

  static get titleMediumPrimaryExtraBold => theme.textTheme.bodyLarge!.copyWith(
        color: const Color(0XFF0B223C),
      );

  static get titleSmallBluegray900Bold => theme.textTheme.bodyLarge!.copyWith(
        color: const Color(0XFF0B223C),
      );

  static get titleSmallOnPrimaryBold => theme.textTheme.bodyLarge!.copyWith(
        color: const Color(0XFF0B223C),
      );

  static get bodyLargeff888888 => theme.textTheme.bodyLarge!.copyWith(
        color: const Color(0XFF888888),
      );

  // Title text style

  static get titleLargeBluegray900 => theme.textTheme.titleLarge!.copyWith(
        color: appTheme.blueGray900.withOpacity(0.6),
        fontSize: 20.fSize,
        fontWeight: FontWeight.w400,
      );

  static get titleMediumMedium => theme.textTheme.titleMedium!.copyWith(
        fontSize: 18.fSize,
        fontWeight: FontWeight.w500,
      );

  static get titleMediumPrimaryMedium => theme.textTheme.titleMedium!.copyWith(
        color: theme.colorScheme.primary,
        fontSize: 18.fSize,
        fontWeight: FontWeight.w500,
      );

  static get titleMediumff0b223c => theme.textTheme.titleMedium!.copyWith(
        color: const Color(0XFF0B223C),
      );

  static get titleMediumBluegray900Medium18 =>
      theme.textTheme.titleMedium!.copyWith(
        color: appTheme.blueGray900.withOpacity(0.6),
        fontSize: 18.fSize,
        fontWeight: FontWeight.w500,
      );

  static get labelLargeBlue500 => theme.textTheme.labelLarge!.copyWith(
        color: appTheme.blue500,
        fontWeight: FontWeight.w600,
      );

  static get labelLargeBluegray900_1 => theme.textTheme.labelLarge!.copyWith(
        color: appTheme.blueGray900.withOpacity(0.56),
      );

  static get labelLargeOnPrimary => theme.textTheme.labelLarge!.copyWith(
        color: theme.colorScheme.onPrimary.withOpacity(1),
        fontWeight: FontWeight.w700,
      );

  // Title text style

  static get titleLargeBluegray900_1 => theme.textTheme.titleLarge!.copyWith(
        color: appTheme.blueGray900,
      );

  static get titleMediumPrimaryBold => theme.textTheme.titleMedium!.copyWith(
        color: theme.colorScheme.primary,
        fontSize: 18.fSize,
        fontWeight: FontWeight.w700,
      );

  static get titleMediumPrimary_1 => theme.textTheme.titleMedium!.copyWith(
        color: theme.colorScheme.primary,
      );

  static get titleSmallBluegray900SemiBold =>
      theme.textTheme.titleSmall!.copyWith(
        color: appTheme.blueGray900,
        fontWeight: FontWeight.w600,
      );

  static get labelLargeBluegray900SemiBold =>
      theme.textTheme.labelLarge!.copyWith(
        color: appTheme.blueGray900,
        fontWeight: FontWeight.w600,
      );

  static get labelLargeGreenA70001 => theme.textTheme.labelLarge!.copyWith(
        color: appTheme.greenA70001,
        fontWeight: FontWeight.w600,
      );

  static get titleMedium18 => theme.textTheme.titleMedium!.copyWith(
        fontSize: 18.fSize,
        color: appTheme.blueGray900,
        fontWeight: FontWeight.w600,
      );

  static get titleMediumOnPrimaryBold => theme.textTheme.titleMedium!.copyWith(
        color: theme.colorScheme.onPrimary.withOpacity(1),
        fontWeight: FontWeight.w700,
      );

  static get titleSmallBluegray900 => theme.textTheme.titleSmall!.copyWith(
        color: appTheme.blueGray900.withOpacity(0.56),
        fontWeight: FontWeight.w500,
        fontSize: 14,
      );

  static get bodyMediumBluegray900_1 => theme.textTheme.bodyMedium!.copyWith(
        color: appTheme.blueGray900,
      );

  static get titleMediumBluegray900 => theme.textTheme.titleMedium!.copyWith(
        color: appTheme.blueGray900.withOpacity(0.6),
      );

  static get titleMediumBluegray900_2 => theme.textTheme.titleMedium!.copyWith(
        color: appTheme.blueGray900.withOpacity(0.53),
      );

  static get bodyMediumUrbanistBluegray900 =>
      theme.textTheme.bodyMedium!.urbanist.copyWith(
        color: appTheme.blueGray900.withOpacity(0.53),
      );

  static get labelLargeYellow900 => theme.textTheme.labelLarge!.copyWith(
        color: appTheme.yellow900,
        fontWeight: FontWeight.w600,
      );

  static get titleMediumBluegray900Medium_1 =>
      theme.textTheme.titleMedium!.copyWith(
        color: appTheme.blueGray900.withOpacity(0.56),
        fontWeight: FontWeight.w500,
      );

  static get labelLargeBluegray900 => theme.textTheme.labelLarge!.copyWith(
        color: appTheme.blueGray900.withOpacity(0.56),
        fontSize: 13.fSize,
        fontWeight: FontWeight.w600,
      );

  static get titleLargeOutfit => theme.textTheme.titleLarge!.outfit.copyWith(
        fontSize: 20.fSize,
      );

  static get titleMediumBluegray90018 => theme.textTheme.titleMedium!.copyWith(
        color: appTheme.blueGray900.withOpacity(0.49),
        fontSize: 18.fSize,
      );

  static get titleMediumBold => theme.textTheme.titleMedium!.copyWith(
        fontWeight: FontWeight.w700,
      );

  static get titleSmallPrimary_2 => theme.textTheme.titleSmall!.copyWith(
        color: theme.colorScheme.primary,
      );

  static get titleSmallPrimary_1 => theme.textTheme.titleSmall!.copyWith(
        color: theme.colorScheme.primary,
      );

  static get bodyMediumUrbanist =>
      theme.textTheme.bodyMedium!.urbanist.copyWith(
        fontSize: 14.fSize,
      );
}

extension on TextStyle {
  TextStyle get urbanist {
    return copyWith(
      fontFamily: 'Urbanist',
    );
  }

  TextStyle get outfit {
    return copyWith(
      fontFamily: 'Outfit',
    );
  }
}
