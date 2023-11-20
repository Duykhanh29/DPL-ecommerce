import 'package:dpl_ecommerce/views/consumer/screens/cart_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;

class CustomBadgeCart extends StatelessWidget {
  CustomBadgeCart({super.key, required this.number});
  int number;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: badges.Badge(
        badgeContent: Text(
          number.toString(),
          style: TextStyle(fontSize: 12, color: Colors.white),
        ),
        child: InkWell(
          child: Icon(
            CupertinoIcons.cart,
            size: 30,
            color: Colors.white,
          ),
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) {
                return CartPage();
              },
            ));
          },
        ),
      ),
    );
  }
}
