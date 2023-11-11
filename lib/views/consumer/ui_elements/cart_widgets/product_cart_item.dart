import 'package:dpl_ecommerce/const/app_decoration.dart';
import 'package:dpl_ecommerce/const/app_theme.dart';
import 'package:dpl_ecommerce/customs/custom_icon_button.dart';
import 'package:dpl_ecommerce/customs/custom_image_view.dart';
import 'package:dpl_ecommerce/customs/custom_text_style.dart';
import 'package:dpl_ecommerce/models/product_in_cart_model.dart';
import 'package:dpl_ecommerce/utils/constants/image_data.dart';
import 'package:dpl_ecommerce/view_model/consumer/cart_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class ProductCartItem extends StatelessWidget {
  ProductCartItem({Key? key, required this.productInCartModel})
      : super(
          key: key,
        );
  ProductInCartModel? productInCartModel;
  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartViewModel>(context);
    return GestureDetector(
      onTap: () {
        //
      },
      child: Container(
        color: Colors.teal[50],
        padding: EdgeInsets.symmetric(vertical: 14),
        // decoration: AppDecoration.outlineBlueGray.copyWith(
        //   borderRadius: BorderRadiusStyle.roundedBorder2,
        // ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CustomImageView(
              imagePath: productInCartModel!.productImage!,
              height: 72,
              width: 72,
              radius: BorderRadius.circular(
                5,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 150,
                      child: Text(
                        productInCartModel!.productName!,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: CustomTextStyles.labelLargeBluegray300.copyWith(
                          height: 1.50,
                        ),
                      ),
                    ),
                    CustomIconButton(
                      height: 20,
                      width: 20,
                      child: Icon(Icons.favorite),
                      onTap: () {
                        //toggle
                        print("Favourite");
                      },
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    CustomIconButton(
                      height: 20,
                      width: 20,
                      child: Icon(Icons.delete),
                      onTap: () {
                        //delete item from cart
                        print("delete");
                        cartProvider.deleteFromCart(productInCartModel!);
                      },
                    ),
                  ],
                ),
                SizedBox(height: 10),
                SizedBox(
                  width: 227,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 6),
                        child: Text(
                          "${productInCartModel!.cost} VND",
                          style: CustomTextStyles.labelLargeBluegray300,
                        ),
                      ),
                      Spacer(),
                      CustomIconButton(
                        width: 28,
                        height: 28,
                        child: Container(
                            decoration:
                                BoxDecoration(border: Border.all(width: 0.1)),
                            child: Icon(
                              Icons.remove,
                              size: 20,
                            )),
                        onTap: () {
                          // minus
                          print("decrease number");
                        },
                      ),
                      Container(
                        width: 58,
                        padding: EdgeInsets.symmetric(
                          horizontal: 18,
                          vertical: 6,
                        ),
                        decoration: AppDecoration.outlineBlueGray,
                        child: Center(
                          child: Text(
                            "${productInCartModel!.quantity}",
                            style: CustomTextStyles.bodyMediumGray600,
                          ),
                        ),
                      ),
                      CustomIconButton(
                        width: 28,
                        height: 28,
                        child: Container(
                            decoration:
                                BoxDecoration(border: Border.all(width: 0.1)),
                            child: Icon(
                              Icons.add,
                              size: 20,
                            )),
                        onTap: () {
                          // increase
                          print("increase number");
                        },
                      ),
                      // SizedBox(
                      //   height: 24,
                      //   width: 32,
                      //   child: Stack(
                      //     alignment: Alignment.center,
                      //     children: [
                      //       CustomImageView(
                      //         imagePath: ImageData.imgFrame140x140,
                      //         height: 24,
                      //         width: 32,
                      //         alignment: Alignment.center,
                      //       ),
                      //       CustomImageView(
                      //         imagePath: ImageData.imgFrame1,
                      //         height: 16,
                      //         width: 16,
                      //         alignment: Alignment.center,
                      //       ),
                      //     ],
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
