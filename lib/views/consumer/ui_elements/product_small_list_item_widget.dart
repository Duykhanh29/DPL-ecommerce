import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dpl_ecommerce/const/app_decoration.dart';
import 'package:dpl_ecommerce/const/app_theme.dart';
import 'package:dpl_ecommerce/customs/custom_icon_button.dart';
import 'package:dpl_ecommerce/customs/custom_image_view.dart';
import 'package:dpl_ecommerce/customs/custom_text_style.dart';
import 'package:dpl_ecommerce/models/favourite_product.dart';
import 'package:dpl_ecommerce/models/product.dart';
import 'package:dpl_ecommerce/repositories/wishlist_repo.dart';
import 'package:dpl_ecommerce/utils/constants/image_data.dart';
import 'package:dpl_ecommerce/utils/constants/size_utils.dart';
import 'package:dpl_ecommerce/views/consumer/screens/product_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../view_model/user_view_model.dart';

// ignore: must_be_immutable
class ProductsmalllistItemWidget extends StatelessWidget {
  ProductsmalllistItemWidget({Key? key, required this.product});
  Product? product;

  WishListRepo wishListRepo = WishListRepo();

  bool? isFavourite = false;

  bool isLoading = true;

  // Future<void> fetchData() async {
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserViewModel>(context);
    final user = userProvider.currentUser;
    return GestureDetector(
      onTap: () {
        print("Product");
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => ProductDetailsPage(id: product!.id!),
        ));
      },
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.r),
            color: MyTheme.background,
            border: Border.all(color: MyTheme.accent_color)),
        width: 170.h,
        child: Padding(
          padding: EdgeInsets.only(bottom: 1.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 2.w),
                child: Container(
                  width: 162.h,
                  height: 130.h,
                  padding: EdgeInsets.all(4.h),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadiusStyle.roundedBorder2,
                    image: DecorationImage(
                      image: NetworkImage(
                        product!.images![0],
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      // Container(
                      //   width: 56.h,
                      //   margin: EdgeInsets.only(bottom: 77.h),
                      //   padding: EdgeInsets.symmetric(
                      //     horizontal: 4.h,
                      //     vertical: 2.h,
                      //   ),
                      //   decoration: AppDecoration.fillOrange.copyWith(
                      //     borderRadius: BorderRadiusStyle.roundedBorder2,
                      //   ),
                      //   child: Text(
                      //     "top_seller",
                      //     style: CustomTextStyles.labelMediumOnPrimaryContainer,
                      //   ),
                      // ),
                      buildFavouriteIcon(context)
                    ],
                  ),
                ),
              ),
              SizedBox(height: 8.h),
              Container(
                padding: EdgeInsets.only(left: 8.w),
                width: 147.h,
                child: Text(
                  product!.name!,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.displayLarge!.copyWith(
                    height: 1.50,
                  ),
                ),
              ),
              SizedBox(height: 10.h),
              Container(
                padding: const EdgeInsets.only(left: 8, right: 8),
                child: Row(
                  children: [
                    //       Container(
                    //         height: 16.h,
                    //         width: 16.h,
                    //         padding: EdgeInsets.all(2.h),
                    //         decoration: AppDecoration.fillAmber.copyWith(
                    //           borderRadius: BorderRadiusStyle.roundedBorder2,
                    //         ),
                    //         child: CustomImageView(
                    //           imagePath: ImageData.imgIconBoldStar,
                    //           height: 12.h,
                    //           width: 12.h,
                    //           alignment: Alignment.center,
                    //         ),
                    //       ),
                    //       Padding(
                    //         padding: EdgeInsets.only(left: 4.h),
                    //         child: Text(
                    //           "lbl_4_8",
                    //           style: theme.textTheme.bodySmall,
                    //         ),
                    //       ),
                    //       Padding(
                    //         padding: EdgeInsets.only(left: 4.h),
                    //         child: Text(
                    //           "lbl_692",
                    //           style: CustomTextStyles.bodySmallGray600,
                    //         ),
                    //       ),
                  ],
                ),
              ),
              SizedBox(height: 9.h),
              Container(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text(
                    "${product!.price} VND",
                    style: theme.textTheme.displayLarge,
                  )),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildFavouriteIcon(BuildContext context) {
    final userProvider = Provider.of<UserViewModel>(context);
    final user = userProvider.currentUser;
    return StreamBuilder(
      stream: wishListRepo.isFavouriteProduct(
          uid: user!.id!, productID: product!.id!),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Icon(Icons.favorite_border);
        } else {
          if (snapshot.data != null) {
            final isFavourite = snapshot.data;
            return Padding(
                padding: EdgeInsets.only(
                  left: 60.h,
                  bottom: 72.h,
                ),
                child: InkWell(
                    onTap: () async {
                      if (isFavourite!) {
                        await wishListRepo.deleteFavouriteByParams(
                            uid: user!.id!, productID: product!.id!);
                      } else {
                        FavouriteProduct favouriteProduct = FavouriteProduct(
                            createdAt: Timestamp.now(),
                            productID: product!.id,
                            userID: user!.id!);
                        await wishListRepo.addToFavourite(favouriteProduct);
                      }
                    },
                    child: Icon(
                      isFavourite!
                          ? Icons.favorite
                          : Icons.favorite_border_rounded,
                      color: MyTheme.red,
                    )));
          } else {
            return Icon(Icons.favorite_border, color: MyTheme.red);
          }
        }
      },
    );
  }
}
