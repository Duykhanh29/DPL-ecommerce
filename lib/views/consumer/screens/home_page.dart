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
import 'package:dpl_ecommerce/models/product.dart';
import 'package:dpl_ecommerce/repositories/category_repo.dart';
import 'package:dpl_ecommerce/repositories/flash_sale_repo.dart';
import 'package:dpl_ecommerce/repositories/product_repo.dart';
import 'package:dpl_ecommerce/utils/constants/image_data.dart';

import 'package:dpl_ecommerce/view_model/consumer/cart_view_model.dart';
import 'package:dpl_ecommerce/view_model/consumer/chat_view_model.dart';
import 'package:dpl_ecommerce/view_model/user_view_model.dart';
import 'package:dpl_ecommerce/views/consumer/screens/chat_page.dart';

import 'package:dpl_ecommerce/views/consumer/screens/search_page.dart';
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
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

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
        title: Text("Home"),
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
          const SizedBox(width: 15),
          Center(
            child: badges.Badge(
              badgeContent: Text(
                "3",
                style: TextStyle(fontSize: 12, color: Colors.white),
              ),
              child: InkWell(
                child: Icon(Icons.notifications_outlined,
                    color: Colors.white, size: 30),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) {
                      return ProductsApp(products: []);
                    },
                  ));
                },
              ),
            ),
          ),
          const SizedBox(width: 15),
          Center(
            child: Consumer<ChatViewModel>(
              builder: (context, value, child) {
                return badges.Badge(
                  badgeContent: Text(
                    value.list.length.toString(),
                    style: TextStyle(fontSize: 12, color: Colors.white),
                  ),
                  child: InkWell(
                    child: Icon(
                      Icons.chat_bubble_outline,
                      size: 24,
                      color: Colors.white,
                    ),
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => ChatPage(),
                      ));
                    },
                  ),
                );
              },
            ),
          ),
          const SizedBox(
            width: 12,
          )
        ],
      ),
      body: Padding(
          padding: const EdgeInsets.fromLTRB(5, 5, 0, 5),
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
                              padding: const EdgeInsets.fromLTRB(0, 0, 0, 15),
                              child: Container(
                                width: 330,
                                height: 45,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.black,
                                      width: 0.5,
                                      style: BorderStyle.solid),
                                  borderRadius: BorderRadius.circular(8),
                                  color: Colors.white,
                                ),
                                child: Row(
                                  children: [
                                    Text("  "),
                                    Icon(Icons.search),
                                    Text(
                                      "search anything",
                                      style: TextStyle(color: Colors.grey),
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
                              dealOfTheDayText: "categories",
                              viewAllText: "view all",
                            ),
                          ),
                          // SizedBox(height: 15.h),
                          _buildCategoryList(context),
                          SizedBox(height: 20.h),
                          _buildPromotionBanner(context),
                          SizedBox(height: 8.h),
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
                              dealOfTheDayText: "deal of the day",
                              viewAllText: "view all",
                            ),
                          ),
                          _buildDealOfTheDayRow(context),
                          SizedBox(height: 26.h),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10.h),
                            child: _buildDealOfTheDay(
                              context,
                              dealOfTheDayText: "msg_hot_selling_footwear",
                              viewAllText: "lbl_view_all",
                            ),
                          ),
                          SizedBox(height: 16.h),
                          _buildProductSmallList(context),
                          SizedBox(height: 25.h),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10.h),
                            child: _buildDealOfTheDay(
                              context,
                              dealOfTheDayText: "msg_recommended_for",
                              viewAllText: "lbl_view_all",
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
            return Center(
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
                child: Text("NO data"),
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
            return Center(
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
              return Center(
                child: Text("No data here"),
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
  Widget _buildProductSmallList(BuildContext context) {
    return SizedBox(
      height: 230.h,
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
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
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
  Widget _buildDealOfTheDay(
    BuildContext context, {
    required String dealOfTheDayText,
    required String viewAllText,
  }) {
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
}
