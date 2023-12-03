import 'package:dpl_ecommerce/const/app_decoration.dart';
import 'package:dpl_ecommerce/const/app_theme.dart';
import 'package:dpl_ecommerce/customs/custom_array_back_widget.dart';
import 'package:dpl_ecommerce/customs/custom_button_style.dart';
import 'package:dpl_ecommerce/customs/custom_elevate_button.dart';
import 'package:dpl_ecommerce/customs/custom_text_form_field.dart';
import 'package:dpl_ecommerce/customs/custom_text_style.dart';
import 'package:dpl_ecommerce/models/cart.dart';
import 'package:dpl_ecommerce/models/product_in_cart_model.dart';
import 'package:dpl_ecommerce/models/user.dart';
import 'package:dpl_ecommerce/models/voucher.dart';
import 'package:dpl_ecommerce/repositories/cart_repo.dart';
import 'package:dpl_ecommerce/repositories/product_in_cart_repo.dart';
import 'package:dpl_ecommerce/repositories/voucher_repo.dart';
import 'package:dpl_ecommerce/utils/common/common_methods.dart';
import 'package:dpl_ecommerce/view_model/consumer/cart_view_model.dart';
import 'package:dpl_ecommerce/view_model/user_view_model.dart';
import 'package:dpl_ecommerce/views/consumer/ui_elements/cart_widgets/product_cart_item.dart';
import 'package:dpl_ecommerce/views/consumer/screens/product_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

// ignore_for_file: must_be_immutable
class CartPage extends StatefulWidget {
  CartPage({Key? key})
      : super(
          key: key,
        );

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  CartRepo cartrepo = CartRepo();
  VoucherRepo voucherRepo = VoucherRepo();
  List<Voucher>? listVoucher;
  bool isLoading = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    listVoucher = await voucherRepo.getListVoucher();
    setState(() {
      isLoading = false;
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    listVoucher!.clear();
  }

  @override
  Widget build(BuildContext context) {
    // mediaQueryData = MediaQuery.of(context);
    final provider = Provider.of<CartViewModel>(context, listen: true);
    final cart = provider.cart;
    final userProvider = Provider.of<UserViewModel>(context);
    final user = userProvider.currentUser;
    final size = MediaQuery.of(context).size;
    if (!isLoading) {
      provider.setListVoucher(listVoucher!);
    }
    // final selectedProduct = provider.list;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: CustomArrayBackWidget(function: () {
          provider.reset();
        }),
        title: Text("Your cart"),
      ),
      body: Container(
        // color: Colors.green,
        width: double.maxFinite,
        // decoration: AppDecoration.fillOnPrimaryContainer,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            // SizedBox(height: 16.h),
            CartBody(size: size, cartrepo: cartrepo, user: user),
            // SizedBox(height: 32),
            // _buildCuponForm(context), // replace by other CuponWidget
            SizedBox(height: 10.h),
            _buildTotalPrice1(context),
            // SizedBox(height: 16),

            // Spacer(),
            SizedBox(height: 10.h),
            Container(
              padding: EdgeInsets.all(3.h),
              height: size.height * 0.06,
              width: size.width * 0.9,
              child: ElevatedButton(
                  style: ButtonStyle(
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.r)))),
                  onPressed: () {},
                  child: const Text("Check out")),
            ),
            SizedBox(height: 10.h),
          ],
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildTotalPrice1(BuildContext context) {
    final provider = Provider.of<CartViewModel>(context, listen: false);
    final userProvider = Provider.of<UserViewModel>(context);
    final user = userProvider.currentUser;
    final selectedProduct = provider.list;
    return
        // FutureBuilder(
        //   builder: (context, snapshot) {
        //     if (snapshot.connectionState == ConnectionState.waiting) {
        //       return Container(
        //           height: MediaQuery.of(context).size.height * 0.14,
        //           margin: EdgeInsets.symmetric(horizontal: 15.w),
        //           padding: EdgeInsets.all(5.h),
        //           decoration: AppDecoration.outlineBlueGray.copyWith(
        //             borderRadius: BorderRadius.circular(10),
        //           ));
        //     } else {
        //       if (snapshot.data != null) {
        // final cart = snapshot.data;
        // return
        Container(
      height: MediaQuery.of(context).size.height * 0.14,
      margin: EdgeInsets.symmetric(horizontal: 15.w),
      padding: EdgeInsets.all(5.h),
      decoration: AppDecoration.outlineBlueGray.copyWith(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Consumer<CartViewModel>(
            builder: (context, value, child) => _buildShipping(
              context,
              shippingLabel: "Items ${selectedProduct.length}",
              priceLabel: "${provider.totalCost} VND",
            ),
          ),
          SizedBox(height: 8.h),
          Consumer<CartViewModel>(
            builder: (context, value, child) => _buildShipping(
              context,
              shippingLabel: "Save",
              priceLabel: "${provider.savingCost}",
            ),
          ),
          // SizedBox(height: 10),
          const Divider(),
          const SizedBox(height: 6),
          Consumer<CartViewModel>(
            builder: (context, value, child) => _buildShipping(
              context,
              shippingLabel: "real price",
              priceLabel: "${provider.totalCost - provider.savingCost}",
            ),
          ),
        ],
      ),
    );
    //     } else {
    //       return Container(
    //         height: MediaQuery.of(context).size.height * 0.14,
    //         margin: EdgeInsets.symmetric(horizontal: 15.w),
    //         padding: EdgeInsets.all(5.h),
    //         decoration: AppDecoration.outlineBlueGray.copyWith(
    //           borderRadius: BorderRadius.circular(10),
    //         ),
    //         child: Column(
    //           mainAxisSize: MainAxisSize.min,
    //           mainAxisAlignment: MainAxisAlignment.center,
    //           children: [
    //             _buildShipping(
    //               context,
    //               shippingLabel: "Items 0",
    //               priceLabel: "0 VND",
    //             ),

    //             SizedBox(height: 8.h),
    //             _buildShipping(
    //               context,
    //               shippingLabel: "Save",
    //               priceLabel: "0",
    //             ),
    //             // SizedBox(height: 10),
    //             const Divider(),
    //             const SizedBox(height: 6),
    //             _buildShipping(
    //               context,
    //               shippingLabel: "real price",
    //               priceLabel: "0",
    //             ),
    //           ],
    //         ),
    //       );
    //     }
    //   }
    // },
    // future: cartrepo.getCart(user!.id!),
    // );
  }

  /// Common widget
  Widget _buildShipping(
    BuildContext context, {
    required String shippingLabel,
    required String priceLabel,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
          child: Text(
            shippingLabel,
            style: theme.textTheme.bodySmall!.copyWith(
              color: appTheme.blueGray300,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
          child: Text(
            priceLabel,
            style: CustomTextStyles.bodyMediumGray600.copyWith(
              color: theme.colorScheme.onPrimary.withOpacity(1),
            ),
          ),
        ),
      ],
    );
  }
}

class CartBody extends StatelessWidget {
  const CartBody({
    super.key,
    required this.size,
    required this.cartrepo,
    required this.user,
  });

  final Size size;
  final CartRepo cartrepo;
  final UserModel? user;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: FutureBuilder(
        builder: (context, snapshot) {
          // if (snapshot.connectionState == ConnectionState.waiting) {
          //   return Center(
          //     child: CircularProgressIndicator(),
          //   );
          // } else {
          if (snapshot.data != null) {
            final cart = snapshot.data;
            if (cart!.productInCarts != null) {
              return ProductInCartDetails(list: cart!.productInCarts!);
            } else {
              return Container(
                height: size.height * 0.5,
                child: Center(
                  child: Text("No product"),
                ),
              );
            }
          } else {
            return Container(
              height: size.height * 0.5,
              child: Center(
                child: Text("No product"),
              ),
            );
          }
        },
        // },
        future: cartrepo.getCart(user!.id!),
      ),
    );
  }
}

class ProductInCartDetails extends StatelessWidget {
  ProductInCartDetails({super.key, required this.list});
  List<ProductInCartModel> list;
  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartViewModel>(context);
    final size = MediaQuery.of(context).size;
    List<ProductInCartModel> newList = CommondMethods.sortByTime(list);
    return Container(
        // color: Colors.amber,
        width: size.width,
        height: size.height * 0.62,
        padding: EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: size.height * 0.06,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(
                    width: 10,
                  ),
                  Consumer<CartViewModel>(
                    builder: (context, value, child) {
                      return Checkbox(
                        value: value.isCheckedALl,
                        onChanged: (value) {
                          cartProvider.toggleCheckAll();
                        },
                      );
                    },
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text("Select all")
                ],
              ),
            ),
            Expanded(
              child: ListView.separated(
                physics: BouncingScrollPhysics(),
                shrinkWrap: true,
                separatorBuilder: (
                  context,
                  index,
                ) {
                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: 3.0),
                    child: SizedBox(
                      width: double.maxFinite,
                      child: Divider(
                        height: 1,
                        thickness: 1,
                        color: appTheme.blueGray7000f,
                      ),
                    ),
                  );
                },
                itemCount: newList.length,
                itemBuilder: (context, index) {
                  return ProductInCartItem(
                    index: index,
                    productInCartModel: newList[index],
                    isCheckedAll: false,
                  );
                },
              ),
            ),
          ],
        ));
  }
}

class ProductInCartItem extends StatefulWidget {
  ProductInCartItem(
      {super.key,
      required this.index,
      required this.productInCartModel,
      this.isChecked = false,
      this.isCheckedAll});
  int index;
  ProductInCartModel? productInCartModel;
  bool isChecked;
  bool? isCheckedAll;

  @override
  State<ProductInCartItem> createState() => _ProductInCartItemState();
}

class _ProductInCartItemState extends State<ProductInCartItem> {
  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartViewModel>(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.06,
          child: Consumer<CartViewModel>(
            builder: (context, provider, child) {
              print(
                  "Value here:${provider.list.contains(widget.productInCartModel)}");
              bool containsId = provider.list
                  .any((item) => item.id == widget.productInCartModel?.id);
              return Checkbox(
                value: containsId,
                onChanged: (value) {
                  if (provider.isCheckedALl) {
                    cartProvider.uncheckedProduct(widget.productInCartModel!);
                  } else {
                    setState(() {
                      if (value!) {
                        cartProvider.checkProduct(widget.productInCartModel!);
                      } else {
                        cartProvider
                            .uncheckedProduct(widget.productInCartModel!);
                      }
                      // widget.isChecked = !widget.isChecked;
                    });
                  }
                },
              );
            },
          ),
        ),
        SizedBox(
          width: 10.w,
        ),
        ProductCartItem(productInCartModel: widget.productInCartModel),
      ],
    );
  }
}
