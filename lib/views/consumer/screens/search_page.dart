import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dpl_ecommerce/const/app_decoration.dart';
import 'package:dpl_ecommerce/const/app_theme.dart';
import 'package:dpl_ecommerce/customs/custom_app_bar.dart';
import 'package:dpl_ecommerce/customs/custom_image_view.dart';
import 'package:dpl_ecommerce/customs/custom_search_view.dart';
import 'package:dpl_ecommerce/customs/custom_text_style.dart';
import 'package:dpl_ecommerce/helpers/which_filter_helper.dart';
import 'package:dpl_ecommerce/models/product.dart';
import 'package:dpl_ecommerce/models/recommeded_product.dart';
import 'package:dpl_ecommerce/models/search_history.dart';
import 'package:dpl_ecommerce/models/user.dart';
import 'package:dpl_ecommerce/repositories/product_repo.dart';
import 'package:dpl_ecommerce/repositories/recommed_product_repo.dart';
import 'package:dpl_ecommerce/repositories/search_history_repo.dart';
import 'package:dpl_ecommerce/repositories/shop_repo.dart';
import 'package:dpl_ecommerce/utils/constants/image_data.dart';
import 'package:dpl_ecommerce/utils/lang/lang_text.dart';
import 'package:dpl_ecommerce/view_model/user_view_model.dart';
import 'package:dpl_ecommerce/views/consumer/screens/search_result_page.dart';
import 'package:dpl_ecommerce/views/consumer/screens/search_shop_result_page.dart';
import 'package:flutter/material.dart';
import 'package:dpl_ecommerce/views/consumer/ui_elements/product_small_list_item1_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:dpl_ecommerce/models/search_history.dart';
import 'package:dpl_ecommerce/customs/custom_array_back_widget.dart';

enum WhichFilter { product, shop }

class SearchScreen extends StatefulWidget {
  SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  WhichFilter? whichFilter;
  TextEditingController searchController = TextEditingController();

  ProductRepo productRepo = ProductRepo();
  ShopRepo shopRepo = ShopRepo();
  SearchHistoryRepo searchHistoryRepo = SearchHistoryRepo();
  RecommededProductRepo recommededProductRepo = RecommededProductRepo();
  int sliderIndex = 1;

  bool isLoading = true;
  List<SeacrhHistory>? listSearchHistory;
  List<String>? listSearchHistoryKey;
  List<String>? listCategoryID;
  List<Product>? listRecommededProduct;
  List<RecommendedProducts>? listRecommed;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    whichFilter = WhichFilter.product;
    fetchData();
  }

  Future<void> refreshData() async {
    resetData();
    fetchData();
  }

  void resetData() {
    setState(() {
      listSearchHistory = null;
      listSearchHistoryKey = null;
      isLoading = true;
    });
  }

  Future<void> fetchData() async {
    listSearchHistory = await searchHistoryRepo.getListSearchHistory();
    listSearchHistoryKey = await searchHistoryRepo
        .convertSeacrhListToListString(listSearchHistory);
    listRecommed = await recommededProductRepo.fetchRecentData();
    if (listRecommed != null) {
      listCategoryID =
          await recommededProductRepo.getListCategoryID(listRecommed!);
      if (listCategoryID != null && listCategoryID!.isNotEmpty) {
        for (var element in listCategoryID!) {
          final listProduct =
              await productRepo.getListProductByCategory(element);
          if (listProduct != null && listProduct.isNotEmpty) {
            if (listRecommededProduct != null &&
                listRecommededProduct!.length == 10) {
            } else {
              if (listRecommededProduct != null) {
                listRecommededProduct!.addAll(listProduct);
              } else {
                listRecommededProduct = listProduct;
              }
            }
          }
        }
      } else {
        listRecommededProduct = await productRepo.getActiveProducts(limit: 10);
      }
    } else {
      listRecommededProduct = await productRepo.getActiveProducts(limit: 10);
    }
    Future.delayed(const Duration(seconds: 2)).then((value) {
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserViewModel>(context);
    final user = userProvider.currentUser;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: buildAppBar(context, user!),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
        child: SizedBox(
          width: double.maxFinite,
          child: ListView(
            children: [
              // SizedBox(height: 25.h),

              SizedBox(height: 20.h),
              !isLoading && listSearchHistory != null
                  ? Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                          padding: EdgeInsets.only(left: 20.w),
                          child: Text(
                              LangText(context: context)
                                  .getLocal()!
                                  .recent_search,
                              style: theme.textTheme.titleSmall)))
                  : Container(),
              SizedBox(height: 15.h),
              searchController.text.isEmpty
                  ? (isLoading
                      ? Container()
                      : listSearchHistory != null
                          ? _buildHistorySearch(context, listSearchHistory!)
                          : Container())
                  : _buildSearch(context),
              SizedBox(height: 25.h),
              Padding(
                padding: EdgeInsets.only(bottom: 5.h, left: 20.w),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 0.w),
                      child: _buildDealOfTheDay(
                        context,
                        dealOfTheDayText: LangText(context: context)
                            .getLocal()!
                            .recommended_ucf,
                        viewAllText: "",
                      ),
                    ),
                    SizedBox(height: 16.h),
                    isLoading
                        ? const SizedBox()
                        : listRecommededProduct != null
                            ? _buildProductSmallList1(context)
                            : const SizedBox(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  PreferredSize buildAppBar(BuildContext context, UserModel user) {
    return PreferredSize(
      preferredSize: Size.fromHeight(130.h),
      child: AppBar(
          backgroundColor: MyTheme.accent_color_3,
          leading: Container(
            padding: EdgeInsets.only(top: 15.h),
            width: 40,
            height: 40,
            child: InkWell(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Icon(
                Icons.arrow_back_ios,
                color: MyTheme.white,
              ),
            ),
          ),
          elevation: 3,
          centerTitle: false,
          flexibleSpace: Column(children: [
            buildTopAppbar(context, user),
            buildBottomAppBar(context)
          ])),
    );
  }

  Widget buildTopAppbar(BuildContext context, UserModel user) {
    return Padding(
      padding: EdgeInsets.only(left: 45.w, right: 25.w, top: 50.h),
      child: CustomSearchView(
        suffix: searchController.text != "" && searchController.text != null
            ? Padding(
                padding: EdgeInsets.only(right: 2.w),
                child: InkWell(
                  onTap: () {
                    setState(() {
                      searchController.text = "";
                    });
                  },
                  child: const Icon(Icons.close),
                ),
              )
            : null,
        textInputAction: TextInputAction.search,
        onChanged: (p0) {
          // await productRepo.searchProductByName(p0);
        },
        onFieldSubmitted: (p0) async {
          if (whichFilter == WhichFilter.product) {
            final list = await productRepo.searchProductByName(p0);
            await searchHistoryRepo.insertSearchKey(
                uid: user!.id!, searchKey: p0);
            // ignore: use_build_context_synchronously
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SearchFilterScreen(
                    list: list, searchKey: searchController.text),
              ),
            );
          } else {
            final listShop = await shopRepo.searchShopByName(p0);
            // ignore: use_build_context_synchronously
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SearchShopResultScreen(
                    list: listShop, searchKey: searchController.text),
              ),
            );
          }
        },
        controller: searchController,
        hintText: LangText(context: context).getLocal()!.search_anything,
        prefix: Padding(
            padding: EdgeInsets.all(7.h),
            child: Icon(
              Icons.search,
              size: 25.h,
            )),
      ),
    );
  }

  Widget buildBottomAppBar(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 15.w,
      ),
      height: 60.h,
      width: MediaQuery.of(context).size.width * 0.9,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            LangText(context: context).getLocal()!.search_ucf,
            style: TextStyle(fontSize: 14.sp),
          ),
          Expanded(
              flex: 2,
              child: DropdownButton<WhichFilter>(
                value: whichFilter,
                isExpanded: true,
                items: buildDropdownWhichFilterItems(context),
                onChanged: (value) {
                  setState(() {
                    if (value! == WhichFilter.product) {
                      whichFilter = WhichFilter.product;
                    } else {
                      whichFilter = WhichFilter.shop;
                    }
                  });
                },
              ))
        ],
      ),
    );
  }

  List<DropdownMenuItem<WhichFilter>> buildDropdownWhichFilterItems(
      BuildContext context) {
    List<DropdownMenuItem<WhichFilter>> items = [];
    List<WhichFilter> list = [WhichFilter.product, WhichFilter.shop];
    for (WhichFilter item in list as Iterable<WhichFilter>) {
      items.add(
        DropdownMenuItem(
          alignment: Alignment.center,
          value: item,
          child: Text(WhichFilterHelper.translateWhichHelper(context, item),
              style: TextStyle(fontSize: 14.sp)),
        ),
      );
    }
    return items;
  }

  Widget _buildLastSearchItem(BuildContext context,
      {required SeacrhHistory seacrhHistory, Key? key}) {
    return GestureDetector(
      onTap: () async {
        final list =
            await productRepo.searchProductByName(seacrhHistory.searchKey!);

        // ignore: use_build_context_synchronously
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SearchFilterScreen(
                list: list, searchKey: seacrhHistory.searchKey),
          ),
        );
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
        child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
          // CustomImageView(
          //     imagePath: ImageData.imgIconClock, height: 20.h, width: 20.w),
          Padding(
              padding: EdgeInsets.only(left: 10.h),
              child: Text(seacrhHistory.searchKey!,
                  style: TextStyle(
                      color: MyTheme.accent_color,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500))),
          Spacer(),
          CustomImageView(
            imagePath: ImageData.imgClose,
            height: 20.h,
            width: 20.h,
            onTap: () async {
              await searchHistoryRepo.deleteByID(seacrhHistory.id!);
              await refreshData();
            },
          )
        ]),
      ),
    );
  }

  Widget _buildLastSearchItemLoading(
    BuildContext context,
  ) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 7.w),
      child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
        CustomImageView(
            imagePath: ImageData.imgIconClock, height: 20.h, width: 20.w),
        Padding(
            padding: EdgeInsets.only(left: 10.h),
            child: Text("",
                style: theme.textTheme.bodyMedium!.copyWith(
                    color: theme.colorScheme.primaryContainer.withOpacity(1)))),
        // Spacer(),
        // CustomImageView(
        //     imagePath: ImageData.imgClose, height: 20.h, width: 20.h)
      ]),
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

  Widget _buildProductSmallList1(BuildContext context) {
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
            product: listRecommededProduct![index],
          );
        },
        physics: const NeverScrollableScrollPhysics(),
        itemCount: listRecommededProduct!.length,
      ),
    );
  }

  // Widget _buildHistorySearchLoading(BuildContext context) {
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     mainAxisAlignment: MainAxisAlignment.start,
  //     children: [
  //       Padding(
  //           padding: EdgeInsets.symmetric(horizontal: 24.h),
  //           child: _buildLastSearchItem(
  //             context,
  //             userLabel: "",
  //           )),
  //       SizedBox(height: 25.h),
  //       Padding(
  //           padding: EdgeInsets.symmetric(horizontal: 24.h),
  //           child: _buildLastSearchItem(
  //             context,
  //             userLabel: "",
  //           )),
  //       SizedBox(height: 25.h),
  //       Padding(
  //           padding: EdgeInsets.symmetric(horizontal: 24.h),
  //           child: _buildLastSearchItem(
  //             context,
  //             userLabel: "",
  //           )),
  //     ],
  //   );
  // }

  Widget _buildHistorySearch(BuildContext context, List<SeacrhHistory>? list) {
    return Container(
      // height: MediaQuery.of(context).size.height * 0.15,
      // constraints: BoxConstraints(
      //   maxHeight: MediaQuery.of(context).size.height * 0.1,
      // ),
      // decoration: BoxDecoration(color: Colors.yellow),
      padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 20.w),
      child: ListView.separated(
        separatorBuilder: (context, index) => Divider(
          color: MyTheme.app_accent_border,
          height: 1,
        ),
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return _buildLastSearchItem(context,
              seacrhHistory: list![index], key: UniqueKey());
        },
        itemCount: list != null
            ? list.length > 5
                ? 5
                : list.length
            : 0,
      ),
    );
  }

  Widget _buildSearch(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(),
        // GestureDetector(
        //   onTap: () => Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //       builder: (context) => SearchFilterScreen(),
        //     ),
        //   ),
        //   child: Padding(
        //       padding: EdgeInsets.symmetric(horizontal: 24.h),
        //       child: _buildLastSearchItem(
        //         context,
        //         userLabel: "TMA2 Wireless",
        //       )),
        // ),
        // SizedBox(height: 25.h),
        // Padding(
        //     padding: EdgeInsets.symmetric(horizontal: 24.h),
        //     child: _buildLastSearchItem(
        //       context,
        //       userLabel: "TMA2 Wireless",
        //     )),
        // SizedBox(height: 25.h),
        // Padding(
        //     padding: EdgeInsets.symmetric(horizontal: 24.h),
        //     child: _buildLastSearchItem(
        //       context,
        //       userLabel: "TMA2 Wireless",
        //     )),
      ],
    );
  }
}
