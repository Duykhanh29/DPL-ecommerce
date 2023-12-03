import 'package:dpl_ecommerce/const/app_theme.dart';
import 'package:dpl_ecommerce/customs/custom_text_style.dart';
import 'package:dpl_ecommerce/models/product.dart';
import 'package:dpl_ecommerce/repositories/product_repo.dart';
import 'package:dpl_ecommerce/views/consumer/ui_elements/product_small_list_item1_widget.dart';
import 'package:dpl_ecommerce/views/consumer/ui_elements/product_small_list_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FavoriteScreen extends StatefulWidget {
  @override
  _RatingState createState() => _RatingState();
}

class _RatingState extends State<FavoriteScreen> {
  double rating = 3.0;
 List<Product>? listProduct = ProductRepo().list;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(
          "Favorite Product",
          textAlign: TextAlign.center,
        ),
        centerTitle: true,

        //leading: Icon(Icons.menu),
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
                  padding: EdgeInsets.only(bottom: 5.h, left: 10.w),
                  child: Column(
                    children: [
                      //SizedBox(height: 5.h),
                      // Padding(
                      //   padding: EdgeInsets.symmetric(horizontal: 10.h),
                      //   child: _buildDealOfTheDay(
                      //     context,
                      //     dealOfTheDayText: "",
                      //     viewAllText: "",
                      //   ),
                      // ),
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

