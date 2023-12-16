import 'package:dpl_ecommerce/models/product.dart';
import 'package:dpl_ecommerce/views/consumer/main_view.dart';
import 'package:dpl_ecommerce/views/consumer/screens/address_screen.dart';
import 'package:dpl_ecommerce/views/consumer/screens/cart_page.dart';
import 'package:dpl_ecommerce/views/consumer/screens/category_page.dart';
import 'package:dpl_ecommerce/views/consumer/screens/change_language_page.dart';
import 'package:dpl_ecommerce/views/consumer/screens/chatting_page.dart';
import 'package:dpl_ecommerce/views/consumer/screens/detail_seller_profile.dart';
import 'package:dpl_ecommerce/views/consumer/screens/filter_page.dart';
import 'package:dpl_ecommerce/views/consumer/screens/flash_sale_page.dart';
import 'package:dpl_ecommerce/views/consumer/screens/home_page.dart';
import 'package:dpl_ecommerce/views/consumer/screens/order_page.dart';
import 'package:dpl_ecommerce/views/consumer/screens/product_detail_page.dart';
import 'package:dpl_ecommerce/views/consumer/screens/profile_setting_page.dart';
import 'package:dpl_ecommerce/views/consumer/screens/review_view_page.dart';
import 'package:dpl_ecommerce/views/consumer/screens/search_page.dart';
import 'package:dpl_ecommerce/views/consumer/screens/search_result_page.dart';
import 'package:dpl_ecommerce/views/consumer/screens/shop_profile.dart';
import 'package:dpl_ecommerce/views/consumer/screens/user_list_voucher.dart';
import 'package:dpl_ecommerce/views/consumer/screens/user_profile_page.dart';
import 'package:dpl_ecommerce/views/consumer/screens/wishlist_page.dart';
import 'package:dpl_ecommerce/views/seller/screens/product/add_product_screen.dart';
import 'package:dpl_ecommerce/views/seller/screens/product/edit_product.dart';
import 'package:dpl_ecommerce/views/seller/screens/product/product_app.dart';
import 'package:flutter/cupertino.dart';

class SellerRoutes {
  static const String productsScreen = '/products_screen';
  static const String addProduct = '/add_product';
  static const String editProduct = '/edit_product';
  static const String dashboard = '/dashboard';
  static const String profile = '/profile';
  static const String changeLanguagePage = '/change_language_page';

//user settings
  static const String userProfilePage = '/user_profile_page';
  static const String profileSettingPage = '/profile_setting_page';

  // address
  static const String addressScreen = 'address_screen';

  static Map<String, WidgetBuilder> routes = {
    // productsScreen: (context) => ProductsApp(products: []),
    // addProduct: (context) => AddProductScreen(
    //       products: [],
    //       onProductAdded: (p0) {},
    //     ),
    // editProduct: (context) => EditProductScreen(
    //     product: Product(), onProductUpdated: (p0) {}, products: []),
    changeLanguagePage: (context) => LanguagePage(),
    profileSettingPage: (context) => ProfileSettingScreen(),
    userProfilePage: (context) => UserProfilePage(),
  };
}
