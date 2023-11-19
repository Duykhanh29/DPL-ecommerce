import 'package:dpl_ecommerce/views/consumer/screens/cart_page.dart';
import 'package:dpl_ecommerce/views/consumer/screens/home_page.dart';
import 'package:flutter/cupertino.dart';

class ConsumerRoutes {
  static const String homePage = '/home_page';
  static const String cartPage = '/cart_page';
  static const String chattingPage = '/chatting_page';
  static const String categoryPage = '/category_page';
  static const String changeLanguagePage = '/change_language_page';
  static const String detailSellerProfile = '/detail_seller_profile';
  static const String filterPage = '/filter_page';
  static const String flashSalePage = '/flashsale_page';
  static const String orderPage = '/order_page';
  static const String productDetailPage = '/product_detail_page';
  static const String profileSettingPage = '/profile_setting_page';
  static const String reviewPage = '/review_page';

  static const String searchPage = '/search_page';
  static const String searchResultPage = '/search_result_page';
  static const String sellerProfilePage = '/seller_profile_page';
  static const String userListVoucher = '/user_list_voucher';
  static const String userProfilePage = '/user_profile_page';
  static const String wishlistPage = '/wishlist_page';

  static Map<String, WidgetBuilder> routes = {
    homePage: (context) => HomePage(),
    cartPage: (context) => CartPage(),
  };
}
