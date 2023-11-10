import 'package:dpl_ecommerce/view_model/consumer/cart_view_model.dart';
import 'package:dpl_ecommerce/views/consumer/screens/cart_page.dart';
import 'package:dpl_ecommerce/views/consumer/screens/category_page.dart';
import 'package:dpl_ecommerce/views/consumer/screens/home_page.dart';
import 'package:dpl_ecommerce/views/consumer/screens/order_page.dart';
import 'package:dpl_ecommerce/views/consumer/screens/profile_page.dart';
import 'package:dpl_ecommerce/views/consumer/ui_section/consumer_drawer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  List<Widget> pages = [
    HomePage(),
    CartPage(),
    OrderPage(),
    ProfilePage(),
  ];
  int indexPage = 0;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CartViewModel(),
      child: Scaffold(
        drawer: ConsumerDrawer(),
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
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.category_sharp),
              label: "Category",
            ),
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.cart),
              label: "Order",
            ),
            BottomNavigationBarItem(
              icon: Icon(
                CupertinoIcons.person_alt_circle,
              ),
              label: "Profile",
            ),
          ],
          currentIndex: indexPage,
          iconSize: 25,
          selectedFontSize: 8,
          selectedItemColor: Colors.orangeAccent.shade200,
        ),
        body: IndexedStack(
          index: indexPage,
          children: pages,
        ),
      ),
    );
  }
}
