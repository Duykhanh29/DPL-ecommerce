import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dpl_ecommerce/const/app_theme.dart';
import 'package:dpl_ecommerce/helpers/date_helper.dart';
import 'package:dpl_ecommerce/models/voucher.dart';
import 'package:dpl_ecommerce/utils/lang/lang_text.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ticket_widget/ticket_widget.dart';
import 'package:sks_ticket_view/sks_ticket_view.dart';

class UserVoucherItem extends StatelessWidget {
  UserVoucherItem({super.key, required this.voucher});
  Voucher? voucher;
  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width * 0.5,
        padding: const EdgeInsets.only(left: 15, right: 5),
        height: MediaQuery.of(context).size.height * 0.12,
        // decoration: BoxDecoration(
        //   border: Border.fromBorderSide(
        //     BorderSide(color: Colors.indigo),
        //   ),
        // ),
        child: SKSTicketView(
          // backgroundColor: Colors.,
          contentBackgroundColor:
              voucher!.expDate!.compareTo(Timestamp.fromDate(DateTime.now())) >
                      0
                  ? Colors.orangeAccent.shade100
                  : Colors.grey.shade300,
          // backgroundPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 20),
          // contentPadding: EdgeInsets.symmetric(horizontal: 0),
          drawArc: true,
          // dividerPadding: 10,
          triangleAxis: Axis.horizontal,
          // borderRadius: 3,
          corderRadius: 1,
          drawBorder: true,

          drawTriangle: false,
          drawDivider: false,
          trianglePos: 0.68,
          drawShadow: false,
          child: TicketData(voucher: voucher),
        )
        // TicketWidget(
        //   width: 350,
        //   height: 500,
        //   isCornerRounded: true,
        //   padding: EdgeInsets.all(20),
        //   child: TicketData(),
        // ),
        );
  }
}

class TicketData extends StatelessWidget {
  TicketData({super.key, required this.voucher});
  Voucher? voucher;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        // const SizedBox(
        //   width: 30,
        // ),
        Expanded(
          flex: 3,
          child: Container(
            // color: Colors.lightGreen,
            // width: MediaQuery.of(context).size.width * 0.3,
            padding: EdgeInsets.only(left: 8.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  voucher!.discountPercent != null
                      ? "${voucher!.discountPercent!} %"
                      : "${voucher!.discountAmount} VND",
                  style: theme.textTheme.titleLarge,
                ),
                Text(
                  DateHelper.convertDateToDateString(
                      voucher!.releasedDate!.toDate()),
                  style: theme.textTheme.bodySmall,
                )
              ],
            ),
          ),
        ),
        // const Divider(height: 1),
        Expanded(
          flex: 1,
          child: Container(
            // width: MediaQuery.of(context).size.width * 0.2,
            // padding: const EdgeInsets.only(right: 8),
            // color: Colors.deepPurple,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    LangText(context: context).getLocal()!.exp_date,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  Text(
                    DateHelper.convertDateToDateString(
                        voucher!.expDate!.toDate()),
                    textAlign: TextAlign.center,
                  )
                ],
              ),
            ),
          ),
        ),
        const SizedBox(
          width: 10,
        ),
      ],
    );
  }
}
