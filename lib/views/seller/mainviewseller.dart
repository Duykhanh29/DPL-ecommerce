import 'package:dpl_ecommerce/utils/lang/lang_text.dart';
import 'package:dpl_ecommerce/views/seller/screens/dashboard.dart';
import 'package:dpl_ecommerce/views/seller/screens/product2/product_app.dart';
import 'package:dpl_ecommerce/views/seller/screens/seller_profile.dart';
import 'package:dpl_ecommerce/views/seller/screens/voucher/voucher_app.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MainViewSeller extends StatefulWidget {
  const MainViewSeller({super.key});

  @override
  State<MainViewSeller> createState() => _MainViewState();
}

class _MainViewState extends State<MainViewSeller> {
  List<Widget> pages = [
    Dashboard(),
    ProductsApp(),
    SellerProfilePage(),
  ];
  int indexPage = 0;

  @override
  Widget build(BuildContext context) {
    return
        // ChangeNotifierProvider(
        //   create: (context) => CartViewModel(),
        //   child:
        Scaffold(
      //drawer: ConsumerDrawer(),
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: true,
        showUnselectedLabels: true,
        onTap: (value) {
          setState(() {
            indexPage = value;
          });
        },
        unselectedItemColor: Colors.black26,
        useLegacyColorScheme: false,
        backgroundColor: Color.fromARGB(255, 98, 170, 212),
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.dashboard_outlined),
              label: AppLocalizations.of(context)!.dashboard_ucf
              //     .search_anything,,
              ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.cube_box),
            label: LangText(context: context).getLocal()!.products_ucf,
          ),
          // BottomNavigationBarItem(
          //   icon: Icon(CupertinoIcons.square_list),
          //   label: "Order",
          // ),
          BottomNavigationBarItem(
            icon: Icon(
              CupertinoIcons.person_alt_circle,
            ),
            label: LangText(context: context).getLocal()!.profile_ucf,
          ),
        ],
        currentIndex: indexPage,
        iconSize: 25,
        selectedFontSize: 8,
        selectedItemColor: Colors.blue.shade400,
      ),
      body: IndexedStack(
        index: indexPage,
        children: pages,
      ),
      // ),
    );
  }
}
