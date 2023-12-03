import 'package:dpl_ecommerce/const/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// ignore: must_be_immutable
class ChipviewItemWidget extends StatelessWidget {
  ChipviewItemWidget({Key? key, required this.title})
      : super(
          key: key,
        );
  String title;

  @override
  Widget build(BuildContext context) {
    return RawChip(
      padding: EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 8,
      ),
      showCheckmark: false,
      labelPadding: EdgeInsets.zero,
      label: Text(
        title,
        style: TextStyle(
          color: theme.colorScheme.onPrimary,
          fontSize: 12,
          fontFamily: 'Inter',
          fontWeight: FontWeight.w500,
        ),
      ),
      selected: false,
      backgroundColor: theme.colorScheme.onPrimaryContainer.withOpacity(1),
      selectedColor: theme.colorScheme.primary,
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color: appTheme.blueGray300,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(
          4,
        ),
      ),
      onSelected: (value) {},
    );
  }
}
