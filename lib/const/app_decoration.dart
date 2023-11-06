import 'package:dpl_ecommerce/utils/constants/size_utils.dart';
import 'package:flutter/material.dart';
import './app_theme.dart';

class AppDecoration {
  // Fill decorations
  static BoxDecoration get fillAmber => BoxDecoration(
        color: appTheme.amber700,
      );
  static BoxDecoration get fillErrorContainer => BoxDecoration(
        color: theme.colorScheme.errorContainer,
      );
  static BoxDecoration get fillOnPrimaryContainer => BoxDecoration(
        color: theme.colorScheme.onPrimaryContainer.withOpacity(1),
      );
  static BoxDecoration get fillOrange => BoxDecoration(
        color: appTheme.orange900,
      );
  static BoxDecoration get fillRed => BoxDecoration(
        color: appTheme.red500,
      );

  // Gradient decorations
  static BoxDecoration get gradientGrayToGray => BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment(-0.1, -0.04),
          end: Alignment(1.11, 1.06),
          colors: [
            appTheme.gray50,
            appTheme.gray20001,
          ],
        ),
      );

  // Outline decorations
  static BoxDecoration get outlineBlueGray => BoxDecoration(
        color: theme.colorScheme.onPrimaryContainer.withOpacity(1),
        border: Border.all(
          color: appTheme.blueGray100,
          width: 1.h,
          strokeAlign: strokeAlignOutside,
        ),
      );
  static BoxDecoration get outlineBlueGrayF => BoxDecoration(
        color: theme.colorScheme.onPrimaryContainer.withOpacity(1),
        boxShadow: [
          BoxShadow(
            color: appTheme.blueGray7000f,
            spreadRadius: 2.h,
            blurRadius: 2.h,
            offset: Offset(
              0,
              6,
            ),
          ),
        ],
      );
  static BoxDecoration get outlineBluegray7000f => BoxDecoration(
        color: theme.colorScheme.onPrimaryContainer.withOpacity(1),
        boxShadow: [
          BoxShadow(
            color: appTheme.blueGray7000f,
            spreadRadius: 2.h,
            blurRadius: 2.h,
            offset: Offset(
              0,
              0,
            ),
          ),
        ],
      );
  static BoxDecoration get outlineBluegray7000f1 => BoxDecoration(
        color: theme.colorScheme.onPrimaryContainer.withOpacity(1),
        boxShadow: [
          BoxShadow(
            color: appTheme.blueGray7000f,
            spreadRadius: 2.h,
            blurRadius: 2.h,
            offset: Offset(
              0,
              8,
            ),
          ),
        ],
      );
}

class BorderRadiusStyle {
  // Custom borders
  static BorderRadius get customBorderTL16 => BorderRadius.vertical(
        top: Radius.circular(16.h),
      );

  // Rounded borders
  static BorderRadius get roundedBorder2 => BorderRadius.circular(
        2.h,
      );
  static BorderRadius get roundedBorder8 => BorderRadius.circular(
        8.h,
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
