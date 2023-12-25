import 'package:dpl_ecommerce/const/app_theme.dart';
import 'package:flutter/material.dart';

class MyTextStyle1 {
  static TextStyle buildAppBarTexStyle() {
    return TextStyle(
        fontSize: 20, color: MyTheme.black, fontWeight: FontWeight.w700);
  }

  static TextStyle largeTitleTexStyle() {
    return TextStyle(
        fontSize: 16,
        color: MyTheme.dark_font_grey,
        fontWeight: FontWeight.w700);
  }

  static TextStyle smallTitleTexStyle() {
    return TextStyle(
        fontSize: 13,
        color: MyTheme.dark_font_grey,
        fontWeight: FontWeight.w700);
  }

  static TextStyle verySmallTitleTexStyle() {
    return TextStyle(
        fontSize: 10,
        color: MyTheme.dark_font_grey,
        fontWeight: FontWeight.normal);
  }

  static TextStyle largeBoldAccentTexStyle() {
    return TextStyle(
        fontSize: 16, color: MyTheme.accent_color, fontWeight: FontWeight.w700);
  }

  static TextStyle smallBoldAccentTexStyle() {
    return TextStyle(
        fontSize: 13, color: MyTheme.accent_color, fontWeight: FontWeight.w700);
  }

  static TextStyle titleTexStyle() {
    return TextStyle(
        fontSize: 16,
        color: MyTheme.dark_font_grey,
        fontWeight: FontWeight.w500);
  }

  TextStyle? appBarText() {
    return TextStyle(
        fontSize: 17, fontWeight: FontWeight.bold, color: MyTheme.white);
  }

  static TextStyle alertTitleText() {
    return TextStyle(
        fontSize: 14, fontWeight: FontWeight.w500, color: MyTheme.accent_color);
  }

  static TextStyle alertButtonText() {
    return TextStyle(
        fontSize: 14, fontWeight: FontWeight.bold, color: MyTheme.accent_color);
  }
}
