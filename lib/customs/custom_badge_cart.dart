import 'package:dpl_ecommerce/views/consumer/screens/cart_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomBadgeCart extends StatelessWidget {
  CustomBadgeCart({super.key, required this.number});
  int number;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: number > 0
          ? badges.Badge(
              badgeContent: Text(
                number.toString(),
                style: TextStyle(fontSize: 12.sp, color: Colors.white),
              ),
              child: InkWell(
                child: Icon(
                  CupertinoIcons.cart,
                  size: 30.h,
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
            )
          : InkWell(
              child: Icon(
                CupertinoIcons.cart,
                size: 30.h,
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
    );
  }
}
