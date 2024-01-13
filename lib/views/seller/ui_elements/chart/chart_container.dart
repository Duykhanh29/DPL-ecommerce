import 'package:dpl_ecommerce/utils/lang/lang_text.dart';
import 'package:dpl_ecommerce/view_model/seller/shop_view_model.dart';
import 'package:dpl_ecommerce/views/seller/ui_elements/chart/chart_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class ChartContainer extends StatelessWidget {
  const ChartContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10.r),
          // boxShadow: [W
          //     BoxShadow(
          //       color: shadowColor,
          //       offset: Offset(0, 6),
          //       blurRadius: blurSize,
          //     ),
          //   ],
        ),
        // margin: EdgeInsets.symmetric(horizontal: 15),
        // padding: EdgeInsets.symmetric(vertical: 10),
        // MyWidget.customCardView(
        padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 2.h),
        height: 200.h,
        // shadowColor: MyTheme.app_accent_color_extra_light,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: [
            // Positioned(
            //   right: 5,
            //   child: Text(
            //     "20-26 Feb, 2022",
            //     style: TextStyle(
            //         fontSize: 10, color: MyTheme.app_accent_color),
            //   ),
            // ),
            // Positioned(
            //   left: 0,
            //   child: Text(
            //     "Sale",
            //     style: TextStyle(
            //         fontSize: 14.sp,
            //         color: Colors.black,
            //         fontWeight: FontWeight.bold),
            //   ),
            // ),
            Padding(
              padding: EdgeInsets.only(top: 18.h),
              child: SizedBox(
                height: 190.h,
                width: MediaQuery.of(context).size.width,
                child: Consumer<ShopViewModel>(
                  builder: (context, value, child) {
                    if (value.shop != null) {
                      return MChart(
                        shopID: value.shop!.id!,
                      );
                    }
                    return Container();
                  },
                ),
              ),
            ),
          ],
          // )
        ));
  }
}
