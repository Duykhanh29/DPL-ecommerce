import 'package:dpl_ecommerce/const/app_theme.dart';
import 'package:dpl_ecommerce/customs/custom_icon_button.dart';
import 'package:dpl_ecommerce/customs/custom_image_view.dart';
import 'package:dpl_ecommerce/models/category.dart';
import 'package:dpl_ecommerce/utils/constants/image_data.dart';
import 'package:dpl_ecommerce/utils/constants/size_utils.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CategoryItemWidget extends StatelessWidget {
  CategoryItemWidget({Key? key, required this.category})
      : super(
          key: key,
        );
  Category? category;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // go to this category page
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 5.h),
        width: 58.h,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 2.v),
            CustomIconButton(
              height: 50.adaptSize,
              width: 50.adaptSize,
              padding: EdgeInsets.all(9.h),
              decoration: IconButtonStyleHelper.fillGray,
              child: CustomImageView(
                imagePath: category!.logo!,
              ),
            ),
            SizedBox(height: 5.v),
            Text(
              category!.name!,
              style: theme.textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }
}
