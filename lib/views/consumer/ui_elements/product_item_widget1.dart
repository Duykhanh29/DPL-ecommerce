import 'package:dpl_ecommerce/const/app_decoration.dart';
import 'package:dpl_ecommerce/customs/custom_image_view.dart';
import 'package:dpl_ecommerce/customs/custom_text_style.dart';
import 'package:dpl_ecommerce/utils/constants/image_data.dart';
import 'package:dpl_ecommerce/utils/constants/size_utils.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ProductItemWidget extends StatelessWidget {
  const ProductItemWidget({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomImageView(
          imagePath: ImageData.imgFrame140x140,
          height: 150.adaptSize,
          width: 150.adaptSize,
          radius: BorderRadius.circular(
            4.h,
          ),
        ),
        SizedBox(height: 9.v),
        Text(
          "Name product",
          style: CustomTextStyles.bodyMediumPrimaryContainer,
        ),
        SizedBox(height: 8.v),
        Container(
          width: 80.h,
          padding: EdgeInsets.symmetric(
            horizontal: 4.h,
            vertical: 2.v,
          ),
          decoration: AppDecoration.fillRed.copyWith(
            borderRadius: BorderRadiusStyle.roundedBorder2,
          ),
          child: Text(
            "lbl_upto_40_off",
            style: CustomTextStyles.labelLargeOnPrimaryContainer,
          ),
        ),
      ],
    );
  }
}
