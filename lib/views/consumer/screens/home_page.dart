import 'package:carousel_slider/carousel_slider.dart';
import 'package:dpl_ecommerce/const/app_decoration.dart';
import 'package:dpl_ecommerce/const/app_theme.dart';
import 'package:dpl_ecommerce/customs/custom_badge_cart.dart';

import 'package:dpl_ecommerce/customs/custom_text_style.dart';
import 'package:dpl_ecommerce/data_sources/firestore_data_source/firestore_data.dart';
import 'package:dpl_ecommerce/data_sources/firestore_data_source/product_firestore_data.dart';
import 'package:dpl_ecommerce/helpers/shimmer_helper.dart';
import 'package:dpl_ecommerce/models/cart.dart';
import 'package:dpl_ecommerce/models/category.dart';
import 'package:dpl_ecommerce/models/consumer_infor.dart';
import 'package:dpl_ecommerce/models/product.dart';
import 'package:dpl_ecommerce/models/user.dart';
import 'package:dpl_ecommerce/repositories/category_repo.dart';
import 'package:dpl_ecommerce/repositories/flash_sale_repo.dart';
import 'package:dpl_ecommerce/repositories/product_repo.dart';
import 'package:dpl_ecommerce/utils/constants/image_data.dart';
import 'package:dpl_ecommerce/utils/lang/lang_text.dart';

import 'package:dpl_ecommerce/view_model/consumer/cart_view_model.dart';
import 'package:dpl_ecommerce/view_model/consumer/chat_view_model.dart';
import 'package:dpl_ecommerce/view_model/user_view_model.dart';
import 'package:dpl_ecommerce/views/consumer/screens/category_page.dart';
import 'package:dpl_ecommerce/views/consumer/screens/chat_page.dart';
import 'package:dpl_ecommerce/views/consumer/screens/ranking_screen.dart';

import 'package:dpl_ecommerce/views/consumer/screens/search_page.dart';
import 'package:dpl_ecommerce/views/consumer/screens/voucher_screen.dart';
import 'package:dpl_ecommerce/views/consumer/ui_elements/product_item_widget1.dart';
import 'package:dpl_ecommerce/views/consumer/ui_elements/product_small_list_item1_widget.dart';
import 'package:dpl_ecommerce/views/consumer/ui_elements/product_small_list_item_widget.dart';
import 'package:dpl_ecommerce/views/consumer/ui_elements/promotion_banner_item_widget.dart';
import 'package:dpl_ecommerce/views/consumer/ui_elements/category_item_widget.dart';
import 'package:dpl_ecommerce/views/seller/screens/product/product_app.dart';

import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:dpl_ecommerce/models/flash_sale.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});
  TextEditingController searchController = TextEditingController();
  int sliderIndex = 1;

  ProductRepo productRepo = ProductRepo();
  FlashSaleRepo flashSaleRepo = FlashSaleRepo();
  CategoryRepo categoryRepo = CategoryRepo();
  FirestoreDatabase firestoreDatabase = FirestoreDatabase();
  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartViewModel>(context);
    final chatProvider = Provider.of<ChatViewModel>(context);
    final useProvider = Provider.of<UserViewModel>(context);
    final user = useProvider.currentUser;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(
          LangText(context: context).getLocal()!.home_ucf,
          style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
              color: MyTheme.accent_color),
        ),
        actions: [
          StreamBuilder<Cart?>(
              stream: firestoreDatabase.getCartByUser(user!.id!),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  print("waiting");
                  return Icon(
                    CupertinoIcons.cart,
                    size: 30.h,
                    color: Colors.white,
                  );
                } else {
                  if (snapshot.data != null) {
                    final cart = snapshot.data;
                    cartProvider.setCart(cart!);
                    return Consumer<CartViewModel>(
                        builder: (context, value, child) {
                      return CustomBadgeCart(
                          number: value.cart!.productInCarts!.length);
                    });
                  } else {
                    print("Data is null");

                    cartProvider
                        .setCart(Cart(userID: user.id, productInCarts: []));
                    return CustomBadgeCart(number: 0);
                  }
                }
              }),
          // SizedBox(width: 15.w),
          // Center(
          //   child: badges.Badge(
          //     badgeContent: Text(
          //       "3",
          //       style: TextStyle(fontSize: 12.sp, color: Colors.white),
          //     ),
          //     child: InkWell(
          //       child: Icon(Icons.notifications_outlined,
          //           color: Colors.white, size: 30.sp),
          //       onTap: () {
          //         // Navigator.of(context).push(MaterialPageRoute(
          //         //   builder: (context) {
          //         //     return ProductsApp(products: []);
          //         //   },
          //         // ));
          //       },
          //     ),
          //   ),
          // ),
          SizedBox(width: 15.w),
          Center(
            child:
                //  Consumer<ChatViewModel>(
                //   builder: (context, value, child) {
                //     return badges.Badge(
                //       badgeContent: Text(
                //         value.list.length.toString(),
                //         style: TextStyle(fontSize: 12.sp, color: Colors.white),
                //       ),
                //       child:
                InkWell(
              child: Icon(
                Icons.chat_bubble_outline,
                size: 24.sp,
                color: Colors.white,
              ),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => ChatPage(),
                ));
              },
            ),
            // );
            //   },
            // ),
          ),
          SizedBox(
            width: 12.w,
          )
        ],
      ),
      body: Padding(
          padding: EdgeInsets.fromLTRB(5.w, 5.h, 0, 5.h),
          child: Container(
            width: double.maxFinite,
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 5.h, left: 0.h),
                      child: Column(
                        children: [
                          SizedBox(height: 18.h),
                          GestureDetector(
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SearchScreen(),
                              ),
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10.w, vertical: 5.h),
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.9,
                                height: 45.h,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.black,
                                      width: 0.5,
                                      style: BorderStyle.solid),
                                  borderRadius: BorderRadius.circular(15.r),
                                  color: Colors.white,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    // SizedBox(
                                    //   width: 20.w,
                                    // ),
                                    Text(
                                      LangText(context: context)
                                          .getLocal()!
                                          .search_anything,
                                      style: TextStyle(
                                          color: Colors.grey, fontSize: 14.sp),
                                    ),
                                    SizedBox(
                                      width: 50.w,
                                    ),
                                    Icon(
                                      Icons.search,
                                      size: 20.h,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),

                          SizedBox(height: 18.h),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10.h),
                            child: _buildDealOfTheDay(
                              context,
                              dealOfTheDayText: LangText(context: context)
                                  .getLocal()!
                                  .categories_ucf,
                              viewAllText: LangText(context: context)
                                  .getLocal()!
                                  .view_more_ucf,
                              onCall: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const CategoryPage(),
                                    ));
                              },
                            ),
                          ),
                          // SizedBox(height: 15.h),
                          _buildCategoryList(context),
                          // SizedBox(height: 20.h),
                          // _buildPromotionBanner(context),
                          SizedBox(height: 18.h),
                          Container(
                            padding: EdgeInsets.symmetric(vertical: 5.h),
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: MyTheme.accent_color, width: 0.2),
                                color: MyTheme.golden_shadow,
                                borderRadius: BorderRadius.circular(5.r)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                      builder: (context) => VoucherScreen(),
                                    ));
                                  },
                                  child: Container(
                                    height: 40.h,
                                    width: MediaQuery.of(context).size.width *
                                        0.48,
                                    // decoration: BoxDecoration(
                                    //     border: Border.all(
                                    //         color: MyTheme.accent_color,
                                    //         width: 0.2),
                                    //     // color: MyTheme.golden_shadow,
                                    //     borderRadius:
                                    //         BorderRadius.circular(10.r)),
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 10.w, vertical: 5.h),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Icon(
                                          Icons.card_giftcard_rounded,
                                          size: 20.h,
                                        ),
                                        // SizedBox(
                                        //   width: 5.w,
                                        // ),
                                        Text(LangText(context: context)
                                            .getLocal()!
                                            .vouchers_ucf)
                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                  height: 40.h,
                                  width: 0.2.w,
                                  color: MyTheme.black,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                      builder: (context) => RankUser(),
                                    ));
                                  },
                                  child: Container(
                                    height: 40.h,
                                    width: MediaQuery.of(context).size.width *
                                        0.48,
                                    // constraints: BoxConstraints(
                                    //     maxHeight: 40.h),
                                    // decoration: BoxDecoration(
                                    //     border: Border.all(
                                    //         color: MyTheme.accent_color,
                                    //         width: 0.2),
                                    //     color: MyTheme.golden_shadow,
                                    //     borderRadius:
                                    //         BorderRadius.circular(10.r)),
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 10.w, vertical: 5.h),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        SvgPicture.asset(
                                          "assets/images/ranking-star-solid.svg",
                                          height: 30,
                                          width: 30,
                                        ),
                                        // SizedBox(
                                        //   width: 5.w,
                                        // ),
                                        Text(LangText(context: context)
                                            .getLocal()!
                                            .raking_ucf)
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          // SizedBox(height: 8.h),
                          SizedBox(
                            height: 6.h,
                            child: AnimatedSmoothIndicator(
                              activeIndex: sliderIndex,
                              count: 1,
                              axisDirection: Axis.horizontal,
                              effect: ScrollingDotsEffect(
                                spacing: 8,
                                activeDotColor:
                                    theme.colorScheme.primaryContainer,
                                dotColor: appTheme.gray200,
                                dotHeight: 6.h,
                                dotWidth: 6.h,
                              ),
                            ),
                          ),
                          SizedBox(height: 10.h),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 10.h, vertical: 6),
                            child: _buildDealOfTheDay(
                              context,
                              dealOfTheDayText: LangText(context: context)
                                  .getLocal()!
                                  .deal_of_the_day,
                              viewAllText: "",
                            ),
                          ),
                          _buildDealOfTheDayRow(context),
                          SizedBox(height: 26.h),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10.h),
                            child: _buildDealOfTheDay(
                              context,
                              dealOfTheDayText: LangText(context: context)
                                  .getLocal()!
                                  .top_products_ucf,
                              viewAllText: "",
                            ),
                          ),
                          SizedBox(height: 16.h),
                          _buildTopProductSmallList(context),
                          SizedBox(height: 25.h),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10.h),
                            child: _buildDealOfTheDay(
                              context,
                              dealOfTheDayText: LangText(context: context)
                                  .getLocal()!
                                  .recommended_ucf,
                              viewAllText: LangText(context: context)
                                  .getLocal()!
                                  .view_more_ucf,
                            ),
                          ),
                          SizedBox(height: 16.h),
                          _buildProductSmallList1(context),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )),
    );
  }

  /// Section Widget
  Widget _buildPromotionBanner(BuildContext context) {
    return FutureBuilder(
        future: flashSaleRepo.getActiveFlashSale(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            if (snapshot.data != null) {
              final list = snapshot.data;
              return Padding(
                padding: EdgeInsets.only(right: 16.h),
                child: CarouselSlider.builder(
                  options: CarouselOptions(
                    height: 206.h,
                    initialPage: 0,
                    autoPlay: true,
                    viewportFraction: 1.0,
                    enableInfiniteScroll: false,
                    scrollDirection: Axis.horizontal,
                    onPageChanged: (
                      index,
                      reason,
                    ) {
                      sliderIndex = index;
                    },
                  ),
                  itemCount: list!.length,
                  itemBuilder: (context, index, realIndex) {
                    return PromotionbannerItemWidget(
                      flashSale: list[index],
                    );
                  },
                ),
              );
            } else {
              return Container(
                height: 40.h,
                child: Center(
                    child: Text(LangText(context: context)
                        .getLocal()!
                        .no_data_is_available)),
              );
            }
          }
        });
  }

  /// Section Widget
  Widget _buildCategoryList(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(2.h),
      height: MediaQuery.of(context).size.height * 0.12,
      child: FutureBuilder(
        future: categoryRepo.getListCategory(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            if (snapshot.data != null) {
              final list = snapshot.data;
              return ListView.separated(
                padding: EdgeInsets.only(left: 10.h),
                scrollDirection: Axis.horizontal,
                separatorBuilder: (context, index) {
                  return SizedBox(
                    width: 18.h,
                  );
                },
                itemCount: list!.length,
                itemBuilder: (context, index) {
                  return CategoryItemWidget(
                    category: list[index],
                  );
                },
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          }
        },
      ),
    );
  }

  /// Section Widget
  // Widget _buildTwoSlider(BuildContext context) {
  //   return CarouselSlider.builder(
  //     options: CarouselOptions(
  //       height: 140.h,
  //       initialPage: 0,
  //       autoPlay: true,
  //       viewportFraction: 1.0,
  //       enableInfiniteScroll: false,
  //       scrollDirection: Axis.horizontal,
  //       onPageChanged: (
  //         index,
  //         reason,
  //       ) {
  //         sliderIndex = index;
  //       },
  //     ),
  //     itemCount: 5,
  //     itemBuilder: (context, index, realIndex) {
  //       return TwosliderItemWidget();
  //     },
  //   );
  // }

  /// Section Widget
  Widget _buildDealOfTheDayColumn(BuildContext context, List<Product> list) {
    return Container(
      padding: EdgeInsets.all(16.h),
      decoration: AppDecoration.gradientGrayToGray,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 2.h),
          _buildDealOfTheDay(
            context,
            dealOfTheDayText: "lbl_deal_of_the_day",
            viewAllText: "lbl_view_all",
          ),
          SizedBox(height: 8.h),
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: 8.h,
                vertical: 3.h,
              ),
              decoration: AppDecoration.fillRed.copyWith(
                borderRadius: BorderRadiusStyle.roundedBorder2,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "lbl_11",
                    style: CustomTextStyles.titleSmallOnPrimaryContainer,
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      left: 9.h,
                      top: 3.h,
                      bottom: 3.h,
                    ),
                    child: Text(
                      "lbl_hrs",
                      style: theme.textTheme.labelSmall,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 12.h),
                    child: Text(
                      "lbl_15",
                      style: CustomTextStyles.titleSmallOnPrimaryContainer,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      left: 7.h,
                      top: 3.h,
                      bottom: 3.h,
                    ),
                    child: Text(
                      "lbl_min",
                      style: theme.textTheme.labelSmall,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 12.h),
                    child: Text(
                      "lbl_04",
                      style: CustomTextStyles.titleSmallOnPrimaryContainer,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      left: 5.h,
                      top: 3.h,
                      bottom: 3.h,
                    ),
                    child: Text(
                      "lbl_sec",
                      style: theme.textTheme.labelSmall,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 16.h),
          Container(
            padding: EdgeInsets.all(16.h),
            decoration: AppDecoration.fillOnPrimaryContainer.copyWith(
              borderRadius: BorderRadiusStyle.roundedBorder2,
            ),
            child: GridView.builder(
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                mainAxisExtent: 191.h,
                crossAxisCount: 2,
                mainAxisSpacing: 16.h,
                crossAxisSpacing: 16.h,
              ),
              physics: NeverScrollableScrollPhysics(),
              itemCount: list.length,
              itemBuilder: (context, index) {
                return ProductItemWidget(
                  product: list[index],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDealOfTheDayRow(BuildContext context) {
    return SizedBox(
      height: 220.h,
      child: StreamBuilder(
        stream: firestoreDatabase.getListActiveProduct(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            if (snapshot.data != null) {
              final list = snapshot.data;
              return ListView.separated(
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
                itemCount: list!.length,
                itemBuilder: (context, index) {
                  return ProductItemWidget(
                    product: list[index],
                  );
                },
              );
            } else {
              return Center(
                child: Image.asset(ImageData.imageNotFound),
              );
            }
          }
        },
      ),
    );
  }

  /// Section Widget
  Widget _buildTopProductSmallList(BuildContext context) {
    return SizedBox(
      height: 230.h,
      child: FutureBuilder(
        future: firestoreDatabase.getListTopActiveProduct(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            if (snapshot.data != null) {
              final list = snapshot.data;
              return ListView.separated(
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
                itemCount: list!.length,
                itemBuilder: (context, index) {
                  return ProductsmalllistItemWidget(
                    product: list[index],
                  );
                },
              );
            } else {
              return Center(
                child: Image.asset(ImageData.imageNotFound),
              );
            }
          }
        },
      ),
    );
  }

  /// Section Widget
  Widget _buildProductSmallList1(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 10.h),
      child: StreamBuilder(
        stream: firestoreDatabase.getListActiveProduct(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            if (snapshot.data != null) {
              final list = snapshot.data;
              return GridView.builder(
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10.w,
                  mainAxisSpacing: 10.h,
                  mainAxisExtent: 283.h,
                  // childAspectRatio: 3 / 2,
                ),
                itemBuilder: (context, index) {
                  return Productsmalllist1ItemWidget(
                    product: list[index],
                  );
                },
                physics: NeverScrollableScrollPhysics(),
                itemCount: list!.length,
              );
            } else {
              return Center(
                child: Image.asset(ImageData.imageNotFound),
              );
            }
          }
        },
      ),
    );
  }

  /// Common widget
  Widget _buildDealOfTheDay(BuildContext context,
      {required String dealOfTheDayText,
      required String viewAllText,
      Function()? onCall}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: EdgeInsets.only(top: 1.h),
          child: Text(
            dealOfTheDayText,
            style: theme.textTheme.titleSmall!.copyWith(
              color: theme.colorScheme.onPrimary,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(bottom: 3.h),
          child: TextButton(
            onPressed:
                // go to see all
                // if (onCall != null) {
                onCall
            // }
            ,
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
}
