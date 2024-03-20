// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dpl_ecommerce/customs/custom_array_back_widget.dart';
import 'package:dpl_ecommerce/customs/custom_search_view.dart';
import 'package:dpl_ecommerce/models/shop.dart';
import 'package:dpl_ecommerce/repositories/shop_repo.dart';
import 'package:dpl_ecommerce/utils/constants/image_data.dart';
import 'package:dpl_ecommerce/utils/lang/lang_text.dart';
import 'package:dpl_ecommerce/view_model/user_view_model.dart';
import 'package:dpl_ecommerce/views/consumer/screens/search_page.dart';
import 'package:dpl_ecommerce/views/consumer/screens/shop_profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:dpl_ecommerce/const/app_theme.dart';
import 'package:dpl_ecommerce/customs/custom_text_style.dart';
import 'package:dpl_ecommerce/models/product.dart';
import 'package:dpl_ecommerce/repositories/product_repo.dart';
import 'package:dpl_ecommerce/views/consumer/screens/category_search.dart';
import 'package:dpl_ecommerce/views/consumer/screens/filter_page.dart';
import 'package:dpl_ecommerce/views/consumer/ui_elements/product_small_list_item1_widget.dart';
import 'package:dpl_ecommerce/repositories/search_history_repo.dart';
import 'package:provider/provider.dart';

class SearchShopResultScreen extends StatefulWidget {
  String? searchKey;
  List<Shop>? list;
  double? rating;

  SearchShopResultScreen({
    this.rating,
    Key? key,
    this.searchKey,
    this.list,
  }) : super(key: key);
  @override
  _SearchShopResultScreenState createState() => _SearchShopResultScreenState();
}

class _SearchShopResultScreenState extends State<SearchShopResultScreen> {
  ShopRepo shopRepo = ShopRepo();
  TextEditingController searchController = TextEditingController();
  SearchHistoryRepo searchHistoryRepo = SearchHistoryRepo();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    searchController.text = widget.searchKey ?? "";
  }

  void reset() {
    searchController.clear();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    reset();
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserViewModel>(context);
    final user = userProvider.currentUser;
    return Scaffold(
      appBar: AppBar(
        leading: CustomArrayBackWidget(),
        backgroundColor: MyTheme.accent_color,
        title: Row(
          children: [
            //Icon(Icons.search),
            //SizedBox(width: 8.0),
            Expanded(
              child: CustomSearchView(
                onChanged: (p0) {},
                controller: searchController,
                textInputAction: TextInputAction.search,
                // onChanged: (p0) async {
                //   await productRepo.searchProductByName(p0);
                // },
                onFieldSubmitted: (p0) async {
                  final list = await shopRepo.searchShopByName(p0);
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SearchShopResultScreen(
                          list: list, searchKey: searchController.text),
                    ),
                  );
                },
                suffix:
                    searchController.text != "" && searchController.text != null
                        ? InkWell(
                            onTap: () {
                              setState(() {
                                searchController.text = "";
                                // reset();
                                // Navigator.of(context).pop();
                              });
                            },
                            child: Icon(
                              Icons.close,
                              color: MyTheme.green_light,
                            ),
                          )
                        : null,
                hintText:
                    LangText(context: context).getLocal()!.search_anything,
                prefix: Padding(
                    padding: EdgeInsets.all(7.h),
                    child: Icon(
                      Icons.search,
                      color: MyTheme.green_light,
                      size: 25.h,
                    )),
              ),
            ),
            SizedBox(width: 8.w),

            // IconButton(
            //   icon: Icon(Icons.clear, size: 20.h, color: MyTheme.green_light),
            //   onPressed: () {_
            //     setState(() {
            //       searchController.text = '';
            //     });
            //   },
            // ),
          ],
        ),
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(5.w, 5.h, 0, 5.h),
        child: widget.list != null
            ? Container(
                width: double.maxFinite,
                child: Column(
                  children: [
                    Expanded(
                        child: SingleChildScrollView(
                      child: Padding(
                        padding: EdgeInsets.only(bottom: 5.h, left: 10.w),
                        child: Column(
                          children: [
                            //SizedBox(height: 5.h),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10.h),
                              child: _buildDealOfTheDay(
                                context,
                                dealOfTheDayText: LangText(context: context)
                                    .getLocal()!
                                    .results_ucf,
                                viewAllText: "",
                              ),
                            ),
                            //SizedBox(height: 16.h),
                            _buildListShop(context, widget.list!),
                          ],
                        ),
                      ),
                    ))
                  ],
                ),
              )
            : Center(
                child: Image.asset(ImageData.imageNotFound),
              ),
      ),
    );
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

  Widget _buildListShop(BuildContext context, List<Shop> shops) {
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
          return shopItem(context, index);
        },
        physics: const NeverScrollableScrollPhysics(),
        itemCount: shops.length,
      ),
    );
  }

  Widget shopItem(BuildContext context, int index) {
    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return ShopProfile(shopID: widget.list![index].id!);
        }));
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.r),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(.1),
              blurRadius: 10,
              spreadRadius: 0.0,
              offset: Offset(0.0, 10.0), // shadow direction: bottom right
            )
          ],
        ),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Flexible(
                  flex: 1,
                  child: ClipRRect(
                      borderRadius: BorderRadius.vertical(
                          top: Radius.circular(15.r), bottom: Radius.zero),
                      child: widget.list![index].logo != null
                          ? CachedNetworkImage(
                              imageUrl: widget.list![index].logo!,
                              imageBuilder: (context, imageProvider) {
                                return Container(
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: imageProvider)),
                                );
                              },
                              errorWidget: (context, url, error) => Container(
                                child: Icon(Icons.error),
                              ),
                              placeholder: (context, url) => Container(
                                // height: 60.h,
                                // width: 60.h,
                                child: Image.asset(ImageData.circelAvatar),
                              ),
                            )
                          : Container(
                              // height: 60.h,
                              // width: 60.h,
                              child: Image.asset(ImageData.circelAvatar),
                            ))),
              SizedBox(
                height: 40.h,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.h),
                  child: Text(
                    widget.list![index].name!,
                    textAlign: TextAlign.left,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: TextStyle(
                        color: MyTheme.font_grey,
                        fontSize: 14.sp,
                        height: 1.6,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ]),
      ),
    );
  }
}
