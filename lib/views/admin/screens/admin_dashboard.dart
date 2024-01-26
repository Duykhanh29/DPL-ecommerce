import 'package:cached_network_image/cached_network_image.dart';
import 'package:dpl_ecommerce/const/app_theme.dart';
import 'package:dpl_ecommerce/customs/custom_app_bar.dart';
import 'package:dpl_ecommerce/models/product.dart';
import 'package:dpl_ecommerce/repositories/product_repo.dart';
import 'package:dpl_ecommerce/repositories/statistics_repo.dart';
import 'package:dpl_ecommerce/utils/constants/image_data.dart';
import 'package:dpl_ecommerce/utils/lang/lang_text.dart';
import 'package:dpl_ecommerce/views/admin/ui_elements/chart/category_chart_widget.dart';
import 'package:dpl_ecommerce/views/admin/ui_section/admin_drawer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// ignore: must_be_immutable
class DashAdmin extends StatefulWidget {
  DashAdmin({super.key});

  @override
  State<DashAdmin> createState() => _DashAdminState();
}

class _DashAdminState extends State<DashAdmin> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchData();
  }

  List<Product>? listTopProduct;
  int? totalUser;
  int? totalOrder;
  int? totalShop;
  int? totalProduct;
  int? totalCategory;
  int? totalDeliveryService;
  StatisticsRepo statisticsRepo = StatisticsRepo();
  ProductRepo productRepo = ProductRepo();
  Future<void> fetchData() async {
    totalCategory = await statisticsRepo.getTotalCategory();
    totalDeliveryService = await statisticsRepo.getTotaleliveryService();
    totalOrder = await statisticsRepo.getTotalOrder();

    totalProduct = await statisticsRepo.getTotalProduct();
    totalShop = await statisticsRepo.getTotalShop();
    totalUser = await statisticsRepo.getTotalUsers();
    listTopProduct = await productRepo.getListTopProduct();
    setState(() {});
  }

  // ignore: library_private_types_in_public_api
  final List<Product>? products = ProductRepo().list;
  void reset() {
    listTopProduct = null;
    totalUser = null;
    totalShop = null;
    totalProduct = null;
    totalCategory = null;
    totalDeliveryService = null;
    if (mounted) {
      setState(() {});
    }
  }

  Future<void> onRefresh() async {
    reset();
    await fetchData();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    onRefresh();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AdminDrawer(),
      appBar: AppBar(
        backgroundColor: MyTheme.accent_color,
        // automaticallyImplyLeading: false,
        // leadingWidth: 0,
        title: Text(
          LangText(context: context).getLocal()!.dashboard_ucf,
          style: TextStyle(
              fontSize: 17, fontWeight: FontWeight.bold, color: MyTheme.white),
        ),
        centerTitle: true,
      ),
      body: RefreshIndicator(
        onRefresh: onRefresh,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(8.h),
            child: Column(
              children: [
                SizedBox(
                  height: 40.h,
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.all(8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          _buiditeam(
                              lable: LangText(context: context)
                                  .getLocal()!
                                  .user_ucf,
                              value: totalUser != null
                                  ? totalUser.toString()
                                  : "...",
                              icon1: Icons.account_box),
                          SizedBox(
                            height: 12.h,
                          ),
                          _buiditeam(
                              lable: LangText(context: context)
                                  .getLocal()!
                                  .shop_ucf,
                              value: totalShop != null
                                  ? totalShop.toString()
                                  : "...",
                              icon1: Icons.manage_accounts),
                        ],
                      ),
                      SizedBox(
                        width: 12.h,
                      ),
                      Column(
                        children: [
                          _buiditeam(
                              lable: LangText(context: context)
                                  .getLocal()!
                                  .orders_ucf,
                              value: totalOrder != null
                                  ? totalOrder.toString()
                                  : "...",
                              icon1: CupertinoIcons.cart_fill),
                          SizedBox(
                            height: 12.h,
                          ),
                          _buiditeam(
                            lable: LangText(context: context)
                                .getLocal()!
                                .products_ucf,
                            value: totalProduct != null
                                ? totalProduct.toString()
                                : "...",
                            icon1: CupertinoIcons.cube_box_fill,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      _buiditeam1(
                          lable: LangText(context: context)
                              .getLocal()!
                              .category_ucf,
                          value: totalCategory != null
                              ? totalCategory.toString()
                              : "...",
                          icon1: Icons.category),
                      SizedBox(
                        width: 12.h,
                      ),
                      _buiditeam1(
                          lable: LangText(context: context)
                              .getLocal()!
                              .delivery_service_ucf,
                          value: totalDeliveryService != null
                              ? totalDeliveryService.toString()
                              : "...",
                          icon1: Icons.local_shipping_rounded),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                const CategoryChartWidget(),
                SizedBox(
                  height: 10.h,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.w),
                      child: Text(
                        LangText(context: context).getLocal()!.top_products_ucf,
                        style: TextStyle(fontSize: 16.sp),
                      ),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    buildTopProducts(context)
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildTopProducts(BuildContext context) {
    return listTopProduct != null
        ? ListView.builder(
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            itemCount: listTopProduct!.length,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: EdgeInsets.fromLTRB(10.w, 10.h, 10.w, 10.h),
                child: Container(
                  //height: 120.h,
                  width: 340.w,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.r),
                    boxShadow: const [
                      BoxShadow(
                          color: Colors.grey,
                          blurRadius: 10,
                          spreadRadius: 0,
                          offset: Offset(0, 0)),
                    ],
                  ),
                  child: Material(
                    //color: Colors.blue,
                    borderRadius: BorderRadius.circular(8),
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        listTopProduct![index].images != null &&
                                listTopProduct![index]!.images!.isNotEmpty
                            ? CachedNetworkImage(
                                imageUrl: listTopProduct![index].images![0],
                                imageBuilder: (context, imageProvider) {
                                  return Container(
                                    height: 80.h,
                                    width: 80.w,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: imageProvider)),
                                  );
                                },
                                errorWidget: (context, url, error) => Container(
                                  height: 80.h,
                                  width: 80.w,
                                  child: Center(
                                    child: Icon(
                                      Icons.error_outline_rounded,
                                      color: MyTheme.golden,
                                    ),
                                  ),
                                ),
                                placeholder: (context, url) => Container(
                                  height: 80.h,
                                  width: 80.w,
                                  child: Center(
                                      child:
                                          Image.asset(ImageData.placeHolder)),
                                ),
                              )
                            : Container(
                                height: 80.h,
                                width: 80.w,
                                child: Center(
                                    child: Image.asset(ImageData.placeHolder)),
                              ),
                        SizedBox(
                          width: 15.w,
                        ),
                        Container(
                          height: 80.h,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 10.h,
                              ),
                              Text(
                                listTopProduct![index].name!,
                                style: TextStyle(fontSize: 16.sp),
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              Text(
                                listTopProduct![index].price.toString(),
                                style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),

                        // Column(
                        //   children: [
                        //     Text("hello")
                        //   ],
                        // )
                      ],
                    ),
                  ),
                ),
              );
            })
        : SizedBox(
            height: 50.h,
            child: Center(
              child: Text(
                  LangText(context: context).getLocal()!.no_data_is_available),
            ),
          );
  }

  Widget _buiditeam({
    required String lable,
    required String value,
    required IconData icon1,
  }) =>
      Container(
        height: 120.h,
        width: 160.w,
        decoration: BoxDecoration(
            color: MyTheme.accent_color,
            borderRadius: BorderRadius.circular(10)),
        child:
            //SizedBox(width: 10,),

            Stack(
          //alignment: Alignment.topCenter,
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(5.w, 5.h, 0, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    icon1,
                    size: 75.sp,
                    color: MyTheme.golden,
                  ),
                ],
              ),
            ),

            //padding: EdgeInsets.fromLTRB(40.w, 40.h, 0, 0),
            Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                // mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(
                    height: 30.h,
                  ),
                  Text(
                    value,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 24.sp,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Text(
                    lable,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 19.sp,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );

  Widget _buiditeam1({
    required String lable,
    required String value,
    required IconData icon1,
  }) =>
      Container(
        height: 70.h,
        width: 160.w,
        decoration: BoxDecoration(
            color: MyTheme.accent_color,
            borderRadius: BorderRadius.circular(10)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            //SizedBox(width: 10,),
            Row(
              children: [
                SizedBox(
                  width: 10.w,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      lable,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.sp,
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Text(
                      value,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.sp,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            // Row(
            //   children: [
            //     Icon(
            //       icon1,
            //       size: 40,
            //       color: Colors.white,
            //     ),
            //     SizedBox(
            //       width: 10.w,
            //     ),
            //   ],
            // )
          ],
        ),
      );
}
