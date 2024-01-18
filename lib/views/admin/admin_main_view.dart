import 'package:dpl_ecommerce/const/app_theme.dart';
import 'package:dpl_ecommerce/utils/lang/lang_text.dart';
import 'package:dpl_ecommerce/views/admin/screens/admin_dashboard.dart';
import 'package:dpl_ecommerce/views/admin/screens/admin_profile_page.dart';
import 'package:dpl_ecommerce/views/admin/screens/category/category_screen.dart';
import 'package:dpl_ecommerce/views/admin/screens/delivery/delivery_screen.dart';
import 'package:dpl_ecommerce/views/admin/screens/manage_seller/seller_screen.dart';
import 'package:dpl_ecommerce/views/admin/screens/voucher/voucher_admin.dart';
import 'package:dpl_ecommerce/views/admin/ui_section/admin_drawer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AdminMainView extends StatefulWidget {
  AdminMainView({super.key});

  @override
  State<AdminMainView> createState() => _AdminMainViewState();
}

class _AdminMainViewState extends State<AdminMainView> {
  List<Widget> pages = [
    DashAdmin(),
    SellerScreen(),
    // VoucherAdmin(),
    CategoryListScreen(),
    // DeliverListScreen(),
    AdminProfilePage()
  ];

  int indexPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //drawer: ConsumerDrawer(),
      drawer: AdminDrawer(),
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: true,
        showUnselectedLabels: true,
        onTap: (value) {
          setState(() {
            indexPage = value;
          });
        },
        unselectedItemColor: MyTheme.black,
        useLegacyColorScheme: false,
        backgroundColor: Color.fromARGB(255, 98, 170, 212),
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.dashboard_rounded,
              color: MyTheme.accent_color,
            ),
            label: LangText(context: context).getLocal()!.dashboard_ucf,
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.manage_accounts_rounded,
              color: MyTheme.accent_color,
            ),
            label: LangText(context: context).getLocal()!.shop_ucf,
          ),
          // BottomNavigationBarItem(
          //   icon: const Icon(CupertinoIcons.tickets),
          //   label: LangText(context: context).getLocal()!.voucher_ucf,
          // ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.category_rounded,
              color: MyTheme.accent_color,
            ),
            label: LangText(context: context).getLocal()!.category_ucf,
          ),
          // BottomNavigationBarItem(
          //   icon: const Icon(
          //     Icons.local_shipping_rounded,
          //   ),
          //   label: LangText(context: context).getLocal()!.delivery_service_ucf,
          // ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person_2_rounded,
              color: MyTheme.accent_color,
            ),
            label: LangText(context: context).getLocal()!.profile_ucf,
          ),
        ],
        currentIndex: indexPage,
        iconSize: 25,
        selectedFontSize: 8,
        selectedItemColor: MyTheme.accent_color,
      ),
      body: IndexedStack(
        index: indexPage,
        children: pages,
      ),
      // ),
    );
  }
}
