import 'dart:ui';
import 'package:dpl_ecommerce/utils/constants/size_utils.dart';
import 'package:flutter/material.dart';

String _appTheme = "primary";

/// Helper class for managing themes and colors.
class AppTheme {
  // A map of custom color themes supported by the app
  Map<String, PrimaryColors> _supportedCustomColor = {
    'primary': PrimaryColors()
  };

// A map of color schemes supported by the app
  Map<String, ColorScheme> _supportedColorScheme = {
    'primary': ColorSchemes.primaryColorScheme
  };

  /// Changes the app theme to [_newTheme].
  void changeTheme(String _newTheme) {
    _appTheme = _newTheme;
  }

  /// Returns the primary colors for the current theme.
  PrimaryColors _getThemeColors() {
    //throw exception to notify given theme is not found or not generated by the generator
    if (!_supportedCustomColor.containsKey(_appTheme)) {
      throw Exception(
          "$_appTheme is not found.Make sure you have added this theme class in JSON Try running flutter pub run build_runner");
    }
    //return theme from map

    return _supportedCustomColor[_appTheme] ?? PrimaryColors();
  }

  /// Returns the current theme data.
  ThemeData _getThemeData() {
    //throw exception to notify given theme is not found or not generated by the generator
    if (!_supportedColorScheme.containsKey(_appTheme)) {
      throw Exception(
          "$_appTheme is not found.Make sure you have added this theme class in JSON Try running flutter pub run build_runner");
    }
    //return theme from map

    var colorScheme =
        _supportedColorScheme[_appTheme] ?? ColorSchemes.primaryColorScheme;
    return ThemeData(
      visualDensity: VisualDensity.standard,
      colorScheme: colorScheme,
      textTheme: TextThemes.textTheme(colorScheme),
      scaffoldBackgroundColor: colorScheme.onPrimaryContainer.withOpacity(1),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: appTheme.deepOrange800,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(2.h),
          ),
          visualDensity: const VisualDensity(
            vertical: -4,
            horizontal: -4,
          ),
          padding: EdgeInsets.zero,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          backgroundColor: Colors.transparent,
          side: BorderSide(
            color: colorScheme.primaryContainer,
            width: 1.h,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4.h),
          ),
          visualDensity: const VisualDensity(
            vertical: -4,
            horizontal: -4,
          ),
          padding: EdgeInsets.zero,
        ),
      ),
      dividerTheme: DividerThemeData(
        thickness: 1,
        space: 1,
        color: appTheme.gray200,
      ),
    );
  }

  /// Returns the primary colors for the current theme.
  PrimaryColors themeColor() => _getThemeColors();

  /// Returns the current theme data.
  ThemeData themeData() => _getThemeData();
}

/// Class containing the supported text theme styles.
class TextThemes {
  static TextTheme textTheme(ColorScheme colorScheme) => TextTheme(
        bodyLarge: TextStyle(
          color: appTheme.blueGray300,
          fontSize: 16.fSize,
          fontFamily: 'Inter',
          fontWeight: FontWeight.w400,
        ),
        bodyMedium: TextStyle(
          color: colorScheme.onPrimary,
          fontSize: 14.fSize,
          fontFamily: 'Inter',
          fontWeight: FontWeight.w400,
        ),
        bodySmall: TextStyle(
          color: colorScheme.onPrimary,
          fontSize: 12.fSize,
          fontFamily: 'Inter',
          fontWeight: FontWeight.w400,
        ),
        headlineSmall: TextStyle(
          color: appTheme.black900,
          fontSize: 24.fSize,
          fontFamily: 'Inter',
          fontWeight: FontWeight.w500,
        ),
        labelLarge: TextStyle(
          color: colorScheme.onPrimary,
          fontSize: 12.fSize,
          fontFamily: 'Inter',
          fontWeight: FontWeight.w500,
        ),
        labelMedium: TextStyle(
          color: appTheme.blueGray300,
          fontSize: 10.fSize,
          fontFamily: 'Inter',
          fontWeight: FontWeight.w500,
        ),
        labelSmall: TextStyle(
          color: colorScheme.onPrimaryContainer.withOpacity(1),
          fontSize: 8.fSize,
          fontFamily: 'Inter',
          fontWeight: FontWeight.w600,
        ),
        titleLarge: TextStyle(
          color: colorScheme.onPrimary,
          fontSize: 20.fSize,
          fontFamily: 'Inter',
          fontWeight: FontWeight.w500,
        ),
        titleMedium: TextStyle(
          color: colorScheme.onPrimaryContainer.withOpacity(1),
          fontSize: 16.fSize,
          fontFamily: 'Inter',
          fontWeight: FontWeight.w500,
        ),
        titleSmall: TextStyle(
          color: colorScheme.onPrimary,
          fontSize: 14.fSize,
          fontFamily: 'Inter',
          fontWeight: FontWeight.w600,
        ),
      );
}

/// Class containing the supported color schemes.
class ColorSchemes {
  static final primaryColorScheme = ColorScheme.light(
    // Primary colors
    primary: Color(0XFFF9FAFB),
    primaryContainer: Color(0XFF1D4ED8),

    // Error colors
    errorContainer: Color(0XFF10B981),
    onError: Color(0XFFFFE0B7),
    onErrorContainer: Color(0XFF3E1304),

    // On colors(text colors)
    onPrimary: Color(0XFF1F2937),
    onPrimaryContainer: Color(0XA3FFFFFF),
    
  );
}

/// Class containing custom colors for a primary theme.
class PrimaryColors {
  // Amber
  Color get amber700 => Color(0XFFF59E0B);

  // Black
  Color get black900 => Color(0XFF000000);

  // BlueGray
  Color get blueGray100 => Color(0XFFD1D5DB);
  Color get blueGray300 => Color(0XFF9CA3AF);

  // BlueGrayf
  Color get blueGray7000f => Color(0X0F4B5563);

  // DeepOrange
  Color get deepOrange800 => Color(0XFFCC6522);

  // Gray
  Color get gray100 => Color(0XFFF3F4F6);
  Color get gray10001 => Color(0XFFEFF6FF);
  Color get gray10002 => Color(0XFFECFDF5);
  Color get gray200 => Color(0XFFE5E7EB);
  Color get gray20001 => Color(0XFFEBEDEE);
  Color get gray50 => Color(0XFFFDFBFB);
  Color get gray600 => Color(0XFF6B7280);
  Color get black90033 => Color(0X330E0E0E);
  Color get gray800 => Color(0XFF474340);
  Color get blue50 => Color(0XFFEAEFFF);

  // BlueGray
  

  // Pink
  Color get pink300 => Color(0XFFFB7181);
  // LightBlue
  Color get lightBlue50 => Color(0XFFECFEFF);

  // Orange
  Color get orange900 => Color(0XFFEA580C);

  // Red
  Color get red500 => Color(0XFFEF4444);

  // Yellow
  Color get yellow50 => Color(0XFFFFF7ED);
}

PrimaryColors get appTheme => AppTheme().themeColor();
ThemeData get theme => AppTheme().themeData();
