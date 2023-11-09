import 'package:dpl_ecommerce/const/app_decoration.dart';
import 'package:dpl_ecommerce/const/app_theme.dart';
import 'package:dpl_ecommerce/customs/custom_icon_button.dart';
import 'package:dpl_ecommerce/customs/custom_image_view.dart';
import 'package:dpl_ecommerce/customs/custom_text_style.dart';
import 'package:dpl_ecommerce/utils/constants/image_data.dart';
import 'package:dpl_ecommerce/utils/constants/size_utils.dart';
import 'package:dpl_ecommerce/views/consumer/ui_elements/product_details_widgets/product_detail_page.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ProductsmalllistItemWidget extends StatelessWidget {
  const ProductsmalllistItemWidget({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print("Product");
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => ProductDetailsPage(),
        ));
      },
      child: SizedBox(
        width: 170.h,
        child: Padding(
          padding: EdgeInsets.only(bottom: 1.v),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 150.h,
                height: 120.h,
                padding: EdgeInsets.all(4.h),
                decoration: BoxDecoration(
                  borderRadius: BorderRadiusStyle.roundedBorder2,
                  image: DecorationImage(
                    image: AssetImage(
                      ImageData.imgFrame7,
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 56.h,
                      margin: EdgeInsets.only(bottom: 77.v),
                      padding: EdgeInsets.symmetric(
                        horizontal: 4.h,
                        vertical: 2.v,
                      ),
                      decoration: AppDecoration.fillOrange.copyWith(
                        borderRadius: BorderRadiusStyle.roundedBorder2,
                      ),
                      child: Text(
                        "top_seller",
                        style: CustomTextStyles.labelMediumOnPrimaryContainer,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        left: 60.h,
                        bottom: 72.v,
                      ),
                      child: CustomIconButton(
                        height: 24.adaptSize,
                        width: 24.adaptSize,
                        padding: EdgeInsets.all(4.h),
                        child: CustomImageView(
                          imagePath: ImageData.imgFavourite,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 8.v),
              Container(
                padding: const EdgeInsets.only(left: 8),
                width: 147.h,
                child: Text(
                  "Name product",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.displayLarge!.copyWith(
                    height: 1.50,
                  ),
                ),
              ),
              SizedBox(height: 10.v),
              Container(
                padding: const EdgeInsets.only(left: 8, right: 8),
                child: Row(
                  children: [
                    Container(
                      height: 16.adaptSize,
                      width: 16.adaptSize,
                      padding: EdgeInsets.all(2.h),
                      decoration: AppDecoration.fillAmber.copyWith(
                        borderRadius: BorderRadiusStyle.roundedBorder2,
                      ),
                      child: CustomImageView(
                        imagePath: ImageData.imgIconBoldStar,
                        height: 12.adaptSize,
                        width: 12.adaptSize,
                        alignment: Alignment.center,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 4.h),
                      child: Text(
                        "lbl_4_8",
                        style: theme.textTheme.bodySmall,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 4.h),
                      child: Text(
                        "lbl_692",
                        style: CustomTextStyles.bodySmallGray600,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 9.v),
              Container(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text(
                    "12345VND",
                    style: theme.textTheme.displayLarge,
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
