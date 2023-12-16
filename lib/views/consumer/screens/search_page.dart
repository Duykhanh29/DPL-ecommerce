import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dpl_ecommerce/const/app_decoration.dart';
import 'package:dpl_ecommerce/const/app_theme.dart';
import 'package:dpl_ecommerce/customs/custom_image_view.dart';
import 'package:dpl_ecommerce/customs/custom_search_view.dart';
import 'package:dpl_ecommerce/customs/custom_text_style.dart';
import 'package:dpl_ecommerce/models/product.dart';
import 'package:dpl_ecommerce/models/search_history.dart';
import 'package:dpl_ecommerce/repositories/product_repo.dart';
import 'package:dpl_ecommerce/repositories/search_history_repo.dart';
import 'package:dpl_ecommerce/utils/constants/image_data.dart';
import 'package:dpl_ecommerce/utils/lang/lang_text.dart';
import 'package:dpl_ecommerce/view_model/user_view_model.dart';
import 'package:dpl_ecommerce/views/consumer/screens/search_result_page.dart';
import 'package:flutter/material.dart';
import 'package:dpl_ecommerce/views/consumer/ui_elements/product_small_list_item1_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:dpl_ecommerce/models/search_history.dart';

class SearchScreen extends StatefulWidget {
  SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController searchController = TextEditingController();

  ProductRepo productRepo = ProductRepo();
  SearchHistoryRepo searchHistoryRepo = SearchHistoryRepo();
  int sliderIndex = 1;

  Product? product = Product(
    availableQuantity: 100,
    categoryID: "cacd",
    colors: ["Red", "Yellow"],
    createdAt: Timestamp.fromDate(DateTime(2023, 11, 4)),
    description: "This is a clothe",
    id: "ProductID01",
    images: [
      // "https://t3.ftcdn.net/jpg/06/49/51/82/360_F_649518247_J27irz9TezhqqHS6EpF0AQY7bFdVAIn8.jpg",
      "https://images.unsplash.com/photo-1541963463532-d68292c34b19?auto=format&fit=crop&q=80&w=1000&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxleHBsb3JlLWZlZWR8M3x8fGVufDB8fHx8fA%3D%3D",
      "https://images.unsplash.com/photo-1575936123452-b67c3203c357?auto=format&fit=crop&q=80&w=1000&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8aW1hZ2V8ZW58MHx8MHx8fDA%3D",
      "https://images.pexels.com/photos/11061877/pexels-photo-11061877.jpeg?cs=srgb&dl=pexels-bailey-dill-11061877.jpg&fm=jpg"
    ],
    name: "Cloth",
    price: 12345,
    purchasingCount: 123,
    rating: 4.3,
    ratingCount: 100,
    reviewIDs: [
      "Fdsafs",
      "fdasfd",
      "fdasdf",
    ],
    shopID: "fdfas",
    shopLogo: "fdafdfd",
    shopName: "fdfds",
    updatedAt: Timestamp.fromDate(DateTime.now()),
  );
  bool isLoading = true;
  List<SeacrhHistory>? listSearchHistory;
  List<String>? listSearchHistoryKey;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: Text(
            "search_anything",
            // LangText(context: context).getLocal()!.search_anything,
            textAlign: TextAlign.center,
          ),

          //leading: Icon(Icons.menu),
        ),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(5, 5, 0, 5),
          child: SizedBox(
              width: double.maxFinite,
              child: ListView(children: [
                SizedBox(height: 25.h),
                Padding(
                  padding: EdgeInsets.only(left: 24.h, right: 25.h),
                  child: CustomSearchView(
                    suffix: searchController.text != "" &&
                            searchController.text != null
                        ? InkWell(
                            onTap: () {
                              setState(() {
                                searchController.text = "";
                              });
                            },
                            child: const Icon(Icons.close),
                          )
                        : null,
                    textInputAction: TextInputAction.search,
                    onChanged: (p0) {
                      // await productRepo.searchProductByName(p0);
                    },
                    onFieldSubmitted: (p0) async {
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
                    },
                    controller: searchController,
                    hintText: "Search Product Name",
                    prefix: Padding(
                        padding: EdgeInsets.all(7.h),
                        child: Icon(
                          Icons.search,
                          size: 25.h,
                        )),
                  ),
                ),
                SizedBox(height: 20.h),
                !isLoading && listSearchHistory != null
                    ? Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                            padding: EdgeInsets.only(left: 20.w),
                            child: Text("Recent searches",
                                style: theme.textTheme.titleSmall)))
                    : Container(),
                SizedBox(height: 20.h),
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
                          dealOfTheDayText: "recommend",
                          viewAllText: "view all",
                        ),
                      ),
                      SizedBox(height: 16.h),
                      _buildProductSmallList1(context, product!),
                    ],
                  ),
                ),
              ])),
        ),
      ),
    );
  }

  Widget _buildLastSearchItem(BuildContext context,
      {required SeacrhHistory seacrhHistory, Key? key}) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                SearchFilterScreen(searchKey: seacrhHistory.searchKey),
          ),
        );
      },
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5.w),
        child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
          // CustomImageView(
          //     imagePath: ImageData.imgIconClock, height: 20.h, width: 20.w),
          Padding(
              padding: EdgeInsets.only(left: 10.h),
              child: Text(seacrhHistory.searchKey!,
                  style: TextStyle(color: Colors.red))),
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

  Widget _buildProductSmallList1(BuildContext context, Product product) {
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
            product: product,
          );
        },
        physics: NeverScrollableScrollPhysics(),
        itemCount: 10,
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
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.2,
      ),
      padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 20.w),
      child: ListView.builder(
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
