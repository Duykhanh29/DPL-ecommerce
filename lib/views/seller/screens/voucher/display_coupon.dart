import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dpl_ecommerce/models/voucher.dart';
import 'package:dpl_ecommerce/views/seller/screens/voucher/edit_voucher..dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DisplayCoupon extends StatefulWidget {
  final List<Voucher> vouchers;
  final Function(String) onVoucherDeleted;
  final Function(Voucher) onVoucherUpdated;

  DisplayCoupon({
    required this.vouchers,
    required this.onVoucherDeleted,
    required this.onVoucherUpdated,
  });

  @override
  State<DisplayCoupon> createState() => __DisplayCouponState();
}

class __DisplayCouponState extends State<DisplayCoupon> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: widget.vouchers.length,
        padding: EdgeInsets.all(20),
        itemBuilder: (context, index) {
          final voucher = widget.vouchers[index];
          return GestureDetector(
            onTap: () {
              print("object");
              _navigateToEditVoucherScreen(context, voucher);
            },
            child: Column(
              children: [
                SizedBox(
                  height: 20.h,
                ),
                Container(
                  // padding: EdgeInsets.symmetric(
                  //   horizontal: 5.h,
                  //   vertical: 5.h,
                  // ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(9),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        spreadRadius: 2.h,
                        blurRadius: 2.h,
                        offset: Offset(
                          0,
                          4,
                        ),
                      ),
                    ],
                  ),
                  child: Row(
                    // mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            width: 10.w,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                // "ggggg"
                                '${voucher.name}',
                                //style: theme.textTheme.titleSmall,

                                style: TextStyle(fontSize: 20),
                              ),
                              Row(
                                children: [
                                  Text(voucher.discountAmount != null
                                          ? "amount"
                                          : "percent"
                                      //'Price: ${voucher.price}',
                                      //style: theme.textTheme.bodySmall,
                                      // maxLines: 2,
                                      ),
                                  SizedBox(
                                    width: 15.w,
                                  ),
                                  Text(voucher.discountAmount != null
                                      ? "${voucher.discountAmount} VND"
                                      : "${voucher.discountPercent}%")
                                ],
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              Text(
                                "${voucher.releasedDate!.toDate().day}/${voucher.releasedDate!.toDate().month}/${voucher.releasedDate!.toDate().year} - ${voucher.expDate!.toDate().day}/${voucher.expDate!.toDate().month}/${voucher.expDate!.toDate().year}"
                                //'Quantity: ${voucher.availableQuantity}',
                                //style: theme.textTheme.bodySmall,
                                ,
                                style: TextStyle(color: Colors.grey),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton.filled(
                            hoverColor: Colors.blue,
                            color: Colors.blue,
                            icon: Icon(Icons.edit),
                            onPressed: () {
                              _navigateToEditVoucherScreen(context, voucher);
                            },
                          ),
                          // Center(
                          //   child: Ink(
                          //     decoration: const ShapeDecoration(
                          //       color: Colors.green,
                          //       shape: CircleBorder(),
                          //     ),
                          //     child: IconButton(
                          //       icon: const Icon(Icons.android),
                          //       color: Colors.blue,
                          //       onPressed: () {},
                          //     ),
                          //   ),
                          // ),
                          IconButton(
                            icon: Icon(Icons.delete),
                            //color: Colors.blueGrey,
                            onPressed: () {
                              widget.onVoucherDeleted(voucher.id!);
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }

  void _navigateToEditVoucherScreen(
      BuildContext context, Voucher voucher) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditVoucher(
          voucher: voucher,
          onVoucherUpdated: widget.onVoucherUpdated,
          vouchers: [],
        ),
      ),
    );
  }
}
