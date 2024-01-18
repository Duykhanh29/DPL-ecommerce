import 'package:dpl_ecommerce/views/admin/admin_main_view.dart';
import 'package:dpl_ecommerce/views/admin/screens/admin_dashboard.dart';
import 'package:dpl_ecommerce/views/admin/screens/admin_profile_page.dart';
import 'package:dpl_ecommerce/views/admin/screens/admin_setting_page.dart';
import 'package:dpl_ecommerce/views/admin/screens/category/category_screen.dart';
import 'package:dpl_ecommerce/views/admin/screens/delivery/delivery_screen.dart';
import 'package:dpl_ecommerce/views/admin/screens/manage_seller/seller_screen.dart';
import 'package:dpl_ecommerce/views/admin/screens/voucher/voucher_admin.dart';

import 'package:dpl_ecommerce/views/consumer/screens/change_language_page.dart';

import 'package:flutter/cupertino.dart';

class AdminRoutes {
  static const String mainView = '/main_view';
  static const String changeLanguagePage = '/change_language_page';
  static const String dashboard = '/dashboard';
  static const String categoryScreen = '/category_screen';
  static const String deliveryServiceScreen = '/delivery_service_screen';
  static const String voucherScreen = '/voucher_screen';
  static const String sellerScreen = '/seller_screen';
//user settings
  static const String userProfilePage = '/user_profile_page';
  static const String profileSettingPage = '/profile_setting_page';

  static Map<String, WidgetBuilder> routes = {
    mainView: (context) => AdminMainView(),
    changeLanguagePage: (context) => LanguagePage(),
    profileSettingPage: (context) => AdminSettingProfilePage(),
    userProfilePage: (context) => AdminProfilePage(),
    sellerScreen: (context) => SellerScreen(),
    voucherScreen: (context) => VoucherAdmin(),
    deliveryServiceScreen: (context) => DeliverListScreen(),
    categoryScreen: (context) => CategoryListScreen(),
    dashboard: (context) => DashAdmin(),
  };
}
