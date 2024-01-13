import 'package:dpl_ecommerce/customs/custom_app_bar.dart';
import 'package:dpl_ecommerce/utils/lang/lang_text.dart';
import 'package:dpl_ecommerce/view_model/seller/shop_view_model.dart';
import 'package:dpl_ecommerce/view_model/user_view_model.dart';
import 'package:dpl_ecommerce/views/seller/screens/order/list_order_shop.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrderShopPage extends StatelessWidget {
  const OrderShopPage({super.key});

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserViewModel>(context);
    final shopProvider = Provider.of<ShopViewModel>(context);
    final shop = shopProvider.shop;
    return Scaffold(
      appBar: CustomAppBar(
              isLeading: false,
              centerTitle: true,
              context: context,
              title: LangText(context: context).getLocal()!.orders_ucf)
          .show(),
      body: Consumer<ShopViewModel>(
        builder: (context, value, child) {
          if (value.shop != null) {
            return ListOrderShop(shopID: shop!.id!);
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
