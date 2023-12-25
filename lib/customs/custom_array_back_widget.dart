import 'package:dpl_ecommerce/const/app_theme.dart';
import 'package:flutter/material.dart';

class CustomArrayBackWidget extends StatelessWidget {
  CustomArrayBackWidget({super.key, this.function});
  Function? function;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(100)),
      child: InkWell(
        onTap: () {
          if (function != null) {
            function!();
          }
          Navigator.of(context).pop();
        },
        child: Icon(
          Icons.arrow_back_ios,
          color: MyTheme.white,
        ),
      ),
    );
  }
}
