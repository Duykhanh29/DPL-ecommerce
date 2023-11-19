import 'package:carousel_slider/carousel_slider.dart';
import 'package:dpl_ecommerce/const/app_decoration.dart';
import 'package:dpl_ecommerce/const/app_theme.dart';
import 'package:dpl_ecommerce/customs/custom_badge_cart.dart';
import 'package:dpl_ecommerce/customs/custom_search_view.dart';
import 'package:dpl_ecommerce/customs/custom_text_style.dart';
import 'package:dpl_ecommerce/models/category.dart';
import 'package:dpl_ecommerce/models/product.dart';
import 'package:dpl_ecommerce/repositories/category_repo.dart';
import 'package:dpl_ecommerce/repositories/flash_sale_repo.dart';
import 'package:dpl_ecommerce/repositories/product_repo.dart';
import 'package:dpl_ecommerce/utils/constants/size_utils.dart';
import 'package:dpl_ecommerce/view_model/consumer/cart_view_model.dart';
import 'package:dpl_ecommerce/view_model/consumer/chat_view_model.dart';
import 'package:dpl_ecommerce/views/consumer/screens/chat_page.dart';
import 'package:dpl_ecommerce/views/consumer/screens/search_page.dart';
import 'package:dpl_ecommerce/views/consumer/ui_elements/product_item_widget1.dart';
import 'package:dpl_ecommerce/views/consumer/ui_elements/product_small_list_item1_widget.dart';
import 'package:dpl_ecommerce/views/consumer/ui_elements/product_small_list_item_widget.dart';
import 'package:dpl_ecommerce/views/consumer/ui_elements/promotion_banner_item_widget.dart';
import 'package:dpl_ecommerce/views/consumer/ui_elements/category_item_widget.dart';
import 'package:dpl_ecommerce/views/consumer/ui_elements/two_slider_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:section_view/section_view.dart';
import 'package:dpl_ecommerce/models/flash_sale.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});
  TextEditingController searchController = TextEditingController();
  int sliderIndex = 1;
  List<FlashSale>? listFlashSale = FlashSaleRepo().list;
  List<Product>? listProduct = ProductRepo().list;
  List<Category>? listCategory = CategoryRepo().list;
  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartViewModel>(context);
    final chatProvider = Provider.of<ChatViewModel>(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text("Home"),
        actions: [
          Consumer<CartViewModel>(builder: (context, value, child) {
            return CustomBadgeCart(number: value.cart.productInCarts!.length);
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
                    color: Colors.redAccent, size: 24),
                onTap: () {},
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
                      color: Colors.redAccent,
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
                          _buildCategoryList(context, listCategory!),
                          SizedBox(height: 20.h),
                          _buildPromotionBanner(context, listFlashSale!),
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
                          _buildDealOfTheDayRow(context, listProduct!),
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
                          _buildProductSmallList(context, listProduct!),
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
                          _buildProductSmallList1(context, listProduct!),
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
  Widget _buildPromotionBanner(BuildContext context, List<FlashSale> list) {
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
        itemCount: list.length,
        itemBuilder: (context, index, realIndex) {
          return PromotionbannerItemWidget(
            flashSale: list[index],
          );
        },
      ),
    );
  }

  /// Section Widget
  Widget _buildCategoryList(BuildContext context, List<Category> list) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.12,
      child: ListView.separated(
        padding: EdgeInsets.only(left: 10.h),
        scrollDirection: Axis.horizontal,
        separatorBuilder: (context, index) {
          return SizedBox(
            width: 18.h,
          );
        },
        itemCount: list.length,
        itemBuilder: (context, index) {
          return CategoryItemWidget(
            category: list[index],
          );
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

  Widget _buildDealOfTheDayRow(BuildContext context, List<Product> list) {
    return SizedBox(
      height: 220.h,
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

  /// Section Widget
  Widget _buildProductSmallList(BuildContext context, List<Product> list) {
    return SizedBox(
      height: 230.h,
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
          return ProductsmalllistItemWidget(
            product: list[index],
          );
        },
      ),
    );
  }

  /// Section Widget
  Widget _buildProductSmallList1(BuildContext context, List<Product> list) {
    return Padding(
      padding: EdgeInsets.only(right: 10.h),
      child: GridView.builder(
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
        itemCount: list.length,
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
