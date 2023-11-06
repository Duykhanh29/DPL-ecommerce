import 'package:dpl_ecommerce/const/app_decoration.dart';
import 'package:dpl_ecommerce/const/app_theme.dart';
import 'package:dpl_ecommerce/customs/custom_image_view.dart';
import 'package:dpl_ecommerce/customs/custom_text_style.dart';
import 'package:dpl_ecommerce/utils/constants/image_data.dart';
import 'package:dpl_ecommerce/utils/constants/size_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_timer_countdown/flutter_timer_countdown.dart';

// ignore: must_be_immutable
class PromotionbannerItemWidget extends StatelessWidget {
  const PromotionbannerItemWidget({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // go to detail flash sale
      },
      child: SizedBox(
        height: 206.v,
        width: 343.h,
        child: Stack(
          alignment: Alignment.centerLeft,
          children: [
            CustomImageView(
              imagePath: ImageData.imgImage03,
              height: 206.v,
              width: 343.h,
              radius: BorderRadius.circular(
                5.h,
              ),
              alignment: Alignment.center,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.only(left: 24.h),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 209.h,
                      child: Text(
                        "Name flashsale",
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.headlineSmall!.copyWith(
                          height: 1.50,
                        ),
                      ),
                    ),
                    SizedBox(height: 27.v),
                    Row(
                      children: [
                        const Text("Start day"),
                        TimerCountdown(
                          timeTextStyle: TextStyle(
                              color: Colors.red,
                              fontSize: 22,
                              fontWeight: FontWeight.w500),
                          enableDescriptions: false,
                          endTime:
                              DateTime.now().subtract(const Duration(days: 3)),
                          format: CountDownTimerFormat.daysHoursMinutesSeconds,
                          onEnd: () {
                            // disappear this flashsale
                          },
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        const Text("End day"),
                        TimerCountdown(
                          timeTextStyle: TextStyle(
                              color: Colors.red,
                              fontSize: 22,
                              fontWeight: FontWeight.w500),
                          enableDescriptions: false,
                          endTime: DateTime.now().add(const Duration(days: 3)),
                          format: CountDownTimerFormat.daysHoursMinutesSeconds,
                          onEnd: () {
                            // disappear this flashsale
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
