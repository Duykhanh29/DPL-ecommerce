import 'package:dpl_ecommerce/const/app_theme.dart';
import 'package:dpl_ecommerce/const/my_text_style.dart';
import 'package:dpl_ecommerce/customs/custom_array_back_widget.dart';
import 'package:flutter/material.dart';

class CustomAppBar {
  bool? centerTitle = true;
  String? title;
  BuildContext? context;
  Color? backgroundColor;
  bool isLeading;

  CustomAppBar(
      {this.title,
      this.context,
      this.centerTitle,
      this.backgroundColor,
      this.isLeading = true});

  AppBar show({var elevation = 5.0}) {
    return AppBar(
        // leadingWidth: 0.0,
        centerTitle: true,
        elevation: elevation,
        title: Text(
          title!,
          style: TextStyle(
              fontSize: 17, fontWeight: FontWeight.bold, color: MyTheme.white),
        ),
        backgroundColor: backgroundColor ?? MyTheme.accent_color,
        leading: isLeading ? CustomArrayBackWidget() : null);
  }
}
