import 'package:dpl_ecommerce/const/app_theme.dart';
import 'package:dpl_ecommerce/models/address_infor.dart';
import 'package:dpl_ecommerce/models/city.dart';
import 'package:dpl_ecommerce/models/district.dart';
import 'package:dpl_ecommerce/models/shop.dart';
import 'package:dpl_ecommerce/repositories/product_repo.dart';
import 'package:dpl_ecommerce/utils/lang/lang_text.dart';
import 'package:dpl_ecommerce/view_model/seller/shop_view_model.dart';
import 'package:dpl_ecommerce/view_model/user_view_model.dart';
import 'package:dpl_ecommerce/views/seller/screens/chatlist.dart';
import 'package:dpl_ecommerce/views/seller/screens/payhistory.dart';
import 'package:dpl_ecommerce/views/seller/screens/product2/edit_product.dart';
import 'package:dpl_ecommerce/views/seller/screens/shop_setting/setting.dart';
import 'package:dpl_ecommerce/views/seller/screens/verification.dart';
import 'package:dpl_ecommerce/views/seller/screens/voucher/voucher_app.dart';
import 'package:dpl_ecommerce/views/seller/ui_elements/chart/chart_container.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dpl_ecommerce/models/product.dart';
import 'package:provider/provider.dart';

// ignore: depend_on_referenced_packages

// ignore: must_be_immutable
class Dashboard extends StatefulWidget {
  Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  // ignore: library_private_types_in_public_api
  @override
  Widget build(BuildContext context) {
    // print("ProductRepo().list: ${products!.length}");
    final userProvider = Provider.of<UserViewModel>(context);
    final user = userProvider.currentUser;
    final shopProvider = Provider.of<ShopViewModel>(context);
    final shop = shopProvider.shop;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyTheme.accent_color,
        title: Text(LangText(context: context).getLocal()!.dashboard_ucf),
        centerTitle: true,
        leadingWidth: 0,
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 40.h,
            ),
            Consumer<ShopViewModel>(
              builder: (context, value, child) => Padding(
                padding: const EdgeInsetsDirectional.all(8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        _buiditeam(
                            context: context,
                            lable: LangText(context: context)
                                .getLocal()!
                                .products_ucf,
                            value: value.shop != null
                                ? value.shop!.totalProduct.toString()
                                : "...",
                            icon1: CupertinoIcons.cube_box),
                        SizedBox(
                          height: 12.h,
                        ),
                        _buiditeam(
                            context: context,
                            lable: LangText(context: context)
                                .getLocal()!
                                .total_orders_ucf,
                            value: value.shop != null
                                ? value.shop!.totalOrder.toString()
                                : "...",
                            icon1: CupertinoIcons.square_list),
                      ],
                    ),
                    SizedBox(
                      width: 12.h,
                    ),
                    Column(
                      children: [
                        _buiditeam(
                            context: context,
                            lable: LangText(context: context)
                                .getLocal()!
                                .rating_ucf,
                            value: value.shop != null
                                ? value.shop!.rating.toString()
                                : "...",
                            icon1: CupertinoIcons.star),
                        SizedBox(
                          height: 12.h,
                        ),
                        _buiditeam(
                          context: context,
                          lable: LangText(context: context)
                              .getLocal()!
                              .total_revenue_ucf,
                          value: value.shop != null
                              ? value.shop!.totalRevenue.toString()
                              : '...',
                          icon1: Icons.money,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            buildViewWidget(context),
            SizedBox(
              height: 10.h,
            ),
            Container(
              height: 80.h,
              decoration: BoxDecoration(color: MyTheme.accent_color),
              child: Row(
                //crossAxisAlignment: CrossAxisAlignment.center,
                //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 20.w,
                  ),
                  GestureDetector(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ChatList(),
                      ),
                    ),
                    child: _buildicon(
                        name:
                            LangText(context: context).getLocal()!.messages_ucf,
                        icon: CupertinoIcons.chat_bubble_2_fill),
                  ),
                  const Spacer(),
                  GestureDetector(
                      onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => VoucherApp(),
                            ),
                          ),
                      child: _buildicon(
                          name: LangText(context: context)
                              .getLocal()!
                              .vouchers_ucf,
                          icon: CupertinoIcons.ticket_fill)),
                  // const Spacer(),
                  // GestureDetector(
                  //     onTap: () => Navigator.push(
                  //           context,
                  //           MaterialPageRoute(
                  //             builder: (context) => const PayHistory(),
                  //           ),
                  //         ),
                  //     child: _buildicon(
                  //         name: LangText(context: context)
                  //             .getLocal()!
                  //             .payment_history_ucf,
                  //         icon: Icons.history)),
                  const Spacer(),
                  GestureDetector(
                      onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SettingSeller(),
                            ),
                          ),
                      child: Container(
                          child: _buildicon(
                              name: LangText(context: context)
                                  .getLocal()!
                                  .settings_ucf,
                              icon: Icons.settings))),
                  SizedBox(
                    width: 20.w,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            !user!.userInfor!.sellerInfor!.isVerified! ||
                    user.userInfor!.sellerInfor!.isVerified == null
                ? Container(
                    height: 80.h,
                    padding:
                        EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                    width: MediaQuery.of(context).size.width * 0.9,
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(8)),
                    child: Center(
                      child: Column(
                        children: [
                          SizedBox(
                            width: 20.w,
                          ),
                          Text(
                            LangText(context: context)
                                .getLocal()!
                                .your_account_is_unverified,
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: Colors.white,
                            ),
                          ),
                          const Spacer(),
                          Consumer<ShopViewModel>(
                              builder: (context, value, child) {
                            if (value.shop != null) {
                              return GestureDetector(
                                onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        Verification(shopID: value.shop!.id!),
                                  ),
                                ),
                                child: Container(
                                  height: 30.h,
                                  width: 100.w,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(8)),
                                  child: Center(
                                    child: Text(
                                      LangText(context: context)
                                          .getLocal()!
                                          .verify_now,
                                      style: TextStyle(
                                        color: Colors.blue,
                                        fontSize: 12.sp,
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            } else {
                              return const SizedBox();
                            }
                          }),
                          SizedBox(
                            width: 20.w,
                          ),
                        ],
                      ),
                    ),
                  )
                : Container(),
            Padding(
              padding: EdgeInsets.all(20.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Text(LangText(context: context).getLocal()!.sales_stat_ucf),
                  // SizedBox(
                  //   height: 10.h,
                  // ),
                  // TextFormField(
                  //   maxLines: 4,
                  //   decoration: InputDecoration(
                  //     contentPadding: const EdgeInsets.symmetric(
                  //         vertical: 10.0, horizontal: 10.0),
                  //     filled: true,
                  //     hoverColor: const Color(0XFFDADADA),
                  //     border: OutlineInputBorder(
                  //         borderRadius: BorderRadius.circular(10),
                  //         borderSide: BorderSide.none),
                  //   ),
                  // ),
                  // Consumer<ShopViewModel>(
                  //   builder: (context, value, child) {
                  //     if (value.shop != null) {
                  //       return ChartContainer();
                  //     }
                  //     return Container();
                  //   },
                  // ),
                  // SizedBox(
                  //   height: 10.h,
                  // ),

                  Text(LangText(context: context)
                      .getLocal()!
                      .your_categories_ucf),
                  SizedBox(
                    height: 10.h,
                  ),
                  // products != null && products!.isNotEmpty
                  // ? SingleChildScrollView(
                  //     child: Container(
                  //       height: 120.h,
                  //       // width: double.infinity,
                  //       child: ListView.separated(
                  //           separatorBuilder: (context, index) => SizedBox(
                  //                 width: 10.w,
                  //               ),
                  //           scrollDirection: Axis.horizontal,
                  //           // shrinkWrap: true,
                  //           //scrollDirection: Axis.horizontal,
                  //           physics: const BouncingScrollPhysics(),
                  //           itemCount: products!.length,
                  //           itemBuilder: (BuildContext context, int index) {
                  //             return Container(
                  //               height: 80.h,
                  //               width: 80.h,
                  //               child: Stack(
                  //                 children: [
                  //                   ClipRRect(
                  //                     borderRadius:
                  //                         BorderRadius.circular(10.r),
                  //                     child: Image.network(
                  //                         products![0]!.images![0]),
                  //                   ),
                  //                   Positioned.fill(
                  //                     child: Align(
                  //                       alignment: Alignment.center,
                  //                       child: Column(
                  //                         crossAxisAlignment:
                  //                             CrossAxisAlignment.center,
                  //                         //mainAxisAlignment: MainAxisAlignment.center,
                  //                         children: [
                  //                           SizedBox(
                  //                             height: 20.h,
                  //                           ),
                  //                           Text(
                  //                             products![index].name!,
                  //                             style: TextStyle(
                  //                               color: Colors.white,
                  //                               fontSize: 18.sp,
                  //                             ),
                  //                           ),
                  //                           Text(
                  //                             products![index]
                  //                                 .availableQuantity
                  //                                 .toString(),
                  //                             style: TextStyle(
                  //                               color: Colors.white,
                  //                               fontSize: 18.sp,
                  //                             ),
                  //                           ),
                  //                         ],
                  //                       ),
                  //                     ),
                  //                   ),
                  //                 ],

                  //                 // title: Text(list![index].name!),
                  //                 //subtitle:Text(list![index].availableQuantity.toString()),
                  //               ),
                  //             );
                  //           }),
                  //     ),
                  //   )
                  // : Container(),
                  SizedBox(
                    height: 20.h,
                  ),
                  Text(LangText(context: context).getLocal()!.top_products_ucf),
                  SizedBox(
                    height: 5.h,
                  ),
                  Consumer<ShopViewModel>(
                    builder: (context, value, child) {
                      if (value.shop != null) {
                        return ListTopProductOfShop(shopID: value.shop!.id!);
                      }
                      return Container();
                    },
                  ),

                  // // Expanded(
                  //   child: ListView.builder(
                  //     itemCount: 4,
                  //     itemBuilder: (context, index){
                  //       return Container(
                  //         color: Colors.blue,
                  //         child: ListTile(
                  //           title: Text("helo"),
                  //         ),
                  //       );
                  //     },

                  //     ),
                  // ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildViewWidget(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: MyTheme.accent_color),
      width: MediaQuery.of(context).size.width,
      // height: 60.h,

      padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 15.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(LangText(context: context).getLocal()!.view_number_ucf,
              style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w500,
                  color: MyTheme.white)),
          Consumer<ShopViewModel>(
            builder: (context, value, child) {
              if (value.shop != null) {
                return Text(
                  value.shop!.shopView.toString(),
                  style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w500,
                      color: MyTheme.white),
                );
              } else {
                return Container();
              }
            },
          )
        ],
      ),
    );
  }

  Widget _buiditeam(
          {required String lable,
          required String value,
          required IconData icon1,
          required BuildContext context}) =>
      Container(
        padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 2.h),
        height: 70.h,
        width: MediaQuery.of(context).size.width * 0.44,
        decoration: BoxDecoration(
            color: MyTheme.accent_color,
            borderRadius: BorderRadius.circular(10)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            //SizedBox(width: 10,),
            SizedBox(
              width: 10.h,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  lable,
                  textAlign: TextAlign.center,
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
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w700),
                ),
              ],
            ),
            Row(
              children: [
                Icon(
                  icon1,
                  size: 24,
                  color: Colors.white,
                ),
                SizedBox(
                  width: 10.w,
                ),
              ],
            )
          ],
        ),
      );

  Widget _buildicon({
    required String name,
    required IconData icon,
  }) =>
      Column(
        //crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 25,
            color: Colors.white,
          ),
          SizedBox(
            height: 5.h,
          ),
          Text(
            name,
            style: TextStyle(fontSize: 14.sp, color: Colors.white),
          ),
        ],
      );

  Widget _buildoder({
    required String name1,
    required String value,
    required IconData ic,
  }) =>
      Container(
        height: 80,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            width: 1,
            color: const Color(0XFFDADADA),
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 20.w,
            ),
            Icon(
              ic,
              size: 40,
            ),
            SizedBox(
              width: 20.w,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 10.h,
                ),
                Text(
                  name1,
                  style: TextStyle(
                    fontSize: 18.sp,

                    ///fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 8.h,
                ),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 18.sp,
                    //fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            )
          ],
        ),
      );
}

class ListTopProductOfShop extends StatefulWidget {
  ListTopProductOfShop({super.key, required this.shopID});
  String shopID;

  @override
  State<ListTopProductOfShop> createState() => _ListTopProductOfShopState();
}

class _ListTopProductOfShopState extends State<ListTopProductOfShop> {
  ProductRepo productRepo = ProductRepo();
  List<Product>? list;
  bool isLoading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    list = await productRepo.getListTopProductByShop(widget.shopID);
    isLoading = false;
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Container()
        : list == null || list!.isEmpty
            ? Container(
                height: 40.h,
                child: Center(
                  child: Text(LangText(context: context)
                      .getLocal()!
                      .no_data_is_available),
                ),
              )
            : ListView.builder(
                shrinkWrap: true,
                itemCount: list!.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: EdgeInsets.fromLTRB(0, 5.h, 0, 5.h),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) {
                            return EditProductScreen(
                              product: list![index],
                            );
                          },
                        ));
                      },
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
                          borderRadius: BorderRadius.circular(8.r),
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Image.network(
                                list![0]!.images![0],
                                height: 80.h,
                                width: 80.w,
                                fit: BoxFit.cover,
                              ),
                              SizedBox(
                                width: 15.w,
                              ),
                              Container(
                                height: 100.h,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: 10.h,
                                    ),
                                    Text(
                                      list![index].name!,
                                      style: TextStyle(fontSize: 16.sp),
                                    ),
                                    Text(
                                      list![index].types.toString(),
                                      style: TextStyle(
                                        fontSize: 16.sp,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10.h,
                                    ),
                                    Text(
                                      list![index].price.toString(),
                                      style: TextStyle(
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                });
    // ;
  }
}
