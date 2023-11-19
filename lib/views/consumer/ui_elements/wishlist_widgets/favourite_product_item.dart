import 'package:cached_network_image/cached_network_image.dart';
import 'package:dpl_ecommerce/const/app_decoration.dart';
import 'package:dpl_ecommerce/const/app_theme.dart';
import 'package:dpl_ecommerce/customs/custom_icon_button.dart';
import 'package:dpl_ecommerce/customs/custom_image_view.dart';
import 'package:dpl_ecommerce/customs/custom_text_style.dart';
import 'package:dpl_ecommerce/models/product.dart';
import 'package:dpl_ecommerce/utils/constants/image_data.dart';
import 'package:dpl_ecommerce/views/consumer/screens/product_detail_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Productsmalllist1ItemWidget extends StatelessWidget {
  Productsmalllist1ItemWidget({Key? key, required this.product})
      : super(
          key: key,
        );
  Product? product;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // go to detail
        print("Product");
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => ProductDetailsPage(product: product),
        ));
      },
      child: Container(
        color: Colors.amber,
        width: 148.w,
        height: 200.h,
        child: Padding(
          padding: EdgeInsets.only(bottom: 1.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              VisualFavouriteProduct(urlImage: product!.images![0]),
              SizedBox(height: 6.h),
              Container(
                padding: EdgeInsets.only(left: 10),
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
                padding: EdgeInsets.only(left: 10, right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
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
                            product!.rating!.toString(),
                            style: theme.textTheme.bodySmall,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 4.h),
                          child: Text(
                            product!.ratingCount!.toString(),
                            style: CustomTextStyles.bodySmallGray600,
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
                padding: EdgeInsets.only(left: 10),
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

class VisualFavouriteProduct extends StatelessWidget {
  VisualFavouriteProduct({super.key, required this.urlImage});
  String? urlImage;
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
              placeholder: (context, url) => const Center(
                  child: SizedBox(
                      width: 30,
                      height: 30,
                      child: CircularProgressIndicator())),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
          ),
          Positioned(
            top: 5,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
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
                  Padding(
                    padding: EdgeInsets.only(
                      left: 60.h,
                      bottom: 72.h,
                    ),
                    child: CustomIconButton(
                      height: 24.h,
                      width: 24.h,
                      padding: EdgeInsets.all(4.h),
                      child: CustomImageView(
                        imagePath: ImageData.imgFrame48x48,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
