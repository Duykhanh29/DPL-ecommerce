import 'package:dpl_ecommerce/const/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ToastHelper {
  static showDialog(String msg,
      {duration = 0,
      gravity = 0,
      textStyle = const TextStyle(color: MyTheme.font_grey),
      Color bgColor = Colors.cyan}) {
    Fluttertoast.showToast(
      msg: msg,
      toastLength: duration != 0 ? duration : Toast.LENGTH_LONG,
      gravity: gravity != 0 ? gravity : ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: bgColor,
      textColor: Colors.black,
      fontSize: 16.0,
    );
  }
}
