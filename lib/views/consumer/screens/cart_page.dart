import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dpl_ecommerce/const/app_decoration.dart';
import 'package:dpl_ecommerce/const/app_theme.dart';
import 'package:dpl_ecommerce/const/my_text_style.dart';
import 'package:dpl_ecommerce/customs/custom_array_back_widget.dart';

import 'package:dpl_ecommerce/customs/custom_text_style.dart';
import 'package:dpl_ecommerce/helpers/shimmer_helper.dart';
import 'package:dpl_ecommerce/helpers/toast_helper.dart';
import 'package:dpl_ecommerce/models/address_infor.dart';
import 'package:dpl_ecommerce/models/order_model.dart' as orderModel;
import 'package:dpl_ecommerce/models/ordering_product.dart';
import 'package:dpl_ecommerce/models/product.dart';
import 'package:dpl_ecommerce/models/product_in_cart_model.dart';
import 'package:dpl_ecommerce/models/user.dart';
import 'package:dpl_ecommerce/models/voucher.dart';
import 'package:dpl_ecommerce/models/voucher_for_user.dart';
import 'package:dpl_ecommerce/repositories/cart_repo.dart';
import 'package:dpl_ecommerce/repositories/product_repo.dart';
import 'package:dpl_ecommerce/repositories/user_repo.dart';
import 'package:dpl_ecommerce/repositories/voucher_for_user_repo.dart';
import 'package:dpl_ecommerce/repositories/voucher_repo.dart';
import 'package:dpl_ecommerce/utils/common/common_methods.dart';
import 'package:dpl_ecommerce/utils/lang/lang_text.dart';
import 'package:dpl_ecommerce/view_model/address_view_model.dart';
import 'package:dpl_ecommerce/view_model/consumer/cart_view_model.dart';
import 'package:dpl_ecommerce/view_model/consumer/checkout_view_model.dart';
import 'package:dpl_ecommerce/view_model/consumer/voucher_for_user_view_model.dart';
import 'package:dpl_ecommerce/view_model/user_view_model.dart';
import 'package:dpl_ecommerce/views/consumer/screens/checkout.dart';
import 'package:dpl_ecommerce/views/consumer/ui_elements/cart_widgets/product_cart_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
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
  VoucherForUserRepo voucherForUserRepo = VoucherForUserRepo();
  UserRepo userRepo = UserRepo();
  List<Voucher>? listVoucher;
  bool isLoading = true;
  VoucherForUser? voucherForUser;
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

  Future<void> getVoucherForUser(String uid) async {
    voucherForUser = await voucherForUserRepo.getVoucher(uid);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    listVoucher!.clear();
  }

  Future<void> getListVoucherOfAdminBeforeCheckout(
      VoucherForUserViewModel voucherForUserViewModel, String uid) async {
    await getVoucherForUser(uid);
    List<Voucher>? listAllVoucher = await voucherRepo.getListVoucher();
    if (listAllVoucher != null) {
      List<Voucher>? voucherOfAdminInUser =
          CommondMethods.getListVoucherOfAdminInUserAcc(
              voucherForUser!.vouchers!, listAllVoucher);
      if (voucherOfAdminInUser != null && voucherOfAdminInUser.isNotEmpty) {
        voucherForUserViewModel.setListVoucherOfAdmin(voucherOfAdminInUser!);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // mediaQueryData = MediaQuery.of(context);
    final provider = Provider.of<CartViewModel>(context, listen: true);
    final cart = provider.cart;
    final userProvider = Provider.of<UserViewModel>(context);
    final checkoutProvider = Provider.of<CheckoutViewModel>(context);
    final addressProvider = Provider.of<AddressViewModel>(context);
    final user = userProvider.currentUser;
    final size = MediaQuery.of(context).size;
    if (!isLoading) {
      provider.setListVoucher(listVoucher!);
    }
    final voucherForUserProvider =
        Provider.of<VoucherForUserViewModel>(context);
    // final selectedProduct = provider.list;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: CustomArrayBackWidget(function: () {
          provider.reset();
          checkoutProvider.reset();
        }),
        centerTitle: true,
        backgroundColor: MyTheme.accent_color,
        title: Text(
          LangText(context: context).getLocal()!.cart_ucf,
          style: MyTextStyle1().appBarText(),
        ),
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
            buildCheckOutButton(context),
            SizedBox(height: 10.h),
          ],
        ),
      ),
    );
  }

  Widget buildCheckOutButton(BuildContext context) {
    final provider = Provider.of<CartViewModel>(context, listen: true);
    final cart = provider.cart;
    final userProvider = Provider.of<UserViewModel>(context);
    final checkoutProvider = Provider.of<CheckoutViewModel>(context);
    final addressProvider = Provider.of<AddressViewModel>(context);
    final user = userProvider.currentUser;
    final size = MediaQuery.of(context).size;

    final voucherForUserProvider =
        Provider.of<VoucherForUserViewModel>(context);
    return Consumer<CartViewModel>(
      builder: (context, provider, child) => Container(
        padding: EdgeInsets.all(3.h),
        height: size.height * 0.07,
        width: size.width * 0.9,
        child: ElevatedButton(
            style: ButtonStyle(
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.r),
                ),
              ),
              backgroundColor: MaterialStateProperty.all(MyTheme.white),
              side: MaterialStateProperty.all(
                BorderSide(
                  color: MyTheme.accent_color,
                  width: 1,
                ),
              ),
            ),
            onPressed: () async {
              if (provider.list.isEmpty) {
                ToastHelper.showDialog(
                    LangText(context: context)
                        .getLocal()!
                        .please_choose_at_least_one_product,
                    gravity: ToastGravity.CENTER,
                    duration: Toast.LENGTH_SHORT);
                return;
              }
              // set address
              AddressInfor? addressInfor =
                  await userRepo.getDefaultAddress(user!.id!);
              if (addressInfor == null) {
                ToastHelper.showDialog(
                    LangText(context: context)
                        .getLocal()!
                        .please_enter_your_address_first,
                    gravity: ToastGravity.CENTER,
                    duration: Toast.LENGTH_SHORT);
                return;
              }
              addressProvider.setDefaultAddress(addressInfor!);
              addressProvider.setOrderingAddress(addressInfor);
              List<AddressInfor>? list =
                  await userRepo.getListAddressInfor(user!.id!);

              addressProvider.setListAddressInfor(list!);

              // set order
              int totalCost = provider.totalCost;
              int realCost = provider.totalCost - provider.savingCost;
              List<OrderingProduct>? listOrderingProduct = [];
              List<String> listProductInCartID = [];
              for (var element in provider.list) {
                listProductInCartID.add(element.id!);
                String productID = element.productID!;
                Product? product =
                    await ProductRepo().getProductByID(productID);
                if (product == null) {
                  ToastHelper.showDialog(
                      "${LangText(context: context).getLocal()!.data_no_longer_exists}${element.productName}",
                      gravity: ToastGravity.CENTER);
                  break;
                }
                if (product!.availableQuantity! < element.quantity) {
                  ToastHelper.showDialog(
                      "${LangText(context: context).getLocal()!.current_inventory_is_insufficient_for}${product.name}",
                      gravity: ToastGravity.CENTER);
                  break;
                }

                int realCost = element.cost;
                if (element.voucherID != null) {
                  Voucher? voucher =
                      await voucherRepo.getVoucherByID(element.voucherID!);
                  if (voucher != null &&
                      voucher.expDate!
                              .compareTo(Timestamp.fromDate(DateTime.now())) >
                          0) {
                    if (voucher.discountAmount != null) {
                      realCost = realCost - voucher.discountAmount!;
                    } else {
                      realCost = realCost -
                          (realCost * voucher.discountPercent! / 100).toInt();
                    }
                  }
                }

                OrderingProduct orderingProduct = OrderingProduct(
                    color: element.color,
                    date: Timestamp.now(),
                    price: element.cost,
                    productID: element.productID,
                    quantity: element.quantity,
                    realPrice: realCost * element.quantity,
                    size: element.size,
                    type: element.type,
                    userID: element.userID,
                    voucherID: element.voucherID,
                    deliverStatus: DeliverStatus.processing);
                listOrderingProduct.add(orderingProduct);
              }

              orderModel.Order order = orderModel.Order(
                orderingProductsID: listOrderingProduct,
                totalCost: totalCost,
                userID: user!.id,
                totalProduct: listOrderingProduct.length,
              );
              checkoutProvider.setOrder(order);

              checkoutProvider.setListProductInCartID(listProductInCartID);
              await getListVoucherOfAdminBeforeCheckout(
                  voucherForUserProvider, user.id!);
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => CheckOut(uid: user.id!),
              ));
            },
            child: Text(
              LangText(context: context).getLocal()!.checkout_ucf,
              style: TextStyle(color: MyTheme.accent_color),
            )),
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
      // height: MediaQuery.of(context).size.height * 0.14,
      margin: EdgeInsets.symmetric(horizontal: 15.w),
      padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.h),
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
              shippingLabel:
                  "${LangText(context: context).getLocal()!.item_number} ${selectedProduct.length}",
              priceLabel: "${provider.totalCost} VND",
            ),
          ),
          SizedBox(height: 8.h),
          Consumer<CartViewModel>(
            builder: (context, value, child) => _buildShipping(
              context,
              shippingLabel: LangText(context: context).getLocal()!.saving_ucf,
              priceLabel: "${provider.savingCost}",
            ),
          ),
          // SizedBox(height: 10),
          const Divider(),
          SizedBox(height: 6.h),
          Consumer<CartViewModel>(
            builder: (context, value, child) => _buildShipping(
              context,
              shippingLabel: LangText(context: context).getLocal()!.real_price,
              priceLabel: "${provider.totalCost - provider.savingCost}",
            ),
          ),
          SizedBox(height: 6.h),
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
          if (snapshot.connectionState == ConnectionState.waiting) {
            return ListView.separated(
                itemBuilder: (context, index) => ShimmerHelper()
                    .buildBasicShimmer(
                        height: MediaQuery.of(context).size.height * 0.1,
                        width: MediaQuery.of(context).size.width * 0.9),
                separatorBuilder: (context, index) => SizedBox(
                      height: 10.h,
                    ),
                itemCount: 8);
          } else {
            if (snapshot.data != null) {
              final cart = snapshot.data;
              if (cart!.productInCarts != null) {
                return ProductInCartDetails(list: cart.productInCarts);
              } else {
                return Container(
                  height: size.height * 0.5,
                  child: Center(
                    child:
                        Text(LangText(context: context).getLocal()!.no_product),
                  ),
                );
              }
            } else {
              return Container(
                height: size.height * 0.5,
                child: Center(
                  child:
                      Text(LangText(context: context).getLocal()!.no_product),
                ),
              );
            }
          }
        },
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
        padding: EdgeInsets.symmetric(horizontal: 8.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: size.height * 0.06,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 10.w,
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
                  SizedBox(
                    width: 10.w,
                  ),
                  Text(LangText(context: context).getLocal()!.select_all)
                ],
              ),
            ),
            Expanded(
              child: ListView.separated(
                physics: const BouncingScrollPhysics(),
                shrinkWrap: true,
                separatorBuilder: (
                  context,
                  index,
                ) {
                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: 3.h),
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
