import 'package:dpl_ecommerce/const/app_decoration.dart';
import 'package:dpl_ecommerce/const/app_theme.dart';
import 'package:dpl_ecommerce/customs/custom_icon_button.dart';
import 'package:dpl_ecommerce/customs/custom_image_view.dart';
import 'package:dpl_ecommerce/customs/custom_text_style.dart';
import 'package:dpl_ecommerce/models/product.dart';
import 'package:dpl_ecommerce/repositories/product_repo.dart';
import 'package:dpl_ecommerce/utils/constants/image_data.dart';
import 'package:dpl_ecommerce/utils/constants/size_utils.dart';
import 'package:dpl_ecommerce/views/consumer/screens/product_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dpl_ecommerce/models/favourite_product.dart';
import 'package:dpl_ecommerce/repositories/wishlist_repo.dart';

// ignore: must_be_immutable
class FavouriteProductItemWidget extends StatefulWidget {
  FavouriteProductItemWidget({Key? key, required this.favouriteProduct})
      : super(
          key: key,
        );
  FavouriteProduct? favouriteProduct;

  @override
  State<FavouriteProductItemWidget> createState() =>
      _FavouriteProductItemWidgetState();
}

class _FavouriteProductItemWidgetState
    extends State<FavouriteProductItemWidget> {
  ProductRepo productRepo = ProductRepo();

  WishListRepo wishListRepo = WishListRepo();

  Product? currentProduct;
  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    // listProduct = await productRepo.getActiveProducts();
    currentProduct =
        await productRepo.getProductByID(widget.favouriteProduct!.productID!);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return
        //  FutureBuilder(
        //   future: productRepo.getProductByID(favouriteProduct!.productID!),
        //   builder: (context, snapshot) {
        //     if (snapshot.connectionState == ConnectionState.waiting) {
        //       return Center(
        //         child: CircularProgressIndicator(),
        //       );
        //     } else {
        //       if (snapshot.data != null) {
        //         return
        GestureDetector(
      onTap: () {
        print("Product");
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => ProductDetailsPage(id: currentProduct!.id!),
        ));
      },
      child: Container(
        decoration: BoxDecoration(color: MyTheme.background),
        width: MediaQuery.of(context).size.width * 0.3,
        height: 220.h,
        child: Padding(
          padding: EdgeInsets.only(bottom: 1.h),
          child: currentProduct != null
              ? Container(
                  width: MediaQuery.of(context).size.width * 0.3,
                  height: 120.h,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.45,
                        height: 120.h,
                        padding: EdgeInsets.all(4.h),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadiusStyle.roundedBorder2,
                          image: DecorationImage(
                            image: NetworkImage(
                              currentProduct!.images![0],
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: 56.h,
                              margin: EdgeInsets.only(bottom: 77.h),
                              padding: EdgeInsets.symmetric(
                                horizontal: 4.h,
                                vertical: 2.h,
                              ),
                              decoration: AppDecoration.fillOrange.copyWith(
                                borderRadius: BorderRadiusStyle.roundedBorder2,
                              ),
                              child: Text(
                                "top_seller",
                                style: CustomTextStyles
                                    .labelMediumOnPrimaryContainer,
                              ),
                            ),
                            Padding(
                                padding: EdgeInsets.only(
                                  // right: 10.w,
                                  bottom: 72.h,
                                ),
                                child: InkWell(
                                    onTap: () async {
                                      await wishListRepo.deleteFavourite(
                                          widget.favouriteProduct!.id!);
                                    },
                                    child: Icon(
                                      Icons.favorite,
                                      color: MyTheme.red,
                                    ))),
                          ],
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Container(
                        padding: const EdgeInsets.only(left: 8),
                        width: 147.h,
                        child: Text(
                          currentProduct!.name!,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: theme.textTheme.displayLarge!.copyWith(
                            height: 1.50,
                          ),
                        ),
                      ),
                      SizedBox(height: 10.h),
                      // Container(
                      //   padding: const EdgeInsets.only(left: 8, right: 8),
                      //   child: Row(
                      //     children: [
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
                      //     ],
                      //   ),
                      // ),
                      // SizedBox(height: 9.h),
                      Container(
                        padding: const EdgeInsets.only(left: 10),
                        child: Text(
                          "${currentProduct!.price} VND",
                          style: theme.textTheme.displayLarge,
                        ),
                      ),
                    ],
                  ),
                )
              : Container(),
        ),
      ),
    );
  }
}
