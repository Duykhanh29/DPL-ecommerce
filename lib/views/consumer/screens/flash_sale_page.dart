import 'package:cached_network_image/cached_network_image.dart';
import 'package:dpl_ecommerce/customs/custom_app_bar.dart';
import 'package:dpl_ecommerce/customs/custom_array_back_widget.dart';
import 'package:dpl_ecommerce/customs/custom_photo_view.dart';
import 'package:dpl_ecommerce/helpers/shimmer_helper.dart';
import 'package:dpl_ecommerce/models/flash_sale.dart';
import 'package:dpl_ecommerce/models/product.dart';
import 'package:dpl_ecommerce/repositories/flash_sale_repo.dart';
import 'package:dpl_ecommerce/repositories/product_repo.dart';
import 'package:dpl_ecommerce/repositories/voucher_repo.dart';
import 'package:dpl_ecommerce/services/storage_services/storage_service.dart';
import 'package:dpl_ecommerce/utils/lang/lang_text.dart';
import 'package:dpl_ecommerce/views/consumer/ui_elements/flash_sale_product.dart';
import 'package:dpl_ecommerce/views/consumer/ui_elements/product_small_list_item1_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:shimmer/shimmer.dart';

import 'dart:async';
import 'package:flutter_timer_countdown/flutter_timer_countdown.dart';

class FlashDealList extends StatefulWidget {
  FlashDealList({required this.flashSale});
  FlashSale? flashSale;

  @override
  _FlashDealListState createState() => _FlashDealListState();
}

class _FlashDealListState extends State<FlashDealList> {
  // List<FlashSale>? list = FlashSaleRepo().list;
  List<Product>? listProduct = ProductRepo().list;

  DateTime convertTimeStampToDateTime(int timeStamp) {
    var dateToTimeStamp = DateTime.fromMillisecondsSinceEpoch(timeStamp * 1000);
    return dateToTimeStamp;
  }

  StorageService storageService = StorageService();

  VoucherRepo voucherRepo = VoucherRepo();
  @override
  Widget build(BuildContext context) {
    print("object");
    return Scaffold(
      appBar: CustomAppBar(
              centerTitle: true,
              context: context,
              title: LangText(context: context).getLocal()!.flash_sales_ucf)
          .show(),
      body: FutureBuilder(
        builder: (context, snapshot) =>
            buildFlashDealList(context, widget.flashSale!, listProduct!),
        future: voucherRepo.getListVoucher(),
      ),
    );
  }

  Widget buildFlashDealList(context, FlashSale flashSale, List<Product> list) {
    final size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) {
                    return Scaffold(
                      appBar: AppBar(
                        leading: CustomArrayBackWidget(),
                        actions: [
                          IconButton(
                              onPressed: () async {
                                await storageService.downloadAndSaveImage(
                                    widget.flashSale!.coverImage!);
                              },
                              icon: Icon(Icons.download_outlined))
                        ],
                      ),
                      body: CustomPhotoView(
                          urlImage: widget.flashSale!.coverImage!),
                    );
                  },
                ));
              },
              child: CachedNetworkImage(
                imageUrl: widget.flashSale!.coverImage!,
                imageBuilder: (context, imageProvider) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) {
                          return Scaffold(
                            appBar: AppBar(
                              leading: CustomArrayBackWidget(),
                            ),
                            body: CustomPhotoView(
                                urlImage: widget.flashSale!.coverImage!),
                          );
                        },
                      ));
                    },
                    child: Container(
                      width: size.width * 0.9,
                      height: size.height * 0.2,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: imageProvider, fit: BoxFit.cover),
                      ),
                      padding: EdgeInsets.all(5.h),
                    ),
                  );
                },
                placeholder: (context, url) => Image.network(
                    "https://png.pngtree.com/png-vector/20210604/ourmid/pngtree-gray-network-placeholder-png-image_3416659.jpg"),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(15.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Icon(
                  Icons.watch_later_outlined,
                  size: 20.h,
                ),
                TimerCountdown(
                  timeTextStyle: TextStyle(
                      color: Colors.red,
                      fontSize: 22.sp,
                      fontWeight: FontWeight.w500),
                  enableDescriptions: false,
                  endTime: flashSale!.expDate!.toDate(),
                  format: CountDownTimerFormat.daysHoursMinutesSeconds,
                  onEnd: () {
                    // disappear this flashsale
                  },
                ),
                Icon(Icons.flash_on, color: Colors.yellow, size: 20.h)
              ],
            ),
          ),
          // SizedBox(
          //   height: size.height * 0.8,
          //   child: ListView.separated(
          //     separatorBuilder: (context, index) {
          //       return SizedBox(
          //         height: 20,
          //       );
          //     },
          //     itemCount: list.length,
          //     scrollDirection: Axis.vertical,
          //     physics: BouncingScrollPhysics(),
          //     // shrinkWrap: true,
          //     itemBuilder: (context, index) {
          //       return
          //           // SizedBox(
          //           //   height: 100,
          //           //   child: Text("data"),
          //           // );
          //           buildFlashDealListItem(list, index);
          //     },
          //   ),
          // ),
          _buildProductSmallList1(context, list)
        ],
      ),
    );
  }

  String timeText(String txt, {default_length = 3}) {
    var blank_zeros = default_length == 3 ? "000" : "00";
    var leading_zeros = "";
    if (txt != null) {
      if (default_length == 3 && txt.length == 1) {
        leading_zeros = "00";
      } else if (default_length == 3 && txt.length == 2) {
        leading_zeros = "0";
      } else if (default_length == 2 && txt.length == 1) {
        leading_zeros = "0";
      }
    }

    var newtxt = (txt == null || txt == "" || txt == null.toString())
        ? blank_zeros
        : txt;

    // print(txt + " " + default_length.toString());
    // print(newtxt);

    if (default_length > txt.length) {
      newtxt = leading_zeros + newtxt;
    }
    //print(newtxt);

    return newtxt;
  }

  /// Section Widget
  Widget _buildProductSmallList1(BuildContext context, List<Product> list) {
    return Padding(
      padding: EdgeInsets.only(right: 10.w, left: 10.w),
      child: GridView.builder(
        shrinkWrap: true,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10.w,
          mainAxisSpacing: 10.h,
          mainAxisExtent: 283,
          // childAspectRatio: 3 / 2,
        ),
        itemBuilder: (context, index) {
          return Productsmalllist1ItemWidget(
            product: list[index],
          );
        },
        physics: const NeverScrollableScrollPhysics(),
        itemCount: list.length,
      ),
    );
  }
}
