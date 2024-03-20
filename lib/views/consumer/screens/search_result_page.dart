// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dpl_ecommerce/customs/custom_array_back_widget.dart';
import 'package:dpl_ecommerce/customs/custom_search_view.dart';
import 'package:dpl_ecommerce/utils/constants/image_data.dart';
import 'package:dpl_ecommerce/utils/lang/lang_text.dart';
import 'package:dpl_ecommerce/view_model/user_view_model.dart';
import 'package:dpl_ecommerce/views/consumer/routes/routes.dart';
import 'package:dpl_ecommerce/views/consumer/screens/search_page.dart';
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

class SearchFilterScreen extends StatefulWidget {
  String? searchKey;
  List<Product>? list;
  double? rating;
  int? minPrice;
  int? maxPrice;
  DateTime? date;
  SearchFilterScreen({
    this.minPrice,
    this.maxPrice,
    this.rating,
    this.date,
    Key? key,
    this.searchKey,
    this.list,
  }) : super(key: key);
  @override
  _SearchFilterScreenState createState() => _SearchFilterScreenState();
}

class _SearchFilterScreenState extends State<SearchFilterScreen> {
  ProductRepo productRepo = ProductRepo();
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
  TextEditingController searchController = TextEditingController();
  SearchHistoryRepo searchHistoryRepo = SearchHistoryRepo();
  FocusNode focusNode = FocusNode();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    searchController.text = widget.searchKey ?? "";
    focusNode.unfocus();
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
                focusNode: focusNode,
                onChanged: (p0) {
                  setState(() {
                    focusNode.requestFocus();
                  });
                },
                autofocus: false,
                controller: searchController,
                textInputAction: TextInputAction.search,
                // onChanged: (p0) async {
                //   await productRepo.searchProductByName(p0);
                // },
                onFieldSubmitted: (p0) async {
                  final list = await productRepo.searchProductByName(p0);
                  await searchHistoryRepo.insertSearchKey(
                      uid: user!.id!, searchKey: p0);
                  // ignore: use_build_context_synchronously

                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SearchFilterScreen(
                          list: list, searchKey: searchController.text),
                    ),
                  );
                },
                suffix:
                    searchController.text != "" && searchController.text != null
                        ? Padding(
                            padding: EdgeInsets.only(right: 4.w),
                            child: InkWell(
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
            IconButton(
              icon: Icon(Icons.list, size: 20.h, color: MyTheme.green_light),
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CategoryInterface(
                    name: widget.searchKey!,
                  ),
                ),
              ),
            ),
            IconButton(
              icon: Icon(Icons.filter_list,
                  size: 20.h, color: MyTheme.green_light),
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FilterPage(
                    searhKey: searchController.text,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(5.w, 5.h, 0, 5.h),
        child: GestureDetector(
          onTap: () {
            if (focusNode.hasFocus) {
              setState(() {
                focusNode.unfocus();
              });
            }
          },
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
                              _buildProductSmallList1(context, widget.list!),
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
      ),
    );
  }
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

Widget _buildProductSmallList1(BuildContext context, List<Product?> products) {
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
          product: products[index],
        );
      },
      physics: const NeverScrollableScrollPhysics(),
      itemCount: products.length,
    ),
  );
}
