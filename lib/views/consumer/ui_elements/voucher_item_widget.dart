import 'package:dpl_ecommerce/const/app_theme.dart';
import 'package:dpl_ecommerce/customs/custom_elevate_button.dart';
import 'package:dpl_ecommerce/models/voucher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ticket_widget/ticket_widget.dart';
import 'package:sks_ticket_view/sks_ticket_view.dart';

class VoucherItem extends StatelessWidget {
  VoucherItem({super.key, required this.voucher});
  Voucher? voucher;
  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width * 0.6,
        padding: const EdgeInsets.only(left: 15, right: 5),
        height: MediaQuery.of(context).size.height * 0.15,
        // decoration: BoxDecoration(
        //   border: Border.fromBorderSide(
        //     BorderSide(color: Colors.indigo),
        //   ),
        // ),
        child: SKSTicketView(
          // backgroundColor: Colors.,
          contentBackgroundColor: Colors.orangeAccent.shade100,
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
          trianglePos: 0.65,
          child: TicketData(voucher: voucher),
          drawShadow: false,
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
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: MediaQuery.of(context).size.width * 0.3,
          padding: const EdgeInsets.only(left: 8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "${voucher!.discountPercent!} %",
                style: theme.textTheme.bodyMedium,
              ),
              Text(
                voucher!.expDate.toString(),
                style: theme.textTheme.bodySmall,
              )
            ],
          ),
        ),
        const Divider(height: 1),
        const SizedBox(
          width: 25,
        ),
        Container(
          width: MediaQuery.of(context).size.width * 0.15,
          padding: const EdgeInsets.only(right: 8),
          child: CustomElevatedButton(
            buttonStyle: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(Colors.redAccent)),
            text: "Save",
            // width: MediaQuery.of(context).size.width * 0.02,
            // height: MediaQuery.of(context).size.height * 0.03,
            onPressed: () {
              // save
            },
          ),
        )
      ],
    );
  }
}
