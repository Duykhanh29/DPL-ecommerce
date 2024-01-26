// products_app.dart

import 'package:dpl_ecommerce/const/app_theme.dart';
import 'package:dpl_ecommerce/helpers/toast_helper.dart';
import 'package:dpl_ecommerce/models/product.dart';
import 'package:dpl_ecommerce/utils/lang/lang_text.dart';
import 'package:dpl_ecommerce/view_model/seller/shop_view_model.dart';
import 'package:dpl_ecommerce/views/seller/screens/product2/display_product_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import 'add_product_screen.dart';

class ProductsApp extends StatelessWidget {
  showDialog(BuildContext context) {
    ToastHelper.showDialog(
        LangText(context: context).getLocal()!.your_account_is_unverified,
        gravity: ToastGravity.CENTER,
        duration: Toast.LENGTH_LONG);
  }

  @override
  Widget build(BuildContext context) {
    final shopProvider = Provider.of<ShopViewModel>(context);

    final shop = shopProvider.shop;
    final userProvider = Provider.of<ShopViewModel>(context);
    final user = userProvider.currentUser;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyTheme.accent_color,
        centerTitle: true,
        title: Text(
          LangText(context: context).getLocal()!.products_ucf,
          style: TextStyle(color: MyTheme.white),
        ),
        automaticallyImplyLeading: false,
      ),
      body: Consumer<ShopViewModel>(
        builder: (context, value, child) {
          if (value.shop == null) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return DisplayProductsScreen(shopID: shop!.id!
                // products: products,
                // onProductDeleted: _deleteProduct,
                // onProductUpdated: _updateProduct,
                );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: MyTheme.accent_color,
        onPressed: () {
          if (!user!.userInfor!.sellerInfor!.isVerified!) {
            showDialog(context);
          } else {
            _navigateToAddProductScreen(context);
          }
        },
        child: Icon(
          Icons.add,
          color: MyTheme.white,
          size: 20.h,
        ),
      ),
    );
  }

  void _navigateToAddProductScreen(BuildContext context) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddProductScreen(
            // products: products,
            // onProductAdded: _addProduct,
            ),
      ),
    );
  }
}
