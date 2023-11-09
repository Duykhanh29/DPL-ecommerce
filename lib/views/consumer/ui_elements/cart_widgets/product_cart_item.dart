import 'package:dpl_ecommerce/const/app_decoration.dart';
import 'package:dpl_ecommerce/customs/custom_image_view.dart';
import 'package:dpl_ecommerce/customs/custom_text_style.dart';
import 'package:dpl_ecommerce/utils/constants/image_data.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ProductCartItem extends StatelessWidget {
  const ProductCartItem({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 14),
      decoration: AppDecoration.outlineBlueGray.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder2,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          CustomImageView(
            imagePath: ImageData.imgFrame48x48,
            height: 72,
            width: 72,
            radius: BorderRadius.circular(
              5,
            ),
          ),
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 150,
                    child: Text(
                      "Name product",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: CustomTextStyles.labelLargeBluegray300.copyWith(
                        height: 1.50,
                      ),
                    ),
                  ),
                  CustomImageView(
                    imagePath: ImageData.imgFrame4,
                    height: 24,
                    width: 24,
                    margin: EdgeInsets.only(
                      left: 20,
                      bottom: 11,
                    ),
                  ),
                  CustomImageView(
                    imagePath: ImageData.imgFrame3,
                    height: 24,
                    width: 24,
                    margin: EdgeInsets.only(
                      left: 8,
                      bottom: 11,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12),
              SizedBox(
                width: 227,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 6),
                      child: Text(
                        "Price: 120000VND",
                        style: CustomTextStyles.labelLargeBluegray300,
                      ),
                    ),
                    Spacer(),
                    SizedBox(
                      height: 24,
                      width: 32,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          CustomImageView(
                            imagePath: ImageData.imgFrame2,
                            height: 24,
                            width: 32,
                            alignment: Alignment.center,
                          ),
                          CustomImageView(
                            imagePath: ImageData.imgFrame1,
                            height: 16,
                            width: 16,
                            alignment: Alignment.center,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: 40,
                      padding: EdgeInsets.symmetric(
                        horizontal: 18,
                        vertical: 2,
                      ),
                      decoration: AppDecoration.outlineBlueGray,
                      child: Text(
                        "lbl_1",
                        style: CustomTextStyles.bodyMediumGray600,
                      ),
                    ),
                    SizedBox(
                      height: 24,
                      width: 32,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          CustomImageView(
                            imagePath: ImageData.imgFrame140x140,
                            height: 24,
                            width: 32,
                            alignment: Alignment.center,
                          ),
                          CustomImageView(
                            imagePath: ImageData.imgFrame1,
                            height: 16,
                            width: 16,
                            alignment: Alignment.center,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
