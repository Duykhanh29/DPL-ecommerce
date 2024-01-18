import 'package:dpl_ecommerce/const/app_theme.dart';
import 'package:dpl_ecommerce/models/product.dart';
import 'package:dpl_ecommerce/models/voucher.dart';
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
      required this.orderingProduct,
      required this.orderID,
      this.isDetail = false});
  OrderingProduct orderingProduct;
  final String orderID;
  bool isDetail;
  @override
  State<OrderingProductItem> createState() => _OrderingProductItemState();
}

class _OrderingProductItemState extends State<OrderingProductItem> {
  Product? product;
  ProductRepo productRepo = ProductRepo();
  bool isLoading = true;
  VoucherRepo voucherRepo = VoucherRepo();
  Voucher? voucher;
  int discountValue = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    product =
        await productRepo.getProductByID(widget.orderingProduct.productID!);
    if (widget.orderingProduct.voucherID != null) {
      voucher =
          await voucherRepo.getVoucherByID(widget.orderingProduct.voucherID!);
    }
    isLoading = false;
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // go to detail
        if (!widget.isDetail) {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => OrderingProductDetailScreen(
                order: widget.orderingProduct, orderID: widget.orderID),
          ));
        }
      },
      child: Container(
        padding: EdgeInsets.all(2.h),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.h),
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
                          ? FadeInImage.assetNetwork(
                              placeholder: ImageData.imageNotFound,
                              image: product!.images![0],
                              height: 80.h,
                              width: 80.h,
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
                                : "",
                        style: TextStyle(
                            fontSize: 20.sp, fontWeight: FontWeight.w800),
                      ),
                      Row(
                        children: [
                          Text(
                            widget.orderingProduct.size != null
                                ? "${LangText(context: context).getLocal()!.size_ucf}: ${widget.orderingProduct.size}"
                                : "",
                            style: TextStyle(fontSize: 14.sp),
                          ),
                          SizedBox(
                            width: 10.w,
                          ),
                          Text(
                            widget.orderingProduct.color != null
                                ? "${LangText(context: context).getLocal()!.color_ucf} ${widget.orderingProduct.color}"
                                : "",
                            style: TextStyle(fontSize: 14.sp),
                          ),
                          SizedBox(
                            width: 10.w,
                          ),
                          Text(
                            widget.orderingProduct.type != null
                                ? "${LangText(context: context).getLocal()!.type_ucf} ${widget.orderingProduct.type}"
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
                      //   "${widget.orderingProduct.quantity!} VND",
                      //   style:
                      //       TextStyle(fontSize: 18.sp, color: Colors.black38),
                      // ),
                      Text(
                        "${widget.orderingProduct.price}  VND",
                        style: TextStyle(fontSize: 17.sp, color: MyTheme.black),
                      ),
                      Text(
                        widget.orderingProduct.quantity.toString(),
                        style: TextStyle(fontSize: 17.sp, color: MyTheme.black),
                      ),
                      if (voucher != null)
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 5.w),
                          width: MediaQuery.of(context).size.width * 0.5,
                          child: Text(
                            widget.orderingProduct.voucherID.toString(),
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 17.sp, color: MyTheme.black),
                          ),
                        ),
                      Text(
                        "${widget.orderingProduct.realPrice!} VND",
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
