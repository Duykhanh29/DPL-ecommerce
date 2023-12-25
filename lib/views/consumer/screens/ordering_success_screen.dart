import 'package:dpl_ecommerce/const/app_theme.dart';
import 'package:dpl_ecommerce/views/consumer/screens/home_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SuccessScreen extends StatefulWidget {
  const SuccessScreen({super.key});

  @override
  State<SuccessScreen> createState() => _SuccessScreenState();
}

class _SuccessScreenState extends State<SuccessScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          Positioned(
            top: 0,
            child: Image.asset(
              "assets/images/background_2.png",
              fit: BoxFit.fill,
            ),
          ),
          Positioned(
            bottom: 0,
            child: Image.asset(
              "assets/images/background_3.png",
              fit: BoxFit.fill,
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height / 6,
            left: MediaQuery.of(context).size.width / 8 - 10,
            child: Image.asset(
              "assets/images/success.png",
              fit: BoxFit.fill,
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height / 2 + 20,
            left: 0,
            right: 0,
            child: Column(
              children: [
                Text(
                  AppLocalizations.of(context)!.order_success,
                  style: TextStyle(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w700,
                    color: MyTheme.black,
                    decoration: TextDecoration.none,
                  ),
                ),
                SizedBox(
                  height: 50.h,
                ),
                Text(
                  AppLocalizations.of(context)!.placed_successfully,
                  style: TextStyle(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w600,
                    color: Color(0xff7C7C7C),
                    decoration: TextDecoration.none,
                  ),
                ),
                SizedBox(
                  height: 50.h,
                ),
                // GestureDetector(
                //   onTap: () {
                //     return Navigator.of(context).pop();
                //   },
                //   child: Container(
                //     width: DeviceInfo(context).width! - 50,
                //     height: DeviceInfo(context).height! * 0.07,
                //     decoration: BoxDecoration(
                //         color: MyTheme.accent_color,
                //         borderRadius: BorderRadius.circular(12)),
                //     child: Center(
                //       child: Text(
                //         AppLocalizations.of(context)!.view_cart,
                //         style: TextStyle(
                //           fontSize: 22,
                //           fontWeight: FontWeight.w600,
                //           color: MyTheme.white,
                //           decoration: TextDecoration.none,
                //         ),
                //       ),
                //     ),
                //   ),
                // ),
                // SizedBox(
                //   height: 15,
                // ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context, rootNavigator: true).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) {
                          return HomePage();
                        },
                      ),
                    );
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width - 50,
                    height: MediaQuery.of(context).size.height! * 0.07,
                    decoration: BoxDecoration(
                        border:
                            Border.all(color: MyTheme.accent_color, width: 1),
                        borderRadius: BorderRadius.circular(12)),
                    child: Center(
                      child: Text(
                        AppLocalizations.of(context)!.back_the_home,
                        style: TextStyle(
                          fontSize: 22.sp,
                          fontWeight: FontWeight.w600,
                          color: MyTheme.accent_color,
                          decoration: TextDecoration.none,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
