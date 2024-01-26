import 'package:dpl_ecommerce/const/app_decoration.dart';
import 'package:dpl_ecommerce/const/app_theme.dart';
import 'package:dpl_ecommerce/customs/custom_icon_button.dart';
import 'package:dpl_ecommerce/customs/custom_image_view.dart';
import 'package:dpl_ecommerce/customs/custom_text_style.dart';
import 'package:dpl_ecommerce/models/product.dart';
import 'package:dpl_ecommerce/models/product_in_cart_model.dart';
import 'package:dpl_ecommerce/models/voucher.dart';
import 'package:dpl_ecommerce/repositories/cart_repo.dart';
import 'package:dpl_ecommerce/repositories/product_repo.dart';
import 'package:dpl_ecommerce/repositories/voucher_repo.dart';
import 'package:dpl_ecommerce/utils/common/common_caculated_methods.dart';
import 'package:dpl_ecommerce/utils/common/common_methods.dart';
import 'package:dpl_ecommerce/utils/constants/image_data.dart';
import 'package:dpl_ecommerce/utils/lang/lang_text.dart';
import 'package:dpl_ecommerce/view_model/consumer/cart_view_model.dart';
import 'package:dpl_ecommerce/view_model/user_view_model.dart';
import 'package:dpl_ecommerce/views/consumer/screens/product_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
  VoucherRepo voucherRepo = VoucherRepo();
  CartRepo cartRepo = CartRepo();
  ProductRepo productRepo = ProductRepo();
  Voucher? voucher;
  bool isLoading = true;
  bool isProductLoading = true;
  // Product? product;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // if (mounted) {
    fetchData();
    // }
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> fetchData() async {
    if (widget.productInCartModel!.voucherID != null) {
      voucher = await voucherRepo
          .getVoucherByID(widget.productInCartModel!.voucherID!);
      isLoading = false;
    } else {
      isLoading = false;
    }
    if (mounted) {
      setState(() {});
    }

    // product =
    //     await productRepo.getProductByID(widget.productInCartModel!.productID!);
    // setState(() {
    //   isProductLoading = false;
    // });
  }

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartViewModel>(context);
    final userProvider = Provider.of<UserViewModel>(context);
    final user = userProvider.currentUser;
    return GestureDetector(
      onTap: () {
        // Product? product = CommondMethods.getProductByID(
        //     listProduct!, widget.productInCartModel!.productID!);
        // if (!isProductLoading) {
        //   if (product != null) {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) {
            // if (product != null) {
            return ProductDetailsPage(
              id: widget.productInCartModel!.productID!,
            );
            // }
          },
        ));
        //   } else {
        //     print("Product is null");
        //   }
        // }
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
                SizedBox(
                  width: 10.w,
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
                          child: Text(widget.productInCartModel!.productName!,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black)),
                        ),
                        // CustomIconButton(
                        //   height: 20,
                        //   width: 20,
                        //   child: Icon(Icons.favorite),
                        //   onTap: () {
                        //     //toggle
                        //     print("Favourite");
                        //   },
                        // ),
                        const SizedBox(
                          width: 20,
                        ),
                        Consumer<CartViewModel>(
                          builder: (context, value, child) {
                            return CustomIconButton(
                              height: 20.h,
                              width: 20.h,
                              child: const Icon(
                                Icons.delete,
                                color: Colors.red,
                              ),
                              onTap: () async {
                                //delete item from cart
                                print("delete");

                                // Voucher? voucher = CommondMethods.getVoucherFromID(
                                //     listVoucher,
                                //     widget.productInCartModel!.voucherID!);
                                // if (voucher != null) {
                                //   savingCost =
                                //       CommonCaculatedMethods.caculateSavignCost(
                                //           voucher, widget.productInCartModel!.cost);
                                // }

                                if (!isLoading) {
                                  // if(value.list.any((element) => element.id==widget.productInCartModel!.id)){
                                  // }
                                  int savingCost = 0;
                                  if (voucher != null) {
                                    savingCost = CommonCaculatedMethods
                                        .caculateSavignCost(voucher!,
                                            widget.productInCartModel!.cost);
                                  }
                                  await cartRepo.deleteProductInCartModel(
                                      uid: user!.id!,
                                      productInCartModel:
                                          widget.productInCartModel,
                                      savingCost: savingCost);
                                  cartProvider.deleteFromCart(
                                      widget.productInCartModel!);
                                }
                              },
                            );
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    SizedBox(
                      width: 227,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _buildCostWidget(context),

                          // Spacer(),
                          // CustomIconButton(
                          //   width: 28,
                          //   height: 28,
                          //   child: Container(
                          //       decoration: BoxDecoration(
                          //           border: Border.all(width: 0.1)),
                          //       child: Icon(
                          //         Icons.remove,
                          //         size: 20,
                          //       )),
                          //   onTap: () {
                          //     // minus
                          //     int number =
                          //         widget.productInCartModel!.quantity - 1;
                          //     cartProvider.updateNumber(
                          //         number, widget.productInCartModel!.id!);
                          //     print("decrease number");
                          //   },
                          // ),
                          SizedBox(
                            width: 25.w,
                          ),
                          Container(
                            width: 58.w,
                            padding: EdgeInsets.symmetric(
                              horizontal: 18.w,
                              vertical: 6.h,
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
                          // CustomIconButton(
                          //   width: 28,
                          //   height: 28,
                          //   child: Container(
                          //       decoration: BoxDecoration(
                          //           border: Border.all(width: 0.1)),
                          //       child: Icon(
                          //         Icons.add,
                          //         size: 20,
                          //       )),
                          //   onTap: () {
                          //     // increase

                          //     print("increase number");
                          //     int number =
                          //         widget.productInCartModel!.quantity + 1;
                          //     cartProvider.updateNumber(
                          //         number, widget.productInCartModel!.id!);
                          //     print("decrease number");
                          //   },
                          // ),
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
                    ? Text(
                        "${LangText(context: context).getLocal()!.decrease_ucf}  ${voucher!.discountPercent}%")
                    : Text(
                        "${LangText(context: context).getLocal()!.decrease_ucf}  ${voucher!.discountAmount} VND"),
              ),
            },
            if (widget.productInCartModel!.color != null ||
                widget.productInCartModel!.size != null ||
                widget.productInCartModel!.type != null) ...{
              Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  // color: Colors.amberAccent,
                  padding: EdgeInsets.all(3.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      if (widget.productInCartModel!.color != null) ...{
                        Text(
                            "${LangText(context: context).getLocal()!.color_ucf}: ${widget.productInCartModel!.color!}")
                      },
                      if (widget.productInCartModel!.size != null) ...{
                        Text(
                            "${LangText(context: context).getLocal()!.size_ucf}: ${widget.productInCartModel!.size!}")
                      },
                      if (widget.productInCartModel!.type != null) ...{
                        Text(
                            "${LangText(context: context).getLocal()!.type_ucf}: ${widget.productInCartModel!.type!}")
                      },
                    ],
                  )),
            }
          ],
        ),
      ),
    );
  }

  Widget _buildCostWidget(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 6.h),
      child: voucher != null
          ? Column(
              children: [
                (voucher!.discountAmount != null
                    ? Text(
                        "${widget.productInCartModel!.cost - voucher!.discountAmount!} VND",
                        style: TextStyle(
                          fontSize: 16.sp,
                          color: MyTheme.button_color,
                        ),
                      )
                    : Text(
                        "${widget.productInCartModel!.cost - (voucher!.discountPercent! / 100) * widget.productInCartModel!.cost} VND",
                        style: TextStyle(
                          fontSize: 16.sp,
                          color: MyTheme.button_color,
                        ),
                      )),
                Text(
                  "${widget.productInCartModel!.cost} VND",
                  style: TextStyle(
                      fontSize: 14.sp,
                      color: MyTheme.dark_grey,
                      decoration: TextDecoration.lineThrough,
                      decorationColor: MyTheme.red),
                )
              ],
            )
          : Text(
              "${widget.productInCartModel!.cost} VND",
              style: TextStyle(
                fontSize: 16.sp,
                color: MyTheme.button_color,
              ),
            ),
    );
  }
}
