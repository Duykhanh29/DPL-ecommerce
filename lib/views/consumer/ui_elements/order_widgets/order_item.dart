import 'package:dpl_ecommerce/const/app_decoration.dart';
import 'package:dpl_ecommerce/const/app_theme.dart';
import 'package:dpl_ecommerce/customs/custom_outline_button.dart';
import 'package:dpl_ecommerce/helpers/date_helper.dart';
import 'package:dpl_ecommerce/models/order_model.dart';
import 'package:dpl_ecommerce/models/ordering_product.dart';
import 'package:dpl_ecommerce/repositories/order_repo.dart';
import 'package:dpl_ecommerce/utils/constants/size_utils.dart';
import 'package:dpl_ecommerce/utils/lang/lang_text.dart';
import 'package:dpl_ecommerce/views/consumer/screens/order_detail.dart';
import 'package:dpl_ecommerce/views/consumer/screens/track_order.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OrderItem extends StatelessWidget {
  OrderItem({Key? key, required this.order})
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
          borderRadius: BorderRadius.circular(10.r),
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
                left: 3.w,
                right: 3.w,
              ),
              child: Text(
                "${LangText(context: context).getLocal()!.order_code_ucf}: ${order!.id!}",
                // maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600),
              ),
            ),
            SizedBox(height: 14.h),
            Padding(
                padding: EdgeInsets.all(4.h),
                child: Text(
                  order!.time != null
                      ? DateHelper.convertCommonDateTime(order!.time!)
                      : "",
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
            Padding(
              padding: EdgeInsets.all(4.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 6.h),
                    child: Text(
                      LangText(context: context).getLocal()!.quantity_ucf,
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
                      LangText(context: context).getLocal()!.decrease_ucf,
                      style: TextStyle(fontSize: 14.sp),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      left: 4.h,
                      bottom: 3.h,
                    ),
                    child: Text(
                      order!.shippingCost.toString(),
                      style: TextStyle(fontSize: 14.sp),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(4.h),
              child: Row(
                children: [
                  Text(
                    "${LangText(context: context).getLocal()!.total_price_ucf}:",
                    style: TextStyle(fontSize: 14.sp),
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  Text(
                    order!.totalCost.toString(),
                    style: TextStyle(fontSize: 14.sp),
                  )
                ],
              ),
            ),
            SizedBox(height: 17.h),
            GestureDetector(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => OrderDetailScreen(order: order!)),
              ),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
                alignment: Alignment.bottomRight,
                decoration: BoxDecoration(
                    color: Colors.blue, borderRadius: BorderRadius.circular(8)),
                // width: 120.w,
                // height: 40.h,
                child: Center(
                    child: Text(
                  LangText(context: context).getLocal()!.order_details_ucf,
                  style: TextStyle(fontSize: 14.sp, color: Colors.white),
                )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
