import 'package:dpl_ecommerce/const/app_theme.dart';
import 'package:dpl_ecommerce/utils/constants/size_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// A collection of pre-defined text styles for customizing text appearance,
/// categorized by different font families and weights.
/// Additionally, this class includes extensions on [TextStyle] to easily apply specific font families to text.

class CustomTextStyles {
  // Body text style
  static get bodyMediumGray600 => theme.textTheme.bodyMedium!.copyWith(
        color: appTheme.gray600,
      );
  static get bodyMediumPrimaryContainer => theme.textTheme.bodyMedium!.copyWith(
        color: theme.colorScheme.primaryContainer,
      );
  static get bodySmall10 => theme.textTheme.bodySmall!.copyWith(
        fontSize: 10.sp,
      );
       static get titleSmallErrorContainer => theme.textTheme.titleSmall!.copyWith(
        color: theme.colorScheme.errorContainer,
        fontWeight: FontWeight.w600,
      );
      static get titleMediumBlack900 => theme.textTheme.titleMedium!.copyWith(
        color: appTheme.black900,
        fontSize: 16,
        fontWeight: FontWeight.w500,
      );
      static get bodyMediumBlack90014 => theme.textTheme.bodyMedium!.copyWith(
        color: appTheme.black900,
        fontSize: 14,
      );
      static get bodySmallPrimary => theme.textTheme.bodySmall!.copyWith(
        color: theme.colorScheme.primary,
      );
  static get labelLargeInterBlack900Medium =>
      theme.textTheme.labelLarge!.inter.copyWith(
        color: appTheme.black900,
        fontWeight: FontWeight.w500,
      );
static get titleLargeInterSemiBold =>
      theme.textTheme.titleLarge!.inter.copyWith(
        fontWeight: FontWeight.w600,
      );
static get labelLargeInterGray800 =>
      theme.textTheme.labelLarge!.inter.copyWith(
        color: appTheme.gray600,
        fontWeight: FontWeight.w500,
      );
      static get labelLargeInterGray90004 =>
      theme.textTheme.labelLarge!.inter.copyWith(
        color: appTheme.black900,
        fontWeight: FontWeight.w500,
      );
  static get bodySmallBluegray300 => theme.textTheme.bodySmall!.copyWith(
        color: appTheme.blueGray300,
      );
  static get bodySmallGray600 => theme.textTheme.bodySmall!.copyWith(
        color: appTheme.gray600,
      );
  static get bodySmallGray600_1 => theme.textTheme.bodySmall!.copyWith(
        color: appTheme.gray600,
      );
  // Headline text style
  static get headlineSmallGray600 => theme.textTheme.headlineSmall!.copyWith(
        color: appTheme.gray600,
      );
  static get headlineSmallOnErrorContainer =>
      theme.textTheme.headlineSmall!.copyWith(
        color: theme.colorScheme.onErrorContainer,
        fontWeight: FontWeight.w700,
      );
  static get headlineSmallOnPrimary => theme.textTheme.headlineSmall!.copyWith(
        color: theme.colorScheme.onPrimary,
      );
  // Label text style
  static get labelLargeBluegray300 => theme.textTheme.labelLarge!.copyWith(
        color: appTheme.blueGray300,
      );
  static get labelLargeGray600 => theme.textTheme.labelLarge!.copyWith(
        color: appTheme.gray600,
      );
  static get labelLargeOnPrimaryContainer =>
      theme.textTheme.labelLarge!.copyWith(
        color: theme.colorScheme.onPrimaryContainer.withOpacity(1),
      );
  static get labelLargePrimaryContainer => theme.textTheme.labelLarge!.copyWith(
        color: theme.colorScheme.primaryContainer,
      );
  static get labelMediumOnPrimaryContainer =>
      theme.textTheme.labelMedium!.copyWith(
        color: theme.colorScheme.onPrimaryContainer.withOpacity(1),
      );
  static get labelMediumOrange900 => theme.textTheme.labelMedium!.copyWith(
        color: appTheme.orange900,
      );
  static get labelSmallBold => theme.textTheme.labelSmall!.copyWith(
        fontWeight: FontWeight.w700,
      );
  // Title text style
  static get titleMediumOnPrimary => theme.textTheme.titleMedium!.copyWith(
        color: theme.colorScheme.onPrimary,
        fontWeight: FontWeight.w600,
      );
  static get titleMediumPrimaryContainer =>
      theme.textTheme.titleMedium!.copyWith(
        color: theme.colorScheme.primaryContainer,
      );
  static get titleSmallMedium => theme.textTheme.titleSmall!.copyWith(
        fontWeight: FontWeight.w500,
      );
  static get titleSmallOnPrimaryContainer =>
      theme.textTheme.titleSmall!.copyWith(
        color: theme.colorScheme.onPrimaryContainer.withOpacity(1),
      );
}

extension on TextStyle {
  TextStyle get inter {
    return copyWith(
      fontFamily: 'Inter',
    );
  }
}

