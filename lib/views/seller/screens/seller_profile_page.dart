import 'package:cached_network_image/cached_network_image.dart';
import 'package:dpl_ecommerce/const/app_theme.dart';
import 'package:dpl_ecommerce/customs/custom_array_back_widget.dart';
import 'package:dpl_ecommerce/customs/custom_text_style.dart';
import 'package:dpl_ecommerce/models/address_infor.dart';
import 'package:dpl_ecommerce/models/category.dart';
import 'package:dpl_ecommerce/models/flash_sale.dart';
import 'package:dpl_ecommerce/models/product.dart';
import 'package:dpl_ecommerce/models/shop.dart';
import 'package:dpl_ecommerce/models/voucher.dart';
import 'package:dpl_ecommerce/repositories/category_repo.dart';
import 'package:dpl_ecommerce/repositories/flash_sale_repo.dart';
import 'package:dpl_ecommerce/repositories/product_repo.dart';
import 'package:dpl_ecommerce/repositories/voucher_repo.dart';
import 'package:dpl_ecommerce/utils/constants/size_utils.dart';
import 'package:dpl_ecommerce/views/consumer/ui_elements/list_voucher_widget.dart';
import 'package:dpl_ecommerce/views/consumer/ui_elements/product_item_widget1.dart';
import 'package:dpl_ecommerce/views/consumer/ui_elements/product_small_list_item1_widget.dart';
import 'package:dpl_ecommerce/views/seller/screens/detail_seller_profile.dart';
import 'package:flutter/material.dart';

class ShopProfile extends StatefulWidget {
  @override
  _ShopProfileState createState() => _ShopProfileState();
}

class _ShopProfileState extends State<ShopProfile>
    with SingleTickerProviderStateMixin {
  int isSelected = 0;
  late TabController _tabController;
  int selectedIndex = -1;
  List<FlashSale>? listFlashSale = FlashSaleRepo().list;
  List<Product>? listProduct = ProductRepo().list;
  List<Category>? listCategory = CategoryRepo().list;
  List<Voucher> listVoucher = VoucherRepo().list;
  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this, initialIndex: 0);
    _tabController.addListener(_handleTabSelection);
    super.initState();
  }

  _handleTabSelection() {
    if (_tabController.indexIsChanging) {
      setState(() {});
    }
  }

  Shop shop = Shop(
      name: "Sports World",
      addressInfor: AddressInfor(
          city: "Phan Thiet",
          country: "Viet Nam",
          isDefaultAddress: false,
          latitude: 10.931838,
          longitude: 108.103235,
          name: "My Address 9",
          state: "Phan Thiet City"),
      contactPhone: "0917123456",
      id: "shop09",
      shopDescription:
          "Cultivate your love for gardening with Green Thumb Nursery. We offer a variety of plants, gardening tools, and expert advice to help you create a vibrant and thriving garden.",
      logo:
          "https://t3.ftcdn.net/jpg/01/22/72/98/360_F_122729880_a4rHgPGiwVktwwsovKfL2iqrd2vM042R.jpg",
      rating: 4.0,
      shopView: 70);
  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          AppBar(leading: CustomArrayBackWidget(), title: Text("Shop detail")),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(children: [
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProfileSeller(),
                            ),
                          ),
                          child: CircleAvatar(
                            radius: 35,
                            backgroundImage: NetworkImage(shop.logo!),
                          ),
                        ),
                        const SizedBox(
                          width: 12,
                        ),
                        GestureDetector(
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProfileSeller(),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                shop.name!,
                                style: TextStyle(
                                    fontSize: 17, fontWeight: FontWeight.bold),
                              ),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.star,
                                    color: Color.fromARGB(255, 230, 207, 6),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text(shop.rating != null
                                      ? shop.rating.toString()
                                      : ""),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  // Text("|"),
                                  // SizedBox(
                                  //   width: 5,
                                  // ),
                                  //Text("900k followers")
                                ],
                              ),
                            ],
                          ),
                        ),
                        const Spacer(),
                        Column(
                          children: [
                            Center(
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 8),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                ),
                                onPressed: () {
                                  // TODO: Add button press logic
                                },
                                child: const Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      Icons.chat,
                                      color: Colors.white,
                                    ),
                                    SizedBox(width: 8),
                                    Text(
                                      'Chat',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          width: 10,
                        )
                      ],
                    ),
                    TabBar(
                        controller: _tabController,
                        labelColor: Colors.blue,
                        unselectedLabelColor: Colors.black,
                        isScrollable: true,
                        indicator: const UnderlineTabIndicator(
                            borderSide: BorderSide(
                              width: 3,
                              color: Colors.blue,
                            ),
                            insets: EdgeInsets.symmetric(horizontal: 16)),
                        labelPadding:
                            const EdgeInsets.symmetric(horizontal: 20),
                        labelStyle: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w500),
                        tabs: const [
                          Tab(text: "Shop"),
                          Tab(text: "Products"),
                          Tab(text: "Product category"),
                          //Tab(text: "Live"),
                        ]),
                    SizedBox(
                      height: 10,
                    ),
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: [
                        Container(
                          //color: Colors.pink,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                ListVoucherWidget(list: listVoucher),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 10.h, vertical: 6),
                                  child: _buildDealOfTheDay(
                                    context,
                                    dealOfTheDayText: "Recommend",
                                    viewAllText: "View all",
                                  ),
                                ),
                                _buildDealOfTheDayRow(context, listProduct!),
                                SizedBox(height: 26.v),
                                Align(
                                    alignment: Alignment.bottomLeft,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          shop.name!,
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          shop.shopDescription!,
                                          overflow: TextOverflow.clip,
                                          textAlign: TextAlign.left,
                                          style: const TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w300),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          shop.contactPhone!,
                                          textAlign: TextAlign.left,
                                          style: const TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w400),
                                        ),
                                      ],
                                    )),
                                Padding(
                                  padding:
                                      EdgeInsets.only(bottom: 5.v, left: 10.v),
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 10.h,
                                        ),
                                        //padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                                        child: _buildDealOfTheDay(
                                          context,
                                          dealOfTheDayText: "",
                                          viewAllText: "",
                                        ),
                                      ),
                                      _buildProductSmallList1(
                                          context, listProduct!),
                                    ],
                                  ),
                                ),
                                //SizedBox(height: 16.v),
                              ],
                            ),
                          ),

                          //color: Colors.white,
                        ),
                        Container(
                          //color: Colors.red,
                          child: Padding(
                            padding: EdgeInsets.only(bottom: 5.v, left: 10.v),
                            child: Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 10.h,
                                  ),
                                  //padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                                  child: _buildDealOfTheDay(
                                    context,
                                    dealOfTheDayText: "",
                                    viewAllText: "",
                                  ),
                                ),
                                _buildProductSmallList1(context, listProduct!),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          //color: Colors.red,
                          child: Column(
                            children: listCategory!.map((category) {
                              return ListTile(
                                leading: CachedNetworkImage(
                                  imageUrl: category.logo!,
                                  imageBuilder: (context, imageProvider) {
                                    return Container(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.08,
                                      width: MediaQuery.of(context).size.width *
                                          0.1,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: imageProvider),
                                      ),
                                    );
                                  },
                                  placeholder: (context, url) => Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                ),
                                title: Text(category.name!),
                              );
                            }).toList(),
                          ),
                        ),
                      ][_tabController.index],
                    ),
                  ]),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // _buildProductCategory({required int index, required String name}) =>
  // GestureDetector(
  //   onTap: () => setState(() => isSelected = index),
  //   child: Container(
  //     width: 100,
  //     height: 40,
  //     margin:  const EdgeInsets.only(top: 10, right: 10),
  //     alignment: Alignment.center,
  //     decoration: BoxDecoration(
  //       color: isSelected == index ? Colors.red :Colors.red.shade300,
  //       borderRadius: BorderRadius.circular(8),
  //     ),
  //     child: Text(name,
  //     style: const TextStyle(color: Colors.white,),),
  //   ),
  // );
  //  Widget buildProductCategory({required int index, required String name}) {
  //   return GestureDetector(
  //     onTap: () => setState(() => isSelected = index),
  //     child: Container(
  //       width: 100,
  //       height: 40,
  //       margin: const EdgeInsets.only(top: 10, right: 10),
  //       alignment: Alignment.center,
  //       decoration: BoxDecoration(
  //         color: isSelected == index ? Colors.red : Colors.red.shade300,
  //         borderRadius: BorderRadius.circular(8),
  //       ),
  //       child: Text(
  //         name,
  //         style: TextStyle(
  //           color: isSelected == index ? Colors.white : Colors.black,
  //         ),
  //       ),
  //     ),
  //   );
  // }
}

Widget _buildDealOfTheDay(
  BuildContext context, {
  required String dealOfTheDayText,
  required String viewAllText,
}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Padding(
        padding: EdgeInsets.only(top: 1.v),
        child: Text(
          dealOfTheDayText,
          style: theme.textTheme.titleSmall!.copyWith(
            color: theme.colorScheme.onPrimary,
          ),
        ),
      ),
      Padding(
        padding: EdgeInsets.only(bottom: 3.v),
        child: TextButton(
          onPressed: () {
            // go to see all
          },
          child: Text(
            viewAllText,
            style: CustomTextStyles.bodySmallGray600.copyWith(
              color: appTheme.gray600,
            ),
          ),
        ),
      ),
    ],
  );
}

Widget _buildDealOfTheDayRow(BuildContext context, List<Product> list) {
  return SizedBox(
    height: 220.v,
    child: ListView.separated(
      padding: EdgeInsets.only(left: 16.h),
      scrollDirection: Axis.horizontal,
      separatorBuilder: (
        context,
        index,
      ) {
        return SizedBox(
          width: 16.h,
        );
      },
      itemCount: list.length,
      itemBuilder: (context, index) {
        return ProductItemWidget(
          product: list[index],
        );
      },
    ),
  );
}

Widget _buildProductSmallList1(BuildContext context, List<Product> list) {
  return Padding(
    padding: EdgeInsets.only(right: 10.h),
    child: GridView.builder(
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        mainAxisExtent: 283.v,
        // childAspectRatio: 3 / 2,
      ),
      itemBuilder: (context, index) {
        return Productsmalllist1ItemWidget(
          product: list[index],
        );
      },
      physics: NeverScrollableScrollPhysics(),
      itemCount: list.length,
    ),
  );
}
