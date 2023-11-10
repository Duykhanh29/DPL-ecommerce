import 'package:dpl_ecommerce/const/app_theme.dart';
import 'package:dpl_ecommerce/customs/custom_text_style.dart';
import 'package:dpl_ecommerce/models/product.dart';
import 'package:dpl_ecommerce/repositories/product_repo.dart';
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
  Product? product = Product(
    availableQuantity: 100,
    categoryID: "cacd",
    colors: ["Red", "Yellow"],
    createdAt: DateTime(2023, 11, 4),
    description: "This is a clothe",
    id: "ProductID01",
    images: [
      "https://t3.ftcdn.net/jpg/06/49/51/82/360_F_649518247_J27irz9TezhqqHS6EpF0AQY7bFdVAIn8.jpg",
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
    updatedAt: DateTime.now(),
  );
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
                style: TextStyle(color: Colors.white),
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
                      _buildProductSmallList1(context, product),
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

Widget _buildProductSmallList1(BuildContext context, Product? product) {
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
        return Productsmalllist1ItemWidget(
          product: product,
        );
      },
      physics: NeverScrollableScrollPhysics(),
      itemCount: 10,
    ),
  );
}
