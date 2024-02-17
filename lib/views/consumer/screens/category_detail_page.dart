// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dpl_ecommerce/customs/custom_app_bar.dart';
import 'package:dpl_ecommerce/customs/custom_array_back_widget.dart';
import 'package:dpl_ecommerce/helpers/shimmer_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:dpl_ecommerce/const/app_theme.dart';
import 'package:dpl_ecommerce/customs/custom_text_style.dart';
import 'package:dpl_ecommerce/models/product.dart';
import 'package:dpl_ecommerce/repositories/product_repo.dart';
import 'package:dpl_ecommerce/utils/lang/lang_text.dart';
import 'package:dpl_ecommerce/views/consumer/ui_elements/product_small_list_item1_widget.dart';
import 'package:dpl_ecommerce/views/consumer/ui_elements/product_small_list_item_widget.dart';

class CategoryDetail extends StatefulWidget {
  String? shopID;
  String categoryID;
  CategoryDetail({
    Key? key,
    this.shopID,
    required this.categoryID,
  }) : super(key: key);
  @override
  _RatingState createState() => _RatingState();
}

class _RatingState extends State<CategoryDetail> {
  List<Product>? listProduct;
  ProductRepo productRepo = ProductRepo();
  bool isLoading = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchData();
  }

  Future<void> onRefresh() async {
    await reset();
    await fetchData();
  }

  Future<void> reset() async {
    listProduct = [];
    isLoading = true;
    setState(() {});
  }

  Future<void> fetchData() async {
    if (widget.shopID != null) {
      listProduct = await productRepo.getListProductByCategoryInShop(
          categoryID: widget.categoryID, shopID: widget.shopID!);
    } else {
      listProduct =
          await productRepo.getListProductByCategory(widget.categoryID);
    }
    isLoading = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        centerTitle: true,
        context: context,
        title: LangText(context: context).getLocal()!.product_category,
      ).show(),
      body: RefreshIndicator(
        onRefresh: () async {
          await onRefresh();
        },
        child: Padding(
          padding: EdgeInsets.fromLTRB(5.w, 5.h, 0, 5.h),
          child: Container(
            width: double.maxFinite,
            child: isLoading
                ? ShimmerHelper().buildProductGridShimmer()
                : Column(
                    children: [
                      Expanded(
                          child: SingleChildScrollView(
                        child: Padding(
                          padding: EdgeInsets.only(bottom: 5.h, left: 10.w),
                          child: Column(
                            children: [
                              SizedBox(height: 16.h),
                              _buildProductSmallList1(context, listProduct!),
                            ],
                          ),
                        ),
                      ))
                    ],
                  ),
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
//  Widget _buildProductSmallList(BuildContext context, List<Product> list) {
//     return Padding(
//       padding: EdgeInsets.only(right: 10.h),

//       child: GridView.builder(
//         padding: EdgeInsets.only(left: 16.h),
//         scrollDirection: Axis.horizontal,
//         shrinkWrap: true,
//         gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//           crossAxisCount: 2,
//           crossAxisSpacing: 10,
//           mainAxisSpacing: 10,
//           mainAxisExtent: 283.h,
//           // childAspectRatio: 3 / 2,
//         ),
//         itemCount: list.length,
//         itemBuilder: (context, index) {
//           return ProductsmalllistItemWidget(
//             product: list[index],
//           );
//         },
//       ),
//     );
//   }
Widget _buildProductSmallList1(BuildContext context, List<Product> list) {
  return Padding(
    padding: EdgeInsets.only(right: 10.h),
    child: list.isNotEmpty
        ? GridView.builder(
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
            physics: const NeverScrollableScrollPhysics(),
            itemCount: list.length,
          )
        : SizedBox(
            height: MediaQuery.of(context).size.height * 0.7,
            child: Center(
              child: Text(
                  LangText(context: context).getLocal()!.no_data_is_available),
            ),
          ),
  );
}
