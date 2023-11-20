import 'package:dpl_ecommerce/const/app_theme.dart';
import 'package:dpl_ecommerce/customs/custom_elevate_button.dart';
import 'package:dpl_ecommerce/customs/custom_image_view.dart';
import 'package:dpl_ecommerce/customs/custom_text_style.dart';
import 'package:dpl_ecommerce/utils/constants/size_utils.dart';

import 'package:flutter/material.dart';

class CheckOutScreen extends StatelessWidget {
  const CheckOutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    return 
         Scaffold(
            appBar:AppBar(
          backgroundColor: Colors.blue,
          title: Text(
            "Checkout",
            textAlign: TextAlign.center,
          ),
          centerTitle: true,

          //leading: Icon(Icons.menu),
        ),
            body: Container(
                width: double.maxFinite,
                padding: EdgeInsets.symmetric(horizontal: 30.h, vertical: 12.v),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomImageView(
                          imagePath: ImageConstant.imgProcess,
                          height: 22.v,
                          width: 266.h,
                          alignment: Alignment.center),
                      SizedBox(height: 45.v),
                      Text("Order Completed",
                          style: theme.textTheme.headlineSmall),
                      SizedBox(height: 81.v),
                      CustomImageView(
                          imagePath: ImageConstant.imgGroup,
                          height: 110.v,
                          width: 101.h,
                          alignment: Alignment.center),
                      SizedBox(height: 57.v),
                      Container(
                          width: 270.h,
                          margin: EdgeInsets.only(left: 17.h, right: 30.h),
                          child: Text(
                              "Thank you for your purchase.\nYou can view your order in ‘My Orders’ section.",
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.center,
                              style: CustomTextStyles.bodyMediumOnError
                                  .copyWith(height: 1.67))),
                      const Spacer(flex: 50),
                      CustomElevatedButton(text: "Continue shopping",height: 50,buttonTextStyle: TextStyle(fontSize: 20),),
                     const Spacer(flex: 20)
                    ])));
  }

}
class ImageConstant {
  // Image folder path
  static String imagePath = 'assets/images';
  static String imgGroup = '$imagePath/img_group.svg';
  //static String imgArrowLeft = '$imagePath/img_arrow_left.svg';

  // check out-Three images
  static String imgProcess = '$imagePath/img_process.svg';
}
