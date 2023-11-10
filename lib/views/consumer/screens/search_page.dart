import 'package:dpl_ecommerce/const/app_decoration.dart';
import 'package:dpl_ecommerce/const/app_theme.dart';
import 'package:dpl_ecommerce/customs/custom_image_view.dart';
import 'package:dpl_ecommerce/customs/custom_search_view.dart';
import 'package:dpl_ecommerce/customs/custom_text_style.dart';
import 'package:dpl_ecommerce/utils/constants/size_utils.dart';
import 'package:dpl_ecommerce/views/consumer/screens/search_result_page.dart';
import 'package:flutter/material.dart';
import 'package:dpl_ecommerce/views/consumer/ui_elements/product_small_list_item1_widget.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({Key? key}) : super(key: key);
  TextEditingController searchController = TextEditingController();
  int sliderIndex = 1;

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: Text(
            "Search",
            textAlign: TextAlign.center,
          ),
          centerTitle: true,

          //leading: Icon(Icons.menu),
        ),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(5, 5, 0, 5),
          child: SizedBox(
              width: double.maxFinite,
              child: ListView(children: [
                SizedBox(height: 25.v),
                Padding(
                  padding: EdgeInsets.only(left: 24.h, right: 25.h),
                  child: CustomSearchView(
                      controller: searchController,
                      hintText: "Search Product Name"),
                ),
                SizedBox(height: 20.v),
                Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                        padding: EdgeInsets.only(left: 24.h),
                        child: Text("Recent searches",
                            style: theme.textTheme.titleSmall))),
                SizedBox(height: 20.v),
                GestureDetector(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SearchFilterInterface(),
                    ),
                  ),
                  child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24.h),
                      child: _buildLastSearchItem(
                        context,
                        userLabel: "TMA2 Wireless",
                      )),
                ),
                SizedBox(height: 25.v),
                Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24.h),
                    child: _buildLastSearchItem(
                      context,
                      userLabel: "TMA2 Wireless",
                    )),
                SizedBox(height: 25.v),
                Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24.h),
                    child: _buildLastSearchItem(
                      context,
                      userLabel: "TMA2 Wireless",
                    )),
                SizedBox(height: 25.v),
                Padding(
                  padding: EdgeInsets.only(bottom: 5.v, left: 10.v),
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.h),
                        child: _buildDealOfTheDay(
                          context,
                          dealOfTheDayText: "msg_recommended_for",
                          viewAllText: "lbl_view_all",
                        ),
                      ),
                      SizedBox(height: 16.v),
                      _buildProductSmallList1(context),
                    ],
                  ),
                ),
              ])),
        ),
      ),
    );
  }
}

Widget _buildLastSearchItem(
  BuildContext context, {
  required String userLabel,
}) {
  return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
    CustomImageView(
        imagePath: ImageConstant.imgIconClock,
        height: 20.adaptSize,
        width: 20.adaptSize),
    Padding(
        padding: EdgeInsets.only(left: 10.h),
        child: Text(userLabel,
            style: theme.textTheme.bodyMedium!.copyWith(
                color: theme.colorScheme.primaryContainer.withOpacity(1)))),
    Spacer(),
    CustomImageView(
        imagePath: ImageConstant.imgClose,
        height: 20.adaptSize,
        width: 20.adaptSize)
  ]);
}

class ImageConstant {
  // Image folder path
  static String imagePath = 'assets/images';

  static String imgIconClock = '$imagePath/img_icon_clock1.jpg';

  static String imgClose = '$imagePath/img_close.svg';
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

Widget _buildProductSmallList1(BuildContext context) {
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
        return Productsmalllist1ItemWidget();
      },
      physics: NeverScrollableScrollPhysics(),
      itemCount: 10,
    ),
  );
}


  /// Section Widget
 