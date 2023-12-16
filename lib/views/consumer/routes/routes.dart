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
import 'package:flutter/cupertino.dart';

class ConsumerRoutes {
  static const String mainView = '/main_view';
  static const String homePage = '/home_page';
  static const String cartPage = '/cart_page';
  static const String chattingPage = '/chatting_page';
  static const String categoryPage = '/category_page';
  static const String changeLanguagePage = '/change_language_page';
  static const String profileSeller = '/profile_seller';
  static const String shopProfile = '/shop_profile';
  static const String filterPage = '/filter_page';
  static const String flashSalePage = '/flashsale_page';
  static const String orderPage = '/order_page';
  static const String productDetailPage = '/product_detail_page';

  static const String reviewPage = '/review_page';

  static const String searchPage = '/search_page';
  static const String searchResultPage = '/search_result_page';
  static const String sellerProfilePage = '/seller_profile_page';
  static const String userListVoucher = '/user_list_voucher';

  static const String wishlistPage = '/wishlist_page';

//user settings
  static const String userProfilePage = '/user_profile_page';
  static const String profileSettingPage = '/profile_setting_page';

  // address
  static const String addressScreen = 'address_screen';

  static Map<String, WidgetBuilder> routes = {
    mainView: (context) => MainView(),
    homePage: (context) => HomePage(),
    cartPage: (context) => CartPage(),
    addressScreen: (context) => AddressScreen(),
    // chattingPage:(context) => ChattingPage(chat: chat),
    categoryPage: (context) => CategoryPage(),
    orderPage: (context) => OrderPage(),
    // profileSeller: (context) => ProfileSeller(),
    // shopProfile:(context) => ShopProfile(shop: shop)
    // filterPage: (context) => FilterPage(),
    // flashSalePage:(context) => FlashDealList(flashSale: flashSale)

    // productDetailPage:(context) => ProductDetailsPage(product: product)
    // user settings
    changeLanguagePage: (context) => LanguagePage(),
    profileSettingPage: (context) => ProfileSettingScreen(),
    userProfilePage: (context) => UserProfilePage(),
    // reviewPage: (context) => ReviewPage(list: list)
    searchPage: (context) => SearchScreen(),
    userListVoucher: (context) => UserListVoucher(),
    // wishlistPage: (context) => WishlistPage(),
    searchResultPage: (context) => SearchFilterScreen(),
  };
}
