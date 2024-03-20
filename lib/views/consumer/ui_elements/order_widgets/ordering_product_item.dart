import 'package:dpl_ecommerce/const/app_theme.dart';
import 'package:dpl_ecommerce/models/product.dart';
import 'package:dpl_ecommerce/models/voucher.dart';
import 'package:dpl_ecommerce/repositories/order_repo.dart';
import 'package:dpl_ecommerce/repositories/product_repo.dart';
import 'package:dpl_ecommerce/repositories/voucher_repo.dart';
import 'package:dpl_ecommerce/utils/constants/image_data.dart';
import 'package:dpl_ecommerce/utils/lang/lang_text.dart';
import 'package:dpl_ecommerce/views/consumer/screens/ordering_product_item_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dpl_ecommerce/models/ordering_product.dart';

class OrderingProductItem extends StatefulWidget {
  OrderingProductItem(
      {super.key,
      required this.orderingProductID,
      required this.orderID,
      this.isDetail = false});
  // OrderingProduct orderingProduct;
  String orderingProductID;
  final String orderID;
  bool isDetail;
  @override
  State<OrderingProductItem> createState() => _OrderingProductItemState();
}

class _OrderingProductItemState extends State<OrderingProductItem> {
  Product? product;
  bool isFetchingProduct = true;

  bool isLoading = true;

  Voucher? voucher;
  int discountValue = 0;
  OrderingProduct? orderingProduct;
  VoucherRepo voucherRepo = VoucherRepo();
  ProductRepo productRepo = ProductRepo();
  OrderRepo orderRepo = OrderRepo();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    orderingProduct = await orderRepo.getOrderingProductByOrderID(
        orderID: widget.orderID, orderingProductID: widget.orderingProductID);
    if (orderingProduct != null) {
      product = await productRepo.getProductByID(orderingProduct!.productID!);
      isFetchingProduct = false;
      if (orderingProduct!.voucherID != null) {
        voucher = await voucherRepo.getVoucherByID(orderingProduct!.voucherID!);
      }
    }

    isLoading = false;
    if (mounted) {
      setState(() {});
    }
  }

  void reset() {
    product = null;
    orderingProduct = null;
    isLoading = true;
    voucher = null;
    isFetchingProduct = true;
    if (mounted) {
      setState(() {});
    }
  }

  Future<void> onRefresh() async {
    reset();
    await fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        // go to detail
        if (!widget.isDetail) {
          if (!isLoading && orderingProduct != null) {
            final result = await Navigator.of(context)
                .push(MaterialPageRoute(
              builder: (context) => OrderingProductDetailScreen(
                  order: orderingProduct!, orderID: widget.orderID),
            ))
                .whenComplete(() async {
              await onRefresh();
            });
          }
        }
      },
      child: Container(
        padding: EdgeInsets.all(2.h),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.h),
            border: Border.all(color: MyTheme.borderColor, width: 1)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              // decoration: BoxDecoration(
              //   border: Border.all(color: MyTheme.accent_color, width: 1),
              //   // borderRadius: BorderRadius.circular(10.r)
              // ),
              padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 10.w),
              child: Row(
                children: [
                  SizedBox(
                    width: 10.w,
                  ),
                  Column(
                    children: [
                      !isLoading
                          ? product != null
                              ? FadeInImage.assetNetwork(
                                  placeholder: ImageData.imageNotFound,
                                  image: product!.images![0],
                                  height: 80.h,
                                  width: 80.h,
                                )
                              : Container(
                                  height: 80.h,
                                  width: 80.h,
                                  child: Center(
                                    child: Image.asset(ImageData.placeHolder),
                                  ),
                                )
                          : Container()
                      // Image.network(
                      //   'https://picsum.photos/250?image=9',
                      //   width: 80.h,
                      //   height: 80.h,
                      // ),
                    ],
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        isLoading
                            ? "..."
                            : product != null
                                ? product!.name!
                                : isFetchingProduct
                                    ? ""
                                    : LangText(context: context)
                                        .getLocal()!
                                        .data_no_longer_exists,
                        style: TextStyle(
                            fontSize: 20.sp, fontWeight: FontWeight.w800),
                      ),
                      Row(
                        children: [
                          Text(
                            isLoading
                                ? "..."
                                : orderingProduct != null
                                    ? orderingProduct!.size != null
                                        ? "${LangText(context: context).getLocal()!.size_ucf}: ${orderingProduct!.size}"
                                        : ""
                                    : "",
                            style: TextStyle(fontSize: 14.sp),
                          ),
                          SizedBox(
                            width: 10.w,
                          ),
                          Text(
                            isLoading
                                ? "..."
                                : orderingProduct != null
                                    ? orderingProduct!.color != null
                                        ? "${LangText(context: context).getLocal()!.color_ucf} ${orderingProduct!.color}"
                                        : ""
                                    : "",
                            style: TextStyle(fontSize: 14.sp),
                          ),
                          SizedBox(
                            width: 10.w,
                          ),
                          Text(
                            isLoading
                                ? "..."
                                : orderingProduct != null
                                    ? orderingProduct!.type != null
                                        ? "${LangText(context: context).getLocal()!.type_ucf} ${orderingProduct!.type}"
                                        : ""
                                    : "",
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(fontSize: 14.sp),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  // decoration: BoxDecoration(color: Colors.red),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 10.w,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            LangText(context: context).getLocal()!.price_ucf,
                            style: TextStyle(
                                fontSize: 18.sp, color: Colors.black38),
                          ),
                          Text(
                            LangText(context: context).getLocal()!.quantity_ucf,
                            style: TextStyle(
                                fontSize: 18.sp, color: Colors.black38),
                          ),
                          if (voucher != null)
                            Text(
                              "${LangText(context: context).getLocal()!.discount_ucf} ",
                              style: TextStyle(
                                  fontSize: 18.sp, color: Colors.black38),
                            ),
                          Text(
                            LangText(context: context)
                                .getLocal()!
                                .total_amount_ucf,
                            style: TextStyle(
                                fontSize: 18.sp, color: Colors.black38),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 5.w),
                  // decoration: BoxDecoration(color: Colors.yellow),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Text(
                      //   "${orderingProduct!.quantity!} VND",
                      //   style:
                      //       TextStyle(fontSize: 18.sp, color: Colors.black38),
                      // ),
                      Text(
                        isLoading
                            ? "..."
                            : orderingProduct != null
                                ? "${orderingProduct!.price}  VND"
                                : "",
                        style: TextStyle(fontSize: 17.sp, color: MyTheme.black),
                      ),
                      Text(
                        isLoading
                            ? "..."
                            : orderingProduct != null
                                ? orderingProduct!.quantity.toString()
                                : "",
                        style: TextStyle(fontSize: 17.sp, color: MyTheme.black),
                      ),
                      if (voucher != null)
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 5.w),
                          width: MediaQuery.of(context).size.width * 0.5,
                          child: Text(
                            isLoading
                                ? "..."
                                : orderingProduct != null
                                    ? orderingProduct!.voucherID.toString()
                                    : "",
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 17.sp, color: MyTheme.black),
                          ),
                        ),
                      Text(
                        isLoading
                            ? "..."
                            : orderingProduct != null
                                ? "${orderingProduct!.realPrice!} VND"
                                : "",
                        style: TextStyle(fontSize: 17.sp, color: MyTheme.black),
                      ),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
