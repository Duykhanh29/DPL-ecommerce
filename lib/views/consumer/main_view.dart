import 'package:dpl_ecommerce/const/app_theme.dart';
import 'package:dpl_ecommerce/models/voucher_for_user.dart';
import 'package:dpl_ecommerce/repositories/voucher_for_user_repo.dart';
import 'package:dpl_ecommerce/utils/lang/lang_text.dart';
import 'package:dpl_ecommerce/view_model/auth_view_model.dart';
import 'package:dpl_ecommerce/view_model/consumer/cart_view_model.dart';
import 'package:dpl_ecommerce/view_model/consumer/voucher_for_user_view_model.dart';
import 'package:dpl_ecommerce/views/consumer/screens/cart_page.dart';
import 'package:dpl_ecommerce/views/consumer/screens/category_page.dart';
import 'package:dpl_ecommerce/views/consumer/screens/home_page.dart';
import 'package:dpl_ecommerce/views/general_views/login_screen.dart';
import 'package:dpl_ecommerce/views/consumer/screens/order_page.dart';
import 'package:dpl_ecommerce/views/consumer/screens/order_screen.dart';
import 'package:dpl_ecommerce/views/consumer/screens/user_profile_page.dart';
import 'package:dpl_ecommerce/views/consumer/ui_section/consumer_drawer.dart';

import 'package:dpl_ecommerce/views/seller/screens/product/product_app.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dpl_ecommerce/views/consumer/screens/add_address.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  VoucherForUserRepo voucherForUserRepo = VoucherForUserRepo();

  List<Widget> pages = [
    HomePage(),
    CategoryPage(),
    // OrderPage(),
    OrderScreen(),
    UserProfilePage(),
  ];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final auth = Provider.of<AuthViewModel>(context, listen: false);
    getVoucherForUser(auth.currentUser!.id!).then((value) {
      Provider.of<VoucherForUserViewModel>(context, listen: false)
          .setVoucherForUser(value!);
    });
  }

  Future<VoucherForUser?> getVoucherForUser(String uid) async {
    return await voucherForUserRepo.getVoucher(uid);
  }

  int indexPage = 0;
  @override
  Widget build(BuildContext context) {
    return
        // ChangeNotifierProvider(
        //   create: (context) => CartViewModel(),
        //   child:
        Scaffold(
      // drawer: ConsumerDrawer(),
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
        // backgroundColor: Color.fromARGB(255, 98, 170, 212),
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              color: indexPage == 0 ? MyTheme.accent_color : MyTheme.grey_153,
            ),
            label: LangText(context: context).getLocal()!.home_ucf,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.category_sharp,
                color:
                    indexPage == 1 ? MyTheme.accent_color : MyTheme.grey_153),
            label: LangText(context: context).getLocal()!.categories_ucf,
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.cart,
                color:
                    indexPage == 2 ? MyTheme.accent_color : MyTheme.grey_153),
            label: LangText(context: context).getLocal()!.orders_ucf,
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.person_alt_circle,
                color:
                    indexPage == 3 ? MyTheme.accent_color : MyTheme.grey_153),
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
