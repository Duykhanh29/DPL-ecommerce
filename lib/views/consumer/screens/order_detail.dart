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
import 'package:dpl_ecommerce/repositories/payment_repo.dart';
import 'package:dpl_ecommerce/utils/constants/image_data.dart';
import 'package:dpl_ecommerce/utils/constants/size_utils.dart';
import 'package:dpl_ecommerce/utils/lang/lang_text.dart';
import 'package:dpl_ecommerce/view_model/user_view_model.dart';
import 'package:dpl_ecommerce/views/consumer/screens/rate_screen.dart';
import 'package:dpl_ecommerce/views/consumer/screens/track_order.dart';
import 'package:dpl_ecommerce/views/consumer/ui_elements/order_widgets/list_order_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
//import 'dart:html';

class OrderDetailScreen extends StatelessWidget {
  OrderDetailScreen({Key? key, required this.order}) : super(key: key);
  // String orderID;
  final Order order;

  @override
  Widget build(BuildContext context) {
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
          //  AppBar(
          //   backgroundColor: Colors.blue,
          //   title: Text(
          //    ,
          //     textAlign: TextAlign.center,
          //   ),
          //   centerTitle: true,

          //   //leading: Icon(Icons.menu),
          // ),
          body: Padding(
            padding: EdgeInsets.only(bottom: 8.h, top: 1.h),
            child: Container(
              height: MediaQuery.of(context).size.height,
              child: Column(
                // alignment: Alignment.topCenter,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: DetailBody(
                      list: order.orderingProductsID!,
                      deliverServiceID: order.deliverServiceID!,
                      order: order,
                    ),
                  ),
                  // GestureDetector(
                  //   // onTap: () => Navigator.push(
                  //   //   context,
                  //   //   MaterialPageRoute(
                  //   //     builder: (context) =>
                  //   //         RatingScreen(productID: orderingProduct.productID!),
                  //   //   ),
                  //   // ),
                  //   child: Container(
                  //     alignment: Alignment.bottomCenter,
                  //     decoration: BoxDecoration(
                  //         color: MyTheme.accent_color,
                  //         borderRadius: BorderRadius.circular(8.r)),
                  //     width: MediaQuery.of(context).size.width * 0.9,
                  //     height: MediaQuery.of(context).size.height * 0.06,
                  //     child: Center(
                  //       child: Text(
                  //         LangText(context: context).getLocal()!.rate_ucf,
                  //         textAlign: TextAlign.center,
                  //         style:
                  //             TextStyle(fontSize: 16.sp, color: Colors.white),
                  //       ),
                  //     ),

                  //     // text: "Details",
                  //     // buttonTextStyle: TextStyle(color: Colors.white),

                  //     // onPressed: () => OrderDetailScreen(),
                  //   ),
                  // ),
                ],
              ),
            ),
          )),
    );
  }
}

class DetailBody extends StatefulWidget {
  DetailBody(
      {super.key,
      required this.list,
      required this.deliverServiceID,
      required this.order});
  List<OrderingProduct> list;
  String deliverServiceID;
  Order order;

  @override
  State<DetailBody> createState() => _DetailBodyState();
}

class _DetailBodyState extends State<DetailBody> {
  DeliverService? deliverService;
  bool isLoading = true;
  DeliverServiceRepo deliverServiceRepo = DeliverServiceRepo();
  PayMentRepo payMentRepo = PayMentRepo();
  PaymentType? paymentType;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    deliverService = await deliverServiceRepo
        .getDeliveryServiceByID(widget.order.deliverServiceID!);
    paymentType = await payMentRepo.getPaymentByID(widget.order.paymentTypeID!);
    isLoading = false;
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserViewModel>(context);
    final user = userProvider.currentUser;
    return Container(
      width: double.maxFinite,
      height: MediaQuery.of(context).size.height * 0.95,
      padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 26.h),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              //margin: EdgeInsets.symmetric(horizontal: 4.h),
              //padding: EdgeInsets.symmetric(horizontal: 24.h, vertical: 20.h),
              decoration: BoxDecoration(color: Colors.blue[400]),
              child: Row(
                ///mainAxisAlignment: MainAxisAlignment.,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 20.w,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            width: 10.w,
                          ),
                          Icon(
                            Icons.local_shipping_outlined,
                            size: 25.h,
                          ),
                          SizedBox(
                            width: 10.w,
                          ),
                          Text(
                            LangText(context: context)
                                .getLocal()!
                                .shipping_info,
                            style: TextStyle(fontSize: 18.sp),
                          ),
                        ],
                      ),
                    ]),
                Row(children: [
                  SizedBox(
                    width: 60.w,
                  ),
                  Text(
                    isLoading ? "..." : deliverService!.name!,
                    style: TextStyle(fontSize: 14.sp),
                  ),
                  SizedBox(
                    width: 50.w,
                  ),
                ]),
                //SizedBox(height: 20),
              ],
            ),
            SizedBox(height: 20.h),
            Container(
              height: 2, // Chiều cao của đường thẳng
              color: Colors.black12, // Màu sắc của đường thẳng
            ),
            SizedBox(
              height: 20.h,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            width: 10.w,
                          ),
                          Icon(
                            Icons.location_on_outlined,
                            size: 20.h,
                          ),
                          SizedBox(
                            width: 10.w,
                          ),
                          Text(
                            LangText(context: context)
                                .getLocal()!
                                .received_address,
                            style: TextStyle(fontSize: 18.sp),
                          ),
                        ],
                      ),
                    ]),
                Row(
                  children: [
                    SizedBox(
                      width: 60.w,
                    ),
                    Text(
                      user!.firstName!,
                      style: TextStyle(fontSize: 14.sp),
                    ),
                    SizedBox(
                      width: 50.w,
                    ),
                  ],
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 60.w,
                    ),
                    Text(
                      user.phone ?? user.email ?? "",
                      style: TextStyle(fontSize: 14.sp),
                    ),
                    SizedBox(
                      width: 50.w,
                    ),
                  ],
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 60.w,
                    ),
                    Text(
                      "${widget.order.receivedAddress!.name!} - ${widget.order.receivedAddress!.city!.name!}",
                      style: TextStyle(fontSize: 14.sp),
                    ),
                    SizedBox(
                      width: 50.w,
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 20.h),
            Container(
              height: 1, // Chiều cao của đường thẳng
              color: Colors.black12, // Màu sắc của đường thẳng
            ),
            SizedBox(
              height: 20.h,
            ),
            ListorderingItem(
              listOrderingProduct: widget.list,
              orderID: widget.order.id!,
            ),
            SizedBox(height: 20.h),
            Container(
              height: 2, // Chiều cao của đường thẳng
              color: Colors.black12, // Màu sắc của đường thẳng
            ),
            SizedBox(
              height: 10.h,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          width: 10.w,
                        ),
                        Icon(
                          Icons.payment_outlined,
                          size: 30.h,
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        Text(
                          LangText(context: context)
                              .getLocal()!
                              .payment_method_ucf,
                          style: TextStyle(fontSize: 18.sp),
                        ),
                      ],
                    ),
                  ],
                ),
                Row(children: [
                  SizedBox(
                    width: 60.w,
                  ),
                  Text(
                    isLoading
                        ? "..."
                        : paymentType != null
                            ? paymentType!.name!
                            : "",
                    style: TextStyle(fontSize: 14.sp),
                  ),
                  SizedBox(
                    width: 50.w,
                  ),
                ]),
              ],
            ),
            SizedBox(height: 20.h),
            Container(
              height: 2, // Chiều cao của đường thẳng
              color: Colors.black12, // Màu sắc của đường thẳng
            ),
            SizedBox(
              height: 20.h,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      LangText(context: context).getLocal()!.order_code_ucf,
                      style: TextStyle(fontSize: 16.sp),
                    ),
                    Container(
                      constraints: BoxConstraints(
                          maxWidth: MediaQuery.of(context).size.width * 0.62),
                      padding: EdgeInsets.symmetric(horizontal: 3.w),
                      child: Text(
                        widget.order.id!,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 16.sp),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      LangText(context: context).getLocal()!.order_date_ucf,
                      style: TextStyle(fontSize: 16.sp, color: Colors.black38),
                    ),
                    Text(
                      DateHelper.convertCommonDateTime(widget.order.time!),
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 16.sp, color: Colors.black38),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              width: 10.w,
            ),
            SizedBox(height: 20.h),
            Container(
              height: 2, // Chiều cao của đường thẳng
              color: Colors.black12, // Màu sắc của đường thẳng
            ),
            SizedBox(
              height: 20.h,
            ),
            buildPriceRow(context, widget.order.totalProduct!,
                widget.order.shippingCost!, null, widget.order.totalCost!),
            SizedBox(
              height: 20.h,
            ),
          ],
        ),
      ),
    );
  }

  Widget buildPriceRow(BuildContext context, int totalProduct, int shippingCost,
      int? voucherValue, int totalCost) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
      decoration: BoxDecoration(
          border: Border.all(width: 1, color: MyTheme.accent_color),
          borderRadius: BorderRadius.circular(10.r)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                LangText(context: context).getLocal()!.total_product_ucf,
                style: TextStyle(fontSize: 16.sp, color: Colors.black38),
              ),
              Text(totalProduct.toString(),
                  style: TextStyle(
                      fontSize: 16.sp,
                      color: Colors.black38,
                      fontWeight: FontWeight.w600))
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                LangText(context: context).getLocal()!.shipping_cost_ucf,
                style: TextStyle(fontSize: 16.sp, color: Colors.black38),
              ),
              Text("${shippingCost.toString()} VND",
                  style: TextStyle(
                      fontSize: 16.sp,
                      color: Colors.black38,
                      fontWeight: FontWeight.w600))
            ],
          ),
          if (voucherValue != null)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  LangText(context: context).getLocal()!.voucher_ucf,
                  style: TextStyle(fontSize: 16.sp, color: Colors.black38),
                ),
                Text(voucherValue.toString(),
                    style: TextStyle(
                        fontSize: 16.sp,
                        color: Colors.black38,
                        fontWeight: FontWeight.w600))
              ],
            ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                LangText(context: context).getLocal()!.total_amount_ucf,
                style: TextStyle(fontSize: 16.sp, color: Colors.black38),
              ),
              Text("${totalCost.toString()} VND",
                  style: TextStyle(
                      fontSize: 16.sp,
                      color: Colors.black38,
                      fontWeight: FontWeight.w600))
            ],
          ),
        ],
      ),
    );
  }
}
