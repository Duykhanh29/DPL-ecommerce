import 'package:dpl_ecommerce/const/app_theme.dart';
import 'package:dpl_ecommerce/customs/custom_text_style.dart';
import 'package:dpl_ecommerce/utils/constants/size_utils.dart';
import 'package:dpl_ecommerce/views/consumer/screens/category_search.dart';
import 'package:dpl_ecommerce/views/consumer/screens/filter_page.dart';
import 'package:dpl_ecommerce/views/consumer/ui_elements/product_small_list_item1_widget.dart';
import 'package:flutter/material.dart';

class SearchFilterInterface extends StatefulWidget {
  @override
  _SearchFilterInterfaceState createState() => _SearchFilterInterfaceState();
}

class _SearchFilterInterfaceState extends State<SearchFilterInterface> {
  String _searchText = '';
  String _filterText = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            //Icon(Icons.search),
            //SizedBox(width: 8.0),
            Expanded(
              child: TextField(
                onChanged: (value) {
                  setState(() {
                    _searchText = value;
                  });
                },
                decoration: InputDecoration(
                  hintText: "TMA2 Wireless",
                  hintStyle: TextStyle(color: Colors.white),
                ),
              ),
            ),
            SizedBox(width: 8.0),

            IconButton(
              icon: Icon(Icons.clear),
              onPressed: () {
                setState(() {
                  _searchText = '';
                  _filterText = '';
                });
              },
            ),
            IconButton(
              icon: Icon(Icons.list),
              onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CategoryInterface(),
                    ),
                  ),
              
            ),
            IconButton(
              icon: Icon(Icons.filter_list),
              onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FilterInterface(),
                    ),
                  ),
            ),
          ],
        ),
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
                  padding: EdgeInsets.only(bottom: 5.v, left: 10.v),
                  child: Column(
                    children: [
                      //SizedBox(height: 5.v),
                      Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10.h),
                            child: _buildDealOfTheDay(
                              context,
                              dealOfTheDayText: "result",
                              viewAllText: "lbl_view_all",
                            ),
                          ),
                          //SizedBox(height: 16.v),
                          _buildProductSmallList1(context),
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
