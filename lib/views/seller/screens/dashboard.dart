import 'package:dpl_ecommerce/models/address_infor.dart';
import 'package:dpl_ecommerce/models/city.dart';
import 'package:dpl_ecommerce/models/district.dart';
import 'package:dpl_ecommerce/models/shop.dart';
import 'package:dpl_ecommerce/repositories/product_repo.dart';
import 'package:dpl_ecommerce/utils/lang/lang_text.dart';
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

// ignore: depend_on_referenced_packages

// ignore: must_be_immutable
class Dashboard extends StatelessWidget {
  Dashboard({super.key});
  // ignore: library_private_types_in_public_api
  final List<Product>? products = ProductRepo().list;
  Shop shop = Shop(
    ratingCount: 123,
    totalProduct: 32,
    name: "DK",
    addressInfor: AddressInfor(
        city: City(id: 8, name: "Tuyen Quang"),
        country: "Viet nam",
        isDefaultAddress: false,
        latitude: 123.12,
        longitude: 123,
        name: "My address",
        district: District(id: 123, name: "Hoang Mai")),
    contactPhone: "0987654321",
    id: "shopID01",
    shopDescription:
        "Cultivate your love for gardening with Green Thumb Nursery. We offer a variety of plants, gardening tools, and expert advice to help you create a vibrant and thriving garden.",
    logo:
        "https://cdn.shopify.com/shopifycloud/hatchful_web_two/bundles/4a14e7b2de7f6eaf5a6c98cb8c00b8de.png",
    rating: 4.4,
    shopView: 120,
    totalRevenue: 120000,
    totalOrder: 12,
  );
  @override
  Widget build(BuildContext context) {
    print("ProductRepo().list: ${products!.length}");
    return Scaffold(
      appBar: AppBar(
        title: Text(LangText(context: context).getLocal()!.facebook_ucf),
      ),
      body: SingleChildScrollView(
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
                          lable: "Products",
                          value: shop.totalProduct.toString(),
                          icon1: CupertinoIcons.cube_box),
                      SizedBox(
                        height: 12.h,
                      ),
                      _buiditeam(
                          lable: "Total Orders",
                          value: shop.totalOrder.toString(),
                          icon1: CupertinoIcons.square_list),
                    ],
                  ),
                  SizedBox(
                    width: 12.h,
                  ),
                  Column(
                    children: [
                      _buiditeam(
                          lable: "Rating",
                          value: shop.rating.toString(),
                          icon1: CupertinoIcons.star),
                      SizedBox(
                        height: 12.h,
                      ),
                      _buiditeam(
                        lable: "Total Sales",
                        value: shop.totalRevenue.toString(),
                        icon1: Icons.money,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            Container(
              height: 80.h,
              color: const Color.fromRGBO(33, 150, 243, 1),
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
                        name: "Messages",
                        icon: CupertinoIcons.chat_bubble_2_fill),
                  ),
                  const Spacer(),
                  GestureDetector(
                      onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const VoucherApp(),
                            ),
                          ),
                      child: _buildicon(
                          name: "Coupons", icon: CupertinoIcons.ticket_fill)),
                  const Spacer(),
                  GestureDetector(
                      onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const PayHistory(),
                            ),
                          ),
                      child: _buildicon(
                          name: "Payment History", icon: Icons.history)),
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
                              name: "Setting", icon: Icons.settings))),
                  SizedBox(
                    width: 20.w,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            Container(
              height: 80.h,
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
              width: MediaQuery.of(context).size.width * 0.9,
              decoration: BoxDecoration(
                  color: Colors.blue, borderRadius: BorderRadius.circular(8)),
              child: Center(
                child: Column(
                  children: [
                    SizedBox(
                      width: 20.w,
                    ),
                    Text(
                      "Your account has not been verified",
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: Colors.white,
                      ),
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Verification(),
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
                            "Verify now",
                            style: TextStyle(
                              color: Colors.blue,
                              fontSize: 12.sp,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 20.w,
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(20.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Sales statistics"),
                  SizedBox(
                    height: 10.h,
                  ),
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
                  ChartContainer(),
                  SizedBox(
                    height: 10.h,
                  ),

                  const Text("Your Categories"),
                  SizedBox(
                    height: 10.h,
                  ),
                  products != null && products!.isNotEmpty
                      ? SingleChildScrollView(
                          child: Container(
                            height: 120.h,
                            // width: double.infinity,
                            child: ListView.separated(
                                separatorBuilder: (context, index) => SizedBox(
                                      width: 10,
                                    ),
                                scrollDirection: Axis.horizontal,
                                // shrinkWrap: true,
                                //scrollDirection: Axis.horizontal,
                                physics: BouncingScrollPhysics(),
                                itemCount: products!.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return Container(
                                    height: 80.h,
                                    width: 80.h,
                                    child: Stack(
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          child: Image.network(
                                              products![0]!.images![0]),
                                        ),
                                        Positioned.fill(
                                          child: Align(
                                            alignment: Alignment.center,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              //mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                SizedBox(
                                                  height: 20.h,
                                                ),
                                                Text(
                                                  products![index].name!,
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 18.sp,
                                                  ),
                                                ),
                                                Text(
                                                  products![index]
                                                      .availableQuantity
                                                      .toString(),
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 18.sp,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],

                                      // title: Text(list![index].name!),
                                      //subtitle:Text(list![index].availableQuantity.toString()),
                                    ),
                                  );
                                }),
                          ),
                        )
                      : Container(),
                  SizedBox(
                    height: 20.h,
                  ),

                  const Text("Top Prducts"),
                  SizedBox(
                    height: 5.h,
                  ),
                  ListView.builder(
                      shrinkWrap: true,
                      itemCount: products!.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: EdgeInsets.fromLTRB(0, 5.h, 0, 5.h),
                          child: GestureDetector(
                            onTap: () {
                              // Navigator.of(context).push(MaterialPageRoute(
                              //   builder: (context) {
                              //     return EditProductScreen(
                              //         product: product,
                              //         onProductUpdated: onProductUpdated,
                              //         products: products);
                              //   },
                              // ));
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
                                      products![0]!.images![0],
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
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            height: 10.h,
                                          ),
                                          Text(
                                            products![index].name!,
                                            style: TextStyle(fontSize: 16.sp),
                                          ),
                                          Text(
                                            products![index].types.toString(),
                                            style: TextStyle(
                                              fontSize: 16.sp,
                                              color: Colors.grey,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 10.h,
                                          ),
                                          Text(
                                            products![index].price.toString(),
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
                      }),
                  // Expanded(
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

  Widget _buiditeam({
    required String lable,
    required String value,
    required IconData icon1,
  }) =>
      Container(
        height: 70,
        width: 180,
        decoration: BoxDecoration(
            color: Colors.blue, borderRadius: BorderRadius.circular(10)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            //SizedBox(width: 10,),
            Row(
              children: [
                SizedBox(
                  width: 10.h,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      lable,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.sp,
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
            Row(
              children: [
                Icon(
                  icon1,
                  size: 40,
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
