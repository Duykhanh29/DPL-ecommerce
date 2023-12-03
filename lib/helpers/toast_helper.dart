import 'package:dpl_ecommerce/const/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ToastHelper {
  static showDialog(String msg,
      {duration = 0,
      gravity = 0,
      textStyle = const TextStyle(color: MyTheme.font_grey),
      Color bgColor = const Color.fromRGBO(239, 239, 239, .9)}) {
    Fluttertoast.showToast(
      msg: msg,
      toastLength: duration != 0 ? duration : Toast.LENGTH_LONG,
      gravity: gravity != 0 ? gravity : ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: bgColor,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }
}
