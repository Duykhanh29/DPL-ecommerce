import 'package:dpl_ecommerce/const/app_decoration.dart';
import 'package:dpl_ecommerce/const/app_theme.dart';
import 'package:dpl_ecommerce/customs/custom_app_bar.dart';
import 'package:dpl_ecommerce/customs/custom_image_view.dart';
import 'package:dpl_ecommerce/customs/custom_text_style.dart';
import 'package:dpl_ecommerce/helpers/date_helper.dart';
import 'package:dpl_ecommerce/models/deliver_service.dart';
import 'package:dpl_ecommerce/models/order_model.dart';
import 'package:dpl_ecommerce/models/ordering_product.dart';
import 'package:dpl_ecommerce/models/payment_type.dart';
import 'package:dpl_ecommerce/repositories/deliver_service_repo.dart';
import 'package:dpl_ecommerce/repositories/order_repo.dart';
import 'package:dpl_ecommerce/repositories/payment_repo.dart';
import 'package:dpl_ecommerce/utils/constants/image_data.dart';
import 'package:dpl_ecommerce/utils/constants/size_utils.dart';
import 'package:dpl_ecommerce/utils/lang/lang_text.dart';
import 'package:dpl_ecommerce/view_model/user_view_model.dart';
import 'package:dpl_ecommerce/views/consumer/screens/rate_screen.dart';
import 'package:dpl_ecommerce/views/consumer/screens/track_order.dart';
import 'package:dpl_ecommerce/views/consumer/ui_elements/order_widgets/list_order_item.dart';
import 'package:dpl_ecommerce/views/consumer/ui_elements/order_widgets/ordering_product_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:timeline_list/timeline_model.dart';
import 'package:timeline_list/timeline.dart';
//import 'dart:html';

class OrderingProductDetailScreen extends StatelessWidget {
  OrderingProductDetailScreen(
      {Key? key, required this.order, required this.orderID})
      : super(key: key);
  // String orderID;
  final OrderingProduct order;
  final String orderID;
  String buildText(BuildContext context, int index) {
    if (index == 1) {
      return LangText(context: context)
          .getLocal()!
          .your_order_is_waiting_confirmation;
    } else if (index == 2) {
      return LangText(context: context)
          .getLocal()!
          .your_order_has_been_confirmed;
    } else if (index == 3) {
      return LangText(context: context).getLocal()!.your_order_is_delivered;
    }
    return LangText(context: context).getLocal()!.your_order_has_been_delivered;
  }

  OrderRepo orderRepo = OrderRepo();

  @override
  Widget build(BuildContext context) {
    int? status;
    if (order.deliverStatus == DeliverStatus.processing) {
      status = 1;
    } else if (order.deliverStatus == DeliverStatus.confirmed) {
      status = 2;
    } else if (order.deliverStatus == DeliverStatus.delivering) {
      status = 3;
    } else if (order.deliverStatus == DeliverStatus.delivered) {
      status = 4;
    }
    return SafeArea(
      child: Scaffold(
          //backgroundColor: appTheme.gray5001,
          appBar: CustomAppBar(
                  backgroundColor: MyTheme.accent_color,
                  title:
                      LangText(context: context).getLocal()!.order_details_ucf,
                  context: context,
                  centerTitle: true)
              .show(),
          body: Padding(
            padding: EdgeInsets.only(bottom: 8.h, top: 1.h),
            child: SingleChildScrollView(
              child: Container(
                height: MediaQuery.of(context).size.height,
                child: Column(
                  // alignment: Alignment.topCenter,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 20.w,
                    ),
                    Padding(
                        padding:
                            EdgeInsets.only(left: 10.h, top: 3.h, bottom: 2.h),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 10.h,
                              ),
                              Text(
                                buildText(context, status!),
                                style: TextStyle(
                                    color: Colors.black, fontSize: 18.sp),
                                //style: CustomTextStyles.titleMediumNunitoOnPrimary
                              ),
                              SizedBox(height: 10.h),
                              if (status == 4)
                                Text(
                                  LangText(context: context)
                                      .getLocal()!
                                      .rate_product_to_get_points,
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 16.sp),
                                  textAlign: TextAlign.center,
                                  softWrap: true,

                                  maxLines: 7,
                                  //style: theme.textTheme.labelMedium
                                ),
                              SizedBox(height: 10.h),
                            ])),
                    OrderingProductItem(
                      orderingProduct: order,
                      orderID: orderID,
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: Text(
                        LangText(context: context).getLocal()!.track_orders,
                        style: TextStyle(color: Colors.black, fontSize: 16.sp),
                      ),
                    ),
                    buildTrackTime(context, status!),
                    if (status == 3) buildConfirmButton(context),
                    if (status == 4) buildRateButton(context)
                  ],
                ),
              ),
            ),
          )),
    );
  }

  Widget buildConfirmButton(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        await orderRepo.updateOrderingProductStatus(
            orderID: orderID,
            orderingProductID: order.id!,
            status: DeliverStatus.delivered);
        Navigator.of(context).pop();
      },
      child: Center(
        child: Container(
          alignment: Alignment.bottomCenter,
          decoration: BoxDecoration(
              color: MyTheme.accent_color,
              borderRadius: BorderRadius.circular(8.r)),
          width: MediaQuery.of(context).size.width * 0.9,
          height: MediaQuery.of(context).size.height * 0.06,
          child: Center(
            child: Text(
              LangText(context: context).getLocal()!.mark_as_delivered,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16.sp, color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildRateButton(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => RatingScreen(productID: order.productID!),
        ),
      ),
      child: Center(
        child: Container(
          alignment: Alignment.bottomCenter,
          decoration: BoxDecoration(
              color: MyTheme.accent_color,
              borderRadius: BorderRadius.circular(8.r)),
          width: MediaQuery.of(context).size.width * 0.9,
          height: MediaQuery.of(context).size.height * 0.06,
          child: Center(
            child: Text(
              LangText(context: context).getLocal()!.rate_ucf,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16.sp, color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildTrackTime(BuildContext context, int status) {
    return Container(
      decoration: BoxDecoration(border: Border.all(color: Colors.red)),
      height: MediaQuery.of(context).size.height * 0.52,
      margin: EdgeInsets.symmetric(vertical: 10.h, horizontal: 20.w),
      child: Timeline(position: TimelinePosition.Left, children: [
        TimelineModel(
            Padding(
              padding: EdgeInsets.only(left: 10.w),
              child: Container(
                width: 150.w,
                // decoration: BoxDecoration(color: Colors.red),
                height: 100,
                child: Center(
                    child: Text(
                        LangText(context: context).getLocal()!.processing)),
              ),
            ),
            // isFirst: true,
            iconBackground: status < 1 ? Colors.grey : Colors.blue),
        TimelineModel(
            Padding(
              padding: EdgeInsets.only(left: 10.w),
              child: Container(
                width: 150.w,
                // decoration: BoxDecoration(color: Colors.red),
                height: 100,
                child: Center(
                  child: Text(
                      LangText(context: context).getLocal()!.confirmed_ucf),
                ),
              ),
            ),
            iconBackground: status < 2 ? Colors.grey : Colors.blue),
        TimelineModel(
            Padding(
              padding: EdgeInsets.only(left: 10.w),
              child: Container(
                width: 150.w,
                // decoration: BoxDecoration(color: Colors.red),
                height: 100,
                child: Center(
                  child:
                      Text(LangText(context: context).getLocal()!.delivering),
                ),
              ),
            ),
            iconBackground: status < 3 ? Colors.grey : Colors.blue),
        TimelineModel(
            Padding(
              padding: EdgeInsets.only(left: 10.w),
              child: Container(
                width: 150.w,
                // decoration: BoxDecoration(color: Colors.red),
                height: 100,
                child: Center(
                  child: Text(
                      LangText(context: context).getLocal()!.delivered_ucf),
                ),
              ),
            ),
            position: TimelineItemPosition.left,
            isLast: true,
            iconBackground: status < 4 ? Colors.grey : Colors.blue),
      ]),
    );
  }
}
