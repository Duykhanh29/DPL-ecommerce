import 'package:dpl_ecommerce/const/app_theme.dart';
import 'package:dpl_ecommerce/helpers/date_helper.dart';
import 'package:dpl_ecommerce/helpers/delivery_status_helper.dart';
import 'package:dpl_ecommerce/helpers/payment_status_helper.dart';
import 'package:dpl_ecommerce/helpers/toast_helper.dart';
import 'package:dpl_ecommerce/models/order_shop.dart';
import 'package:dpl_ecommerce/models/ordering_product.dart';
import 'package:dpl_ecommerce/repositories/order_repo.dart';
import 'package:dpl_ecommerce/utils/lang/lang_text.dart';
import 'package:dpl_ecommerce/view_model/seller/shop_view_model.dart';
import 'package:dpl_ecommerce/views/seller/screens/order/order_shop_detail.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class ListOrderShop extends StatefulWidget {
  ListOrderShop({super.key, required this.shopID});
  String shopID;

  @override
  State<ListOrderShop> createState() => _ListOrderShopState();
}

class _ListOrderShopState extends State<ListOrderShop> {
  OrderRepo orderRepo = OrderRepo();
  List<OrderShop>? listOrder;
  bool isLoading = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    listOrder = await orderRepo.getListOrderByShop(widget.shopID);
    isLoading = false;
    setState(() {});
  }

  Future<void> onRefresh() async {
    reset();
    await fetchData();
  }

  void reset() {
    listOrder!.clear();
    isLoading = true;
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(onRefresh: onRefresh, child: buildListOrder());
  }

  Widget buildListOrder() {
    if (isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else {
      return listOrder == null || listOrder!.isEmpty
          ? Center(
              child: Text(
                  LangText(context: context).getLocal()!.no_data_is_available),
            )
          : Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
              child: ListView.separated(
                itemBuilder: (context, index) {
                  return buildOrderShopItem(index, context);
                },
                separatorBuilder: (context, index) => SizedBox(
                  height: 10.h,
                ),
                itemCount: listOrder!.length,
              ),
            );
    }
  }

  Widget buildOrderShopItem(int index, BuildContext context) {
    PaymentStatus paymentStatus = listOrder![index].paymentStatus!;
    DeliverStatus deliverStatus = listOrder![index].deliverStatus!;
    final shopProvider = Provider.of<ShopViewModel>(context);
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return OrderShopDetail(
            id: listOrder![index].id!,
          );
        }));
      },
      child: Container(
        // height: 90.h,S
        width: MediaQuery.of(context).size.width * 0.9,
        padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 10.h),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: MyTheme.app_accent_color_extra_light,
            borderRadius: BorderRadius.circular(10.r)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Text(
                listOrder![index].orderingProductID ?? "...",
                style: TextStyle(
                    color: MyTheme.app_accent_color,
                    fontSize: 13.sp,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 4.0),
              child: Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(right: 8.w),
                    child: Icon(
                      Icons.calendar_today_outlined,
                      size: 16.h,
                      color: MyTheme.font_grey,
                    ),
                  ),
                  Text(
                    DateHelper.convertDateToDateString(
                        listOrder![index].orderDate!.toDate()),
                    style: TextStyle(
                        color: MyTheme.font_grey,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(LangText(context: context).getLocal()!.payment_status_ucf,
                    style: TextStyle(
                        color: MyTheme.font_grey,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400)),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: MyTheme.grey_153, width: 1)),
                  width: MediaQuery.of(context).size.width * 0.44,
                  height: 40,
                  padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.h),
                  child: DropdownButton<PaymentStatus>(
                    isExpanded: true,
                    value: paymentStatus,
                    focusColor: MyTheme.accent_color,
                    items: buildDropdownPaymentStatusItemsForUpdate(context),
                    onChanged: (value) async {
                      if (listOrder![index].deliverStatus ==
                              DeliverStatus.confirmed ||
                          listOrder![index].deliverStatus ==
                              DeliverStatus.delivering) {
                        ToastHelper.showDialog(
                            LangText(context: context)
                                .getLocal()!
                                .you_cannot_update_the_payment_status_yet,
                            gravity: ToastGravity.CENTER);
                        return;
                      }
                      await orderRepo.updatePaymentStatusForOrderShop(
                          listOrder![index].id!, value!);
                      if (value == PaymentStatus.paid) {
                        shopProvider
                            .updateTotalRevenue(listOrder![index].totalPrice!);
                      }
                      await onRefresh();
                    },
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Padding(
                //   padding: app_language_rtl.$!
                //       ? const EdgeInsets.only(left: 8.0)
                //       : const EdgeInsets.only(right: 8.0),
                //   child: Icon(
                //     Icons.local_shipping_outlined,
                //     size: 16,
                //     color: MyTheme.font_grey,
                //   ),
                // ),
                Text(LangText(context: context).getLocal()!.delivery_status_ucf,
                    style: TextStyle(
                        color: MyTheme.font_grey,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400)),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: MyTheme.grey_153, width: 1)),
                  width: MediaQuery.of(context).size.width * 0.44,
                  height: 40,
                  child: DropdownButton<DeliverStatus>(
                    value: listOrder![index].deliverStatus!,
                    isExpanded: true,
                    focusColor: MyTheme.accent_color,
                    items: buildDropdownDeliveryStatusItemsForUpdate(context),
                    onChanged: (value) async {
                      if (value != DeliverStatus.confirmed) {
                        showAlert(context);
                      } else {
                        await orderRepo.confirmOrder(listOrder![index].id!);
                        await onRefresh();

                        // updateOrderingProductStatus(
                        //     orderID: listOrder![index].orderCode!,
                        //     orderingProductID:
                        //         listOrder![index].orderingProductID!,
                        //     status: DeliverStatus.confirmed);
                      }
                    },
                  ),
                ),

                // Text(_orderList[index].deliveryStatus,
                //     style: TextStyle(
                //         color: MyTheme.font_grey,
                //         fontSize: 12,
                //         fontWeight: FontWeight.w400)),
              ],
            ),
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(right: 8.w),
                  child: Icon(
                    Icons.price_change_outlined,
                    size: 16.h,
                    color: MyTheme.font_grey,
                  ),
                ),
                Text(
                    "${LangText(context: context).getLocal()!.total_price_ucf}: ",
                    style: TextStyle(
                        color: MyTheme.font_grey,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400)),
                Text(
                  listOrder![index].totalPrice != null
                      ? listOrder![index].totalPrice!.toString()
                      : "",
                  style: TextStyle(
                      color: MyTheme.app_accent_color,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w500),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  showAlert(BuildContext context) {
    ToastHelper.showDialog(
        LangText(context: context)
            .getLocal()!
            .you_do_not_have_this_changing_permission,
        gravity: ToastGravity.CENTER);
  }

  List<DropdownMenuItem<PaymentStatus>>
      buildDropdownPaymentStatusItemsForUpdate(BuildContext context) {
    List<DropdownMenuItem<PaymentStatus>> items = [];
    List<PaymentStatus> list = [PaymentStatus.paid, PaymentStatus.unpaid];
    for (PaymentStatus item in list as Iterable<PaymentStatus>) {
      items.add(
        DropdownMenuItem(
          alignment: Alignment.center,
          value: item,
          child: Text(PaymentStatusHelper.translatePaymentStatus(context, item),
              style: TextStyle(fontSize: 12.sp)),
        ),
      );
    }
    return items;
  }

  List<DropdownMenuItem<DeliverStatus>>
      buildDropdownDeliveryStatusItemsForUpdate(BuildContext context) {
    List<DropdownMenuItem<DeliverStatus>> items = [];
    List<DeliverStatus> _deliveryStatusListForUpdate = [
      DeliverStatus.processing,
      DeliverStatus.confirmed,
      DeliverStatus.delivering,
      DeliverStatus.delivered,
    ];
    for (DeliverStatus item
        in _deliveryStatusListForUpdate as Iterable<DeliverStatus>) {
      items.add(
        DropdownMenuItem(
          alignment: Alignment.center,
          value: item,
          child: Text(
              DeliveryStatusHelper.translateDeliveryStatus(context, item),
              style: TextStyle(fontSize: 12.sp)),
        ),
      );
    }
    return items;
  }

  List<DropdownMenuItem<String>> buildDropdownDeliveryStatusItem(
      BuildContext context) {
    List<DropdownMenuItem<String>> items = [];
    List<String> _deliveryStatusListForUpdate = [
      LangText(context: context).getLocal()!.processing,
      LangText(context: context).getLocal()!.confirmed_ucf,
      LangText(context: context).getLocal()!.delivering,
      LangText(context: context).getLocal()!.delivered_ucf,
    ];
    for (String item in _deliveryStatusListForUpdate) {
      items.add(
        DropdownMenuItem(
          alignment: Alignment.center,
          value: item,
          child: Text(item.toString(), style: TextStyle(fontSize: 12.sp)),
        ),
      );
    }
    return items;
  }
}
