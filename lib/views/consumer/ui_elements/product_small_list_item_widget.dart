import 'package:dpl_ecommerce/const/app_decoration.dart';
import 'package:dpl_ecommerce/const/app_theme.dart';
import 'package:dpl_ecommerce/customs/custom_icon_button.dart';
import 'package:dpl_ecommerce/customs/custom_image_view.dart';
import 'package:dpl_ecommerce/customs/custom_text_style.dart';
import 'package:dpl_ecommerce/models/product.dart';
import 'package:dpl_ecommerce/utils/constants/image_data.dart';
import 'package:dpl_ecommerce/utils/constants/size_utils.dart';
import 'package:dpl_ecommerce/views/consumer/screens/product_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// ignore: must_be_immutable
class ProductsmalllistItemWidget extends StatelessWidget {
  ProductsmalllistItemWidget({Key? key, required this.product})
      : super(
          key: key,
        );
  Product? product;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print("Product");
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => ProductDetailsPage(product: product),
        ));
      },
      child: SizedBox(
        width: 170.h,
        child: Padding(
          padding: EdgeInsets.only(bottom: 1.h),
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
                    image: NetworkImage(
                      product!.images![0],
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
                      margin: EdgeInsets.only(bottom: 77.h),
                      padding: EdgeInsets.symmetric(
                        horizontal: 4.h,
                        vertical: 2.h,
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
                        bottom: 72.h,
                      ),
                      child: CustomIconButton(
                        height: 24.h,
                        width: 24.h,
                        padding: EdgeInsets.all(4.h),
                        child: CustomImageView(
                          imagePath: ImageData.imgFavourite,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 8.h),
              Container(
                padding: const EdgeInsets.only(left: 8),
                width: 147.h,
                child: Text(
                  product!.name!,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.displayLarge!.copyWith(
                    height: 1.50,
                  ),
                ),
              ),
              SizedBox(height: 10.h),
              Container(
                padding: const EdgeInsets.only(left: 8, right: 8),
                child: Row(
                  children: [
                    Container(
                      height: 16.h,
                      width: 16.h,
                      padding: EdgeInsets.all(2.h),
                      decoration: AppDecoration.fillAmber.copyWith(
                        borderRadius: BorderRadiusStyle.roundedBorder2,
                      ),
                      child: CustomImageView(
                        imagePath: ImageData.imgIconBoldStar,
                        height: 12.h,
                        width: 12.h,
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
              SizedBox(height: 9.h),
              Container(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text(
                    "${product!.price} VND",
                    style: theme.textTheme.displayLarge,
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
