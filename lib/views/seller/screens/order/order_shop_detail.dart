import 'package:dpl_ecommerce/const/app_theme.dart';
import 'package:dpl_ecommerce/customs/custom_app_bar.dart';
import 'package:dpl_ecommerce/helpers/date_helper.dart';
import 'package:dpl_ecommerce/helpers/delivery_status_helper.dart';
import 'package:dpl_ecommerce/helpers/payment_status_helper.dart';
import 'package:dpl_ecommerce/models/order_shop.dart';
import 'package:dpl_ecommerce/models/product.dart';
import 'package:dpl_ecommerce/repositories/order_repo.dart';
import 'package:dpl_ecommerce/repositories/product_repo.dart';
import 'package:dpl_ecommerce/utils/lang/lang_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OrderShopDetail extends StatefulWidget {
  OrderShopDetail({super.key, required this.id});
  String id;
  @override
  State<OrderShopDetail> createState() => _OrderShopDetailState();
}

class _OrderShopDetailState extends State<OrderShopDetail> {
  OrderShop? orderShop;
  bool isLoading = true;
  OrderRepo orderRepo = OrderRepo();
  Product? product;
  ProductRepo productRepo = ProductRepo();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fecthData();
  }

  void reset() {
    orderShop = null;
    isLoading = true;
    if (mounted) {
      setState(() {});
    }
  }

  Future<void> fecthData() async {
    orderShop = await orderRepo.getOrderShopByID(widget.id);
    if (orderShop != null) {
      product = await productRepo.getProductByID(orderShop!.productID!);
    }
    isLoading = false;
    if (mounted) {
      setState(() {});
    }
  }

  Future<void> onRefresh() async {
    reset();
    await fecthData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
              title: LangText(context: context).getLocal()!.order_details_ucf,
              centerTitle: true,
              context: context)
          .show(),
      body: RefreshIndicator(
          onRefresh: onRefresh,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 20.h, left: 20.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width / 2 - 20.w,
                        child: Text(
                          LangText(context: context)
                              .getLocal()!
                              .payment_status_ucf,
                          style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.bold,
                              color: MyTheme.font_grey),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width / 2 - 20.w,
                        child: Text(
                          orderShop != null
                              ? PaymentStatusHelper.translatePaymentStatus(
                                  context, orderShop!.paymentStatus!)
                              : "...",
                          style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.bold,
                              color: MyTheme.font_grey),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 20.h, left: 20.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width / 2 - 20.w,
                        child: Text(
                          LangText(context: context)
                              .getLocal()!
                              .delivery_status_ucf,
                          style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.bold,
                              color: MyTheme.font_grey),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width / 2 - 20.w,
                        child: Text(
                          orderShop != null
                              ? DeliveryStatusHelper.translateDeliveryStatus(
                                  context, orderShop!.deliverStatus!)
                              : "...",
                          style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.bold,
                              color: MyTheme.font_grey),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 20.h, left: 20.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width / 2 - 20.w,
                        child: Text(
                          LangText(context: context).getLocal()!.product_ucf,
                          style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.bold,
                              color: MyTheme.font_grey),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width / 2 - 20.w,
                        child: Text(
                          orderShop != null
                              ? product != null
                                  ? product!.name!
                                  : "..."
                              : "...",
                          style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.bold,
                              color: MyTheme.font_grey),
                        ),
                      ),
                    ],
                  ),
                ),
                orderShop != null
                    ? orderShop!.size != null
                        ? Padding(
                            padding: EdgeInsets.only(top: 20.h, left: 20.w),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(
                                  width: MediaQuery.of(context).size.width / 2 -
                                      20.w,
                                  child: Text(
                                    LangText(context: context)
                                        .getLocal()!
                                        .size_ucf,
                                    style: TextStyle(
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.bold,
                                        color: MyTheme.font_grey),
                                  ),
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width / 2 -
                                      20.w,
                                  child: Text(
                                    orderShop!.size!,
                                    style: TextStyle(
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.bold,
                                        color: MyTheme.font_grey),
                                  ),
                                ),
                              ],
                            ),
                          )
                        : Container()
                    : Container(),
                orderShop != null
                    ? orderShop!.type != null
                        ? Padding(
                            padding: EdgeInsets.only(top: 20.h, left: 20.w),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(
                                  width: MediaQuery.of(context).size.width / 2 -
                                      20.w,
                                  child: Text(
                                    LangText(context: context)
                                        .getLocal()!
                                        .type_ucf,
                                    style: TextStyle(
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.bold,
                                        color: MyTheme.font_grey),
                                  ),
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width / 2 -
                                      20.w,
                                  child: Text(
                                    orderShop!.type!,
                                    style: TextStyle(
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.bold,
                                        color: MyTheme.font_grey),
                                  ),
                                ),
                              ],
                            ),
                          )
                        : Container()
                    : Container(),
                orderShop != null
                    ? orderShop!.color != null
                        ? Padding(
                            padding: EdgeInsets.only(top: 20.h, left: 20.w),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(
                                  width: MediaQuery.of(context).size.width / 2 -
                                      20.w,
                                  child: Text(
                                    LangText(context: context)
                                        .getLocal()!
                                        .color_ucf,
                                    style: TextStyle(
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.bold,
                                        color: MyTheme.font_grey),
                                  ),
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width / 2 -
                                      20.w,
                                  child: Text(
                                    orderShop!.color!,
                                    style: TextStyle(
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.bold,
                                        color: MyTheme.font_grey),
                                  ),
                                ),
                              ],
                            ),
                          )
                        : Container()
                    : Container(),
                Padding(
                  padding: EdgeInsets.only(top: 20.h, left: 20.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width / 2 - 20.w,
                        child: Text(
                          LangText(context: context).getLocal()!.date_ucf,
                          style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.bold,
                              color: MyTheme.font_grey),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width / 2 - 20.w,
                        child: Text(
                          orderShop != null
                              ? DateHelper.convertDateToDateString(
                                  orderShop!.orderDate!.toDate())
                              : '...',
                          style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.bold,
                              color: MyTheme.font_grey),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 20.h, left: 20.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width / 2 - 20.w,
                        child: Text(
                          LangText(context: context).getLocal()!.quantity_ucf,
                          style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.bold,
                              color: MyTheme.font_grey),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width / 2 - 20.w,
                        child: Text(
                          orderShop != null
                              ? orderShop!.quatity.toString()
                              : '...',
                          style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.bold,
                              color: MyTheme.font_grey),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 20.h, left: 20.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width / 2 - 20.w,
                        child: Text(
                          LangText(context: context)
                              .getLocal()!
                              .total_amount_ucf,
                          style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.bold,
                              color: MyTheme.font_grey),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width / 2 - 20.w,
                        child: Text(
                          orderShop != null
                              ? orderShop!.totalPrice.toString()
                              : '...',
                          style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.bold,
                              color: MyTheme.font_grey),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
