import 'package:dpl_ecommerce/const/app_decoration.dart';
import 'package:dpl_ecommerce/customs/custom_image_view.dart';
import 'package:dpl_ecommerce/customs/custom_text_style.dart';
import 'package:dpl_ecommerce/models/product.dart';
import 'package:dpl_ecommerce/utils/constants/image_data.dart';
import 'package:dpl_ecommerce/utils/constants/size_utils.dart';
import 'package:dpl_ecommerce/views/consumer/screens/product_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// ignore: must_be_immutable
class ProductItemWidget extends StatelessWidget {
  ProductItemWidget({Key? key, required this.product})
      : super(
          key: key,
        );
  Product? product;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => ProductDetailsPage(product: product),
        ));
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 1.w, vertical: 1.h),
        decoration:
            BoxDecoration(border: Border.all(color: Colors.black, width: 0.1)),
        height: 170.h,
        width: 145.w,
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(2.h),
              child: Image.network(
                product!.images![0],
                width: 125.w,
                height: 140.h,
              ),
            ),
            SizedBox(height: 9.h),
            Text(
              product!.name!,
              style: CustomTextStyles.bodyMediumPrimaryContainer,
            ),
            SizedBox(height: 8.h),
            Container(
              width: 80.h,
              padding: EdgeInsets.symmetric(
                horizontal: 4.h,
                vertical: 2.h,
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
        ),
      ),
    );
  }
}
