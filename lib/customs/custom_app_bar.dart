import 'package:dpl_ecommerce/customs/custom_array_back_widget.dart';
import 'package:flutter/material.dart';

class CustomAppBar {
  bool? centerTitle = true;
  String? title;
  BuildContext? context;
  Color? backgroundColor;

  CustomAppBar({this.title, this.context, this.centerTitle});

  AppBar show({var elevation = 5.0}) {
    return AppBar(
        // leadingWidth: 0.0,
        centerTitle: true,
        elevation: elevation,
        title: Text(
          title!,
          // style: MyTextStyle().appbarText(),
        ),
        backgroundColor: backgroundColor ?? Colors.white,
        leading: CustomArrayBackWidget());
  }
}
