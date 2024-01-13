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
import 'package:dpl_ecommerce/views/seller/mainviewseller.dart';
import 'package:dpl_ecommerce/views/seller/screens/address_seller_screen.dart';
import 'package:dpl_ecommerce/views/seller/screens/chatlist.dart';
import 'package:dpl_ecommerce/views/seller/screens/dashboard.dart';
import 'package:dpl_ecommerce/views/seller/screens/payhistory.dart';
import 'package:dpl_ecommerce/views/seller/screens/product/add_product_screen.dart';
import 'package:dpl_ecommerce/views/seller/screens/product/edit_product.dart';
import 'package:dpl_ecommerce/views/seller/screens/product/product_app.dart';
import 'package:dpl_ecommerce/views/seller/screens/product2/product_app.dart';
import 'package:dpl_ecommerce/views/seller/screens/seller_setting_page.dart';
import 'package:dpl_ecommerce/views/seller/screens/shop_setting/general_setting.dart';
import 'package:dpl_ecommerce/views/seller/screens/shop_setting/setting.dart';
import 'package:dpl_ecommerce/views/seller/screens/verification.dart';
import 'package:dpl_ecommerce/views/seller/screens/voucher/voucher_app.dart';
import 'package:flutter/cupertino.dart';

class SellerRoutes {
  static const String initialSellerPage = '/initial_seller_page';
  static const String productsScreen = '/products_screen';
  static const String addProduct = '/add_product';
  static const String editProduct = '/edit_product';
  static const String dashboard = '/dashboard';
  static const String profile = '/profile';
  static const String changeLanguagePage = '/change_language_page';
  static const String chatList = '/chat_list';
  static const String voucherScreen = '/voucher_screen';
//seller settings
  static const String sellerProfilePage = '/seller_profile_page';
  static const String profileSettingSellerPage = '/profile_setting_seller_page';
  static const changeLanguage = '/change_language';
  static const addressSellerPage = '/address_seller_page';
  static const paymentHistory = '/payment_history';
  static const String verification = '/verification';
  static const String vouchersPage = '/vouchers_page';
  static const String productsPage = '/products_page';
  // address
  static const String addressScreen = '/address_screen';
  static const String generalSetting = '/general_setting';
  static const String setting_page = '/setting_page';
  static Map<String, WidgetBuilder> routes = {
    productsScreen: (context) => ProductsApp(),
    voucherScreen: (context) => VoucherApp(),
    // addProduct: (context) => AddProductScreen(
    //       products: [],
    //       onProductAdded: (p0) {},
    //     ),
    // editProduct: (context) => EditProductScreen(
    //     product: Product(), onProductUpdated: (p0) {}, products: []),
    initialSellerPage: (context) => MainViewSeller(),
    changeLanguagePage: (context) => LanguagePage(),
    profileSettingSellerPage: (context) => ProfileSettingSellerScreen(),
    sellerProfilePage: (context) => UserProfilePage(),
    verification: (context) => Verification(),
    dashboard: (context) => Dashboard(),
    chatList: (context) => ChatList(),
    changeLanguage: (context) => LanguagePage(),
    addressSellerPage: (context) => AddressSellerScreen(),
    paymentHistory: (context) => PayHistory(),
    vouchersPage: (context) => VoucherApp(),
    productsPage: (context) => ProductsApp(),
    // generalSetting: (context) => GeneralSetting(),
    setting_page: (context) => SettingSeller()
  };
}
