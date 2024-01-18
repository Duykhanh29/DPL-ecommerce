import 'package:dpl_ecommerce/const/app_theme.dart';
import 'package:dpl_ecommerce/customs/custom_app_bar.dart';
import 'package:dpl_ecommerce/utils/lang/lang_text.dart';
import 'package:dpl_ecommerce/view_model/seller/shop_view_model.dart';
import 'package:dpl_ecommerce/views/seller/screens/shop_setting/general_setting.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class SettingSeller extends StatefulWidget {
  const SettingSeller({super.key});

  @override
  State<SettingSeller> createState() => __SettingSellerState();
}

class __SettingSellerState extends State<SettingSeller> {
  @override
  Widget build(BuildContext context) {
    final shopProvider = Provider.of<ShopViewModel>(context);
    final shop = shopProvider.shop;
    return Scaffold(
      appBar: CustomAppBar(
              title: LangText(context: context).getLocal()!.shop_settings_ucf,
              centerTitle: true,
              context: context)
          .show(),
      body: Padding(
        padding: EdgeInsets.all(10.0.h),
        child: Column(
          children: [
            GestureDetector(
                onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => GeneralSetting(shopID: shop!.id!),
                      ),
                    ),
                child: _buildsetting(
                    namest: LangText(context: context)
                        .getLocal()!
                        .general_setting_ucf,
                    iconst: Icons.settings)),
            SizedBox(
              height: 10.h,
            ),
            // _buildsetting(
            //     namest: 'Banner Setting', iconst: CupertinoIcons.wrench),
            SizedBox(
              height: 10.h,
            ),
            // _buildsetting(
            //     namest: 'Social media link', iconst: CupertinoIcons.link),
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
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
        height: 80.h,
        decoration: BoxDecoration(
          color: MyTheme.accent_color,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(children: [
              SizedBox(
                width: 10.h,
              ),
              Icon(
                iconst,
                color: Colors.white,
                size: 40,
              ),
              SizedBox(
                width: 10.h,
              ),
              Text(
                namest,
                style: TextStyle(
                  fontSize: 18.sp,
                  color: Colors.white,
                ),
              )
            ]),
            Icon(
              CupertinoIcons.chevron_compact_right,
              color: Colors.white,
              size: 40.h,
            ),
          ],
        ),
      );
}
