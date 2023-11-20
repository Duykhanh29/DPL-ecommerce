import 'package:dpl_ecommerce/const/app_decoration.dart';
import 'package:dpl_ecommerce/const/app_theme.dart';
import 'package:dpl_ecommerce/customs/custom_array_back_widget.dart';
import 'package:dpl_ecommerce/customs/custom_button_style.dart';
import 'package:dpl_ecommerce/customs/custom_elevate_button.dart';
import 'package:dpl_ecommerce/customs/custom_text_form_field.dart';
import 'package:dpl_ecommerce/customs/custom_text_style.dart';
import 'package:dpl_ecommerce/models/cart.dart';
import 'package:dpl_ecommerce/models/product_in_cart_model.dart';
import 'package:dpl_ecommerce/repositories/product_in_cart_repo.dart';
import 'package:dpl_ecommerce/utils/common/common_methods.dart';
import 'package:dpl_ecommerce/view_model/consumer/cart_view_model.dart';
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
  TextEditingController cuponCodeController = TextEditingController();

  List<ProductInCartModel> selecttedProducts = [];

  int totalPrice = 0;

  int savingPrice = 0;

  int realPrice = 0;

  void calculatePrices() {
    for (var product in selecttedProducts) {
      setState(() {
        totalPrice += product.cost;
        // need to fetch voucherID to get discount
        savingPrice += 5000;
      });
    }
    setState(() {
      realPrice = totalPrice - savingPrice;
    });
  }

  // final Cart cart = Cart(productInCarts: [
  //   ProductInCartModel(
  //       cost: 240000,
  //       quantity: 2,
  //       color: "Red",
  //       currencyID: "currencyID01",
  //       id: "productInCartModelID01",
  //       productID: "productID01",
  //       productImage:
  //           "https://static.addtoany.com/images/dracaena-cinnabari.jpg",
  //       productName: "Sadfsf",
  //       size: "L",
  //       type: "Wooden",
  //       userID: "userID01"),
  //   ProductInCartModel(
  //       cost: 240000,
  //       quantity: 2,
  //       color: "Red",
  //       currencyID: "currencyID01",
  //       id: "productInCartModelID01",
  //       productID: "productID01",
  //       productImage:
  //           "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTq29z2MgTbf2LERHqbHkT1KGAv1WwxXyYSnw&usqp=CAU",
  //       productName: "Sadfsf",
  //       size: "L",
  //       type: "Wooden",
  //       userID: "userID01"),
  //   ProductInCartModel(
  //       cost: 180000,
  //       quantity: 1,
  //       color: "Blue",
  //       currencyID: "currencyID02",
  //       id: "productInCartModelID02",
  //       productID: "productID02",
  //       productImage:
  //           "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR3UTIruXjQnL8lIc25soS3jNKnW-zLMpoP6A&usqp=CAU",
  //       productName: "Rose",
  //       size: "M",
  //       type: "Flower",
  //       userID: "userID02"),
  //   ProductInCartModel(
  //       cost: 120000,
  //       quantity: 3,
  //       color: "Green",
  //       currencyID: "currencyID03",
  //       id: "productInCartModelID03",
  //       productID: "productID03",
  //       productImage:
  //           "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS2T2ayBMxgRLsBOS5MOQ5VFcLET7pndXGPIA&usqp=CAU",
  //       productName: "Cactus",
  //       size: "S",
  //       type: "Spiky",
  //       userID: "userID03"),
  //   ProductInCartModel(
  //       cost: 350000,
  //       quantity: 1,
  //       color: "Yellow",
  //       currencyID: "currencyID04",
  //       id: "productInCartModelID04",
  //       productID: "productID04",
  //       productImage:
  //           "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTrKHPsvNDJHY9tWpkHrfkfo8Dkf0LvZU3Hdg&usqp=CAUg",
  //       productName: "Sunflower",
  //       size: "XL",
  //       type: "Blooming",
  //       userID: "userID04"),
  //   ProductInCartModel(
  //       cost: 50000,
  //       quantity: 5,
  //       color: "Purple",
  //       currencyID: "currencyID05",
  //       id: "productInCartModelID05",
  //       productID: "productID05",
  //       productImage:
  //           "https://media.macphun.com/img/uploads/customer/how-to/570/15550740495cb08c019f4a94.42766927.jpg?q=85&w=1340",
  //       productName: "Lavender",
  //       size: "M",
  //       type: "Aromatic",
  //       userID: "userID05"),
  //   ProductInCartModel(
  //       cost: 280000,
  //       quantity: 2,
  //       color: "Orange",
  //       currencyID: "currencyID06",
  //       id: "productInCartModelID06",
  //       productID: "productID06",
  //       productImage:
  //           "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS_ums6Rp3LJDJZ4ClL81ZAa1x7Jos8YVCdKg&usqp=CAU",
  //       productName: "Orange",
  //       size: "L",
  //       type: "Juicy",
  //       userID: "userID06"),
  //   ProductInCartModel(
  //       cost: 75000,
  //       quantity: 1,
  //       color: "White",
  //       currencyID: "currencyID07",
  //       id: "productInCartModelID07",
  //       productID: "productID07",
  //       productImage:
  //           "https://i.insider.com/60638bd66183e1001981966a?width=1136&format=jpeg",
  //       productName: "Lily",
  //       size: "S",
  //       type: "Elegant",
  //       userID: "userID07"),
  //   ProductInCartModel(
  //       cost: 200000,
  //       quantity: 4,
  //       color: "Brown",
  //       currencyID: "currencyID08",
  //       id: "productInCartModelID08",
  //       productID: "productID08",
  //       productImage:
  //           "https://media.istockphoto.com/id/1352890602/photo/close-up-of-a-businessman-sitting-at-his-desk-and-using-a-navigation-app-on-his-cell-phone.jpg?s=612x612&w=0&k=20&c=yHWBg9Rv8UwKq78iRN34YRJRjI4XCDr-1saebzRf0pM=",
  //       productName: "Bonsai",
  //       size: "M",
  //       type: "Miniature",
  //       userID: "userID08"),
  //   ProductInCartModel(
  //       cost: 300000,
  //       quantity: 3,
  //       color: "Pink",
  //       currencyID: "currencyID09",
  //       id: "productInCartModelID09",
  //       productID: "productID09",
  //       productImage:
  //           "https://media.istockphoto.com/id/1058305310/photo/connected-to-all-that-she-needs.jpg?s=612x612&w=0&k=20&c=F0JYRwD0TImf5lqVZkMDqckH0Cx_l9WxxEBfVaHSppg=",
  //       productName: "Cherry Blossom",
  //       size: "L",
  //       type: "Delicate",
  //       userID: "userID09"),
  //   ProductInCartModel(
  //       cost: 180000,
  //       quantity: 2,
  //       color: "Gray",
  //       currencyID: "currencyID10",
  //       id: "productInCartModelID10",
  //       productID: "productID10",
  //       productImage:
  //           "https://www.freecodecamp.org/news/content/images/2022/04/derick-mckinney-oARTWhz1ACc-unsplash.jpg",
  //       productName: "Succulent",
  //       size: "S",
  //       type: "Drought-resistant",
  //       userID: "userID10"),
  //   ProductInCartModel(
  //       cost: 120000,
  //       quantity: 1,
  //       color: "Black",
  //       currencyID: "currencyID11",
  //       id: "productInCartModelID11",
  //       productID: "productID11",
  //       productImage:
  //           "https://images.pexels.com/photos/4603884/pexels-photo-4603884.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
  //       productName: "Tulip",
  //       size: "XL",
  //       type: "Vibrant",
  //       userID: "userID11"),
  // ], savingCost: 25000, totalCost: 250000, userID: "userID01");

  @override
  Widget build(BuildContext context) {
    // mediaQueryData = MediaQuery.of(context);
    final provider = Provider.of<CartViewModel>(context, listen: true);
    final cart = provider.cart;
    final size = MediaQuery.of(context).size;
    // final selectedProduct = provider.list;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        // leading: IconButton(
        //     onPressed: () {
        //       Navigator.of(context).pop();
        //     },
        //     icon: const Icon(Icons.arrow_back)),
        title: Text("Your cart"),
      ),
      body: Container(
        // color: Colors.green,
        width: double.maxFinite,
        // decoration: AppDecoration.fillOnPrimaryContainer,
        child: Column(
          children: [
            SizedBox(height: 16),
            ProductInCartDetails(list: cart.productInCarts!),
            // SizedBox(height: 32),
            // _buildCuponForm(context), // replace by other CuponWidget
            SizedBox(height: 10),
            _buildTotalPrice1(context, cart),
            // SizedBox(height: 16),

            Spacer(),
            Container(
              height: size.height * 0.06,
              width: size.width * 0.9,
              child: ElevatedButton(
                  style: ButtonStyle(
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)))),
                  onPressed: () {},
                  child: const Text("Check out")),
            ),
            SizedBox(height: 7.h),
          ],
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildTotalPrice1(BuildContext context, Cart cart) {
    final provider = Provider.of<CartViewModel>(context, listen: false);

    final selectedProduct = provider.list;
    return Container(
      height: MediaQuery.of(context).size.height * 0.14,
      margin: EdgeInsets.symmetric(horizontal: 15),
      padding: EdgeInsets.all(5),
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
          SizedBox(height: 8),
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
          padding: EdgeInsets.only(top: 1),
          child: Text(
            shippingLabel,
            style: theme.textTheme.bodySmall!.copyWith(
              color: appTheme.blueGray300,
            ),
          ),
        ),
        Text(
          priceLabel,
          style: CustomTextStyles.bodyMediumGray600.copyWith(
            color: theme.colorScheme.onPrimary.withOpacity(1),
          ),
        ),
      ],
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
              return Checkbox(
                value: provider.list.contains(widget.productInCartModel),
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
        const SizedBox(
          width: 10,
        ),
        ProductCartItem(productInCartModel: widget.productInCartModel),
      ],
    );
  }
}
