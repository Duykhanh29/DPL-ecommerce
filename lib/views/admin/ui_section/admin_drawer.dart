import 'package:dpl_ecommerce/const/app_theme.dart';
import 'package:dpl_ecommerce/utils/lang/lang_text.dart';
import 'package:dpl_ecommerce/view_model/user_view_model.dart';
import 'package:dpl_ecommerce/views/admin/screens/admin_dashboard.dart';
import 'package:dpl_ecommerce/views/admin/screens/category/category_screen.dart';
import 'package:dpl_ecommerce/views/admin/screens/delivery/delivery_screen.dart';
import 'package:dpl_ecommerce/views/admin/screens/manage_seller/seller_screen.dart';
import 'package:dpl_ecommerce/views/admin/screens/voucher/voucher_admin.dart';
import 'package:dpl_ecommerce/views/consumer/screens/change_language_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class AdminDrawer extends StatelessWidget {
  const AdminDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserViewModel>(context);
    final user = userProvider.currentUser;
    return Drawer(
      // backgroundColor: Colors.red,
      width: MediaQuery.of(context).size.width * 0.7,
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Consumer<UserViewModel>(
              builder: (context, value, child) => UserAccountsDrawerHeader(
                decoration: BoxDecoration(color: MyTheme.accent_color_2),
                accountName: Text(value.currentUser!.firstName!),
                accountEmail: Text(value.currentUser!.email!),
                currentAccountPicture: CircleAvatar(
                  backgroundColor: MyTheme.red,
                  radius: 60.r,
                  child: CircleAvatar(
                    radius: 45.r,
                    backgroundImage: NetworkImage(value.currentUser!.avatar!),
                  ),
                ),
              ),
            ),
            const Divider(),
            // ListTile(
            //   leading: const Icon(Icons.dashboard_rounded),
            //   title: Text(LangText(context: context).getLocal()!.dashboard_ucf),
            //   onTap: () {
            //     Navigator.of(context).push(MaterialPageRoute(
            //       builder: (context) {
            //         return DashAdmin();
            //       },
            //     ));
            //   },
            // ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.store),
              title: Text(LangText(context: context).getLocal()!.shop_ucf),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) {
                    return SellerScreen(
                      isDrawer: true,
                    );
                  },
                ));
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.category_rounded),
              title: Text(LangText(context: context).getLocal()!.category_ucf),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) {
                    return CategoryListScreen(
                      isDrawer: true,
                    );
                  },
                ));
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(CupertinoIcons.tickets),
              title: Text(LangText(context: context).getLocal()!.voucher_ucf),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) {
                    return VoucherAdmin(
                      isDrawer: true,
                    );
                  },
                ));
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.local_shipping_rounded),
              title: Text(
                  LangText(context: context).getLocal()!.delivery_service_ucf),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) {
                    return DeliverListScreen(
                      isDrawer: true,
                    );
                  },
                ));
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.language_rounded),
              title: Text(LangText(context: context).getLocal()!.language_ucf),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) {
                    return LanguagePage();
                  },
                ));
              },
            ),
          ],
        ),
      ),
    );
  }
}
