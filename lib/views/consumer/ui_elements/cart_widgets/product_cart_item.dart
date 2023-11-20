import 'package:dpl_ecommerce/const/app_decoration.dart';
import 'package:dpl_ecommerce/const/app_theme.dart';
import 'package:dpl_ecommerce/customs/custom_icon_button.dart';
import 'package:dpl_ecommerce/customs/custom_image_view.dart';
import 'package:dpl_ecommerce/customs/custom_text_style.dart';
import 'package:dpl_ecommerce/models/product.dart';
import 'package:dpl_ecommerce/models/product_in_cart_model.dart';
import 'package:dpl_ecommerce/models/voucher.dart';
import 'package:dpl_ecommerce/repositories/product_repo.dart';
import 'package:dpl_ecommerce/repositories/voucher_repo.dart';
import 'package:dpl_ecommerce/utils/common/common_methods.dart';
import 'package:dpl_ecommerce/utils/constants/image_data.dart';
import 'package:dpl_ecommerce/view_model/consumer/cart_view_model.dart';
import 'package:dpl_ecommerce/views/consumer/screens/product_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class ProductCartItem extends StatefulWidget {
  ProductCartItem({Key? key, required this.productInCartModel})
      : super(
          key: key,
        );
  ProductInCartModel? productInCartModel;

  @override
  State<ProductCartItem> createState() => _ProductCartItemState();
}

class _ProductCartItemState extends State<ProductCartItem> {
  //  voucher;
  List<Voucher> listVoucher = VoucherRepo().list;
  Voucher? voucher;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.productInCartModel!.voucherID != null) {
      voucher = CommondMethods.getVoucherFromID(
          listVoucher, widget.productInCartModel!.voucherID!);
    }
  }

  List<Product>? listProduct = ProductRepo().list;
  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartViewModel>(context);

    return GestureDetector(
      onTap: () {
        Product? product = CommondMethods.getProductByID(
            listProduct!, widget.productInCartModel!.productID!);
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) {
            // if (product != null) {
            return ProductDetailsPage(
              product: product,
            );
            // }
          },
        ));
      },
      child: Container(
        color: Colors.teal[50],
        padding: EdgeInsets.symmetric(vertical: 14),
        // decoration: AppDecoration.outlineBlueGray.copyWith(
        //   borderRadius: BorderRadiusStyle.roundedBorder2,
        // ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CustomImageView(
                  imagePath: widget.productInCartModel!.productImage!,
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
                            widget.productInCartModel!.productName!,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style:
                                CustomTextStyles.labelLargeBluegray300.copyWith(
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
                            cartProvider
                                .deleteFromCart(widget.productInCartModel!);
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
                          _buildCostWidget(context),

                          Spacer(),
                          CustomIconButton(
                            width: 28,
                            height: 28,
                            child: Container(
                                decoration: BoxDecoration(
                                    border: Border.all(width: 0.1)),
                                child: Icon(
                                  Icons.remove,
                                  size: 20,
                                )),
                            onTap: () {
                              // minus
                              int number =
                                  widget.productInCartModel!.quantity - 1;
                              cartProvider.updateNumber(
                                  number, widget.productInCartModel!.id!);
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
                              child: Consumer<CartViewModel>(
                                builder: (context, value, child) {
                                  return Text(
                                    "${widget.productInCartModel!.quantity}",
                                    style: CustomTextStyles.bodyMediumGray600,
                                  );
                                },
                              ),
                            ),
                          ),
                          CustomIconButton(
                            width: 28,
                            height: 28,
                            child: Container(
                                decoration: BoxDecoration(
                                    border: Border.all(width: 0.1)),
                                child: Icon(
                                  Icons.add,
                                  size: 20,
                                )),
                            onTap: () {
                              // increase

                              print("increase number");
                              int number =
                                  widget.productInCartModel!.quantity + 1;
                              cartProvider.updateNumber(
                                  number, widget.productInCartModel!.id!);
                              print("decrease number");
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
            if (voucher != null) ...{
              Padding(
                padding: const EdgeInsets.only(top: 6, left: 5),
                child: voucher!.discountPercent != null
                    ? Text("Decrease  ${voucher!.discountPercent}%")
                    : Text("Decrease  ${voucher!.discountAmount} VND"),
              ),
            },
          ],
        ),
      ),
    );
  }

  Widget _buildCostWidget(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 6),
      child: voucher != null
          ? (voucher!.discountAmount != null
              ? Text(
                  "${widget.productInCartModel!.cost - voucher!.discountAmount!} VND",
                  style: CustomTextStyles.labelLargeBluegray300,
                )
              : Text(
                  "${widget.productInCartModel!.cost - (voucher!.discountPercent! / 100) * widget.productInCartModel!.cost} VND",
                  style: CustomTextStyles.labelLargeBluegray300,
                ))
          : Text(
              "${widget.productInCartModel!.cost} VND",
              style: CustomTextStyles.labelLargeBluegray300,
            ),
    );
  }
}
