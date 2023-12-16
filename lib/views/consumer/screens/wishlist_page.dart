import 'package:dpl_ecommerce/models/favourite_product.dart';
import 'package:dpl_ecommerce/repositories/wishlist_repo.dart';
import 'package:dpl_ecommerce/views/consumer/ui_elements/wishlist_widgets/favourite_product_item_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WishlistPage extends StatelessWidget {
  WishlistPage({super.key, required this.uid});
  String uid;
  WishListRepo wishListRepo = WishListRepo();

  List<FavouriteProduct>? list;

  bool isLoading = true;

  // Future<void> fetchData() async {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Wishlish"),
      ),
      body: Padding(
        padding: EdgeInsets.all(10.h),
        child: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height * 0.8,
            child: StreamBuilder(
              stream: wishListRepo.getAllFavouriteProduct(uid),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  if (snapshot.data != null) {
                    final listFavourite = snapshot.data;
                    return GridView.builder(
                      itemCount: listFavourite!.length,
                      shrinkWrap: true,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        mainAxisExtent: 283.h,
                        // childAspectRatio: 3 / 2,
                      ),
                      itemBuilder: (context, index) {
                        return FavouriteProductItemWidget(
                          key: UniqueKey(),
                          favouriteProduct: listFavourite[index],
                        );
                      },
                    );
                  } else {
                    return Center(
                      child: Text("No data"),
                    );
                  }
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
