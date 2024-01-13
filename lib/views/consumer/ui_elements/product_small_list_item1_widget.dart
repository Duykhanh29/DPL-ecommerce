import 'package:cached_network_image/cached_network_image.dart';
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
import 'package:dpl_ecommerce/view_model/user_view_model.dart';
import 'package:dpl_ecommerce/views/consumer/screens/product_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class Productsmalllist1ItemWidget extends StatelessWidget {
  Productsmalllist1ItemWidget({Key? key, required this.product})
      : super(
          key: key,
        );
  Product? product;

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserViewModel>(context);
    final user = userProvider.currentUser;
    return GestureDetector(
      onTap: () {
        // go to detail
        print("Product");
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => ProductDetailsPage(id: product!.id!),
        ));
      },
      child: Container(
        // color: Colors.amber,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.r),
            color: MyTheme.background),
        width: 148.w,
        height: MediaQuery.of(context).size.width * 0.45,
        child: Padding(
          padding: EdgeInsets.only(bottom: 1.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildVisualProduct(
                  urlImage: product!.images![0],
                  uid: user!.id!,
                  productID: product!.id!),
              SizedBox(height: 6.h),
              Container(
                padding: EdgeInsets.only(left: 10.w),
                width: 119.h,
                child: Text(
                  product!.name!,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.bodyLarge!.copyWith(
                    height: 1.50,
                  ),
                ),
              ),
              SizedBox(height: 6.h),
              Container(
                padding: EdgeInsets.only(left: 10.w, right: 10.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 16.h,
                          width: 16.h,
                          padding: EdgeInsets.all(2.h),
                          decoration: AppDecoration.fillAmber.copyWith(
                            borderRadius: BorderRadiusStyle.roundedBorder2,
                          ),
                          child: CustomImageView(
                            imagePath: ImageData.imgIconBoldStar,
                            height: 12.h,
                            width: 12.h,
                            alignment: Alignment.center,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 4.h),
                          child: Text(
                            product!.rating != null
                                ? "${product!.rating!}(${product!.ratingCount})"
                                : "0",
                            style: theme.textTheme.bodySmall,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      product!.availableQuantity!.toString(),
                      style: CustomTextStyles.bodySmallGray600,
                    )
                  ],
                ),
              ),
              SizedBox(height: 10.h),
              Container(
                padding: EdgeInsets.only(left: 10.w),
                child: Text(
                  "${product!.price!} VND",
                  style: theme.textTheme.displayLarge,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _buildVisualProduct extends StatelessWidget {
  _buildVisualProduct(
      {super.key,
      required this.urlImage,
      required this.uid,
      required this.productID});
  String? urlImage;
  String uid;
  String productID;
  WishListRepo wishListRepo = WishListRepo();

  // Future<void> fetchData() async {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 180.w,
      height: 165.h,
      padding: EdgeInsets.all(4.h),
      // decoration: BoxDecoration(
      //   borderRadius: BorderRadiusStyle.roundedBorder2,
      //   image: DecorationImage(
      //     image: AssetImage(
      //       ImageData.imgFrame9,
      //     ),
      //     fit: BoxFit.cover,
      //   ),
      // ),
      child: Stack(
        children: [
          Container(
            child: CachedNetworkImage(
              imageUrl: urlImage!,
              imageBuilder: (context, imageProvider) {
                return Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              },
              placeholder: (context, url) => Center(
                  child: SizedBox(
                      width: 30.h,
                      height: 30.h,
                      child: const CircularProgressIndicator())),
              errorWidget: (context, url, error) =>
                  const Center(child: Icon(Icons.error)),
            ),
          ),
          Positioned(
            top: 5,
            right: 5,
            child: buildFavouriteIcon(),
          )
        ],
      ),
    );
  }

  Widget buildFavouriteIcon() {
    return StreamBuilder(
      stream: wishListRepo.isFavouriteProduct(uid: uid, productID: productID),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Icon(
            Icons.favorite_border,
            size: 25.h,
          );
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
                            uid: uid, productID: productID);
                      } else {
                        FavouriteProduct favouriteProduct = FavouriteProduct(
                            createdAt: Timestamp.now(),
                            productID: productID,
                            userID: uid);
                        await wishListRepo.addToFavourite(favouriteProduct);
                      }
                    },
                    child: Icon(
                      isFavourite!
                          ? Icons.favorite
                          : Icons.favorite_border_rounded,
                      color: MyTheme.red,
                      size: 25.h,
                    )));
          } else {
            return Icon(
              Icons.favorite_border,
              size: 25.h,
              color: MyTheme.red,
            );
          }
        }
      },
    );
  }
}
