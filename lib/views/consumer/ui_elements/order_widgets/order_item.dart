import 'package:dpl_ecommerce/const/app_decoration.dart';
import 'package:dpl_ecommerce/const/app_theme.dart';
import 'package:dpl_ecommerce/customs/custom_outline_button.dart';
import 'package:dpl_ecommerce/models/order_model.dart';
import 'package:dpl_ecommerce/models/ordering_product.dart';
import 'package:dpl_ecommerce/utils/constants/size_utils.dart';
import 'package:dpl_ecommerce/views/consumer/screens/detail_order.dart';
import 'package:dpl_ecommerce/views/consumer/screens/track_order.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyOrdersoneItemWidget extends StatelessWidget {
  MyOrdersoneItemWidget({Key? key, required this.order})
      : super(
          key: key,
        );
  Order? order;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.0.h),
      child: Container(
        //width: 100,
        //height: 200,
        padding: EdgeInsets.symmetric(
          horizontal: 11.w,
          vertical: 14.h,
        ),
        decoration: BoxDecoration(
          //shape: BoxShape.,
          color: Colors.white,
          // border: Border.all(
          //     color: Colors.grey,
          //     width: 2.0,
          //     style: BorderStyle.solid
          //   ),
          borderRadius: BorderRadius.circular(10.h),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              spreadRadius: 2.h,
              blurRadius: 2.h,
              offset: Offset(
                0,
                4,
              ),
            ),
          ],
        ),
        // decoration: AppDecoration.outlineGray.copyWith(
        //   borderRadius: BorderRadiusStyle.roundedBorder10,
        // ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 2.h),
            Padding(
              padding: EdgeInsets.only(
                left: 3.h,
                right: 3.h,
              ),
              child: Row(
                // mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "OrderID: " + order!.id!,
                    maxLines: 2,
                    style:
                        TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
            SizedBox(height: 14.h),
            Padding(
                padding: EdgeInsets.all(4.h),
                child: Text(
                  "11/13/2023",
                  style: TextStyle(fontSize: 14.sp),
                )),
            // Align(
            //   alignment: Alignment.centerLeft,
            //   child: Padding(
            //     padding: EdgeInsets.only(left: 13.h),
            //     child: Row(
            //       children: [
            //         Padding(
            //           padding: EdgeInsets.only(top: 1.h),
            //           child: Text(
            //             "Tracking number: ",
            //             // style: CustomTextStyles.titleSmallBluegray400,
            //           ),
            //         ),
            //         Padding(
            //           padding: EdgeInsets.only(left: 14.h),
            //           child: Text(
            //             order!.productID!,
            //             //style: theme.textTheme.titleSmall,
            //           ),
            //         ),
            //       ],
            //     ),
            //   ),
            // ),
            SizedBox(height: 14.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 6.h),
                  child: Text(
                    "Quanlity:",
                    style: TextStyle(fontSize: 14.sp),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: 10.h,
                    top: 5.h,
                  ),
                  child: Text(
                    order!.totalProduct.toString(),
                    style: TextStyle(fontSize: 14.sp),
                  ),
                ),
                Spacer(),
                Padding(
                  padding: EdgeInsets.only(
                    top: 2.h,
                    bottom: 3.h,
                  ),
                  child: Text(
                    "Subtotal:",
                    style: TextStyle(fontSize: 14.sp),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: 4.h,
                    bottom: 3.h,
                  ),
                  child: Text(
                    order!.totalCost.toString(),
                    style: TextStyle(fontSize: 14.sp),
                  ),
                ),
              ],
            ),
            SizedBox(height: 17.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Padding(
                //   padding: EdgeInsets.only(
                //     top: 9.h,
                //     bottom: 8.h,
                //   ),
                //   child: Text(
                //     "PENDING",
                //     //style: CustomTextStyles.titleSmallDeeporange800,
                //   ),
                // ),
                GestureDetector(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => TrackOrderScreen(
                              status: 2,
                            )
                        // OrderDetailScreen(order: order!),
                        ),
                  ),
                  child: Container(
                    //alignment: Alignment.bottomCenter,
                    child: Center(
                        child: Text(
                      "Detail",
                      style: TextStyle(fontSize: 14.sp, color: Colors.white),
                    )),
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(8)),
                    width: 120.w,
                    height: 40.h,

                    // text: "Details",
                    // buttonTextStyle: TextStyle(color: Colors.white),

                    // onPressed: () => OrderDetailScreen(),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
