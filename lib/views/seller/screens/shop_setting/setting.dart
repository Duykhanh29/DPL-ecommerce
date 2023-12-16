import 'package:dpl_ecommerce/views/seller/screens/shop_setting/general_setting.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SettingSeller extends StatefulWidget {
  const SettingSeller({super.key});

  @override
  State<SettingSeller> createState() => __SettingSellerState();
}

class __SettingSellerState extends State<SettingSeller> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Shop Setting'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            GestureDetector(
                onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => GeneralSetting(),
                      ),
                    ),
                child: _buildsetting(
                    namest: 'General Setting', iconst: Icons.settings)),
            SizedBox(
              height: 10,
            ),
            _buildsetting(
                namest: 'Banner Setting', iconst: CupertinoIcons.wrench),
            SizedBox(
              height: 10,
            ),
            _buildsetting(
                namest: 'Social media link', iconst: CupertinoIcons.link),
          ],
        ),
      ),
    );
  }

  Widget _buildsetting({
    required String namest,
    required IconData iconst,
  }) =>
      Container(
        height: 80,
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(children: [
              SizedBox(
                width: 10,
              ),
              Icon(
                iconst,
                color: Colors.white,
                size: 40,
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                namest,
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                ),
              )
            ]),
            Icon(
              CupertinoIcons.chevron_compact_right,
              color: Colors.white,
              size: 40,
            ),
          ],
        ),
      );
}
