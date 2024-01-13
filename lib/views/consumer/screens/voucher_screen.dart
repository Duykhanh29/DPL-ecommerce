import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dpl_ecommerce/customs/custom_app_bar.dart';
import 'package:dpl_ecommerce/models/voucher.dart';
import 'package:dpl_ecommerce/repositories/voucher_for_user_repo.dart';
import 'package:dpl_ecommerce/repositories/voucher_repo.dart';
import 'package:dpl_ecommerce/utils/lang/lang_text.dart';
import 'package:dpl_ecommerce/view_model/user_view_model.dart';
import 'package:dpl_ecommerce/views/consumer/ui_elements/voucher_widgets/voucher_clipper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dpl_ecommerce/models/voucher_for_user.dart';
import 'package:provider/provider.dart';

class VoucherScreen extends StatefulWidget {
  const VoucherScreen({super.key});

  @override
  State<VoucherScreen> createState() => __VoucherScreenState();
}

class __VoucherScreenState extends State<VoucherScreen> {
  bool isLoading = true;
  List<Voucher>? listVoucher;
  VoucherRepo voucherRepo = VoucherRepo();
  VoucherForUserRepo voucherForUserRepo = VoucherForUserRepo();

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    listVoucher = await voucherRepo.getListVoucher();
    isLoading = false;
    if (mounted) {
      setState(() {});
    }
  }

  void reset() {
    if (listVoucher != null) {
      listVoucher!.clear();
      isLoading = true;
    }
    if (mounted) {
      setState(() {});
    }
  }

  Future<void> onRefresh() async {
    reset();
    await fetchData();
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserViewModel>(context);
    final user = userProvider.currentUser;

    return Scaffold(
      appBar: CustomAppBar(
              title: LangText(context: context).getLocal()!.vouchers_ucf,
              context: context,
              centerTitle: true)
          .show(),
      body: RefreshIndicator(
        onRefresh: onRefresh,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
          child: Container(
            width: double.maxFinite,
            child: Column(
              children: [
                Expanded(
                    child: SingleChildScrollView(
                  // child: Padding(
                  padding: EdgeInsets.only(bottom: 0.h, left: 0.w),
                  child: Column(
                    children: [
                      _buildProductSmallList1(context),
                    ],
                  ),
                  // ),
                ))
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProductSmallList1(BuildContext context) {
    final userProvider = Provider.of<UserViewModel>(context);
    final user = userProvider.currentUser;
    // List<Voucher> list = [
    //   Voucher(
    //       discountPercent: 20,
    //       expDate: Timestamp.fromDate(DateTime(2023, 10, 7, 17, 30)),
    //       releasedDate: Timestamp.fromDate(DateTime(2023, 9, 7, 17, 30))),
    //   Voucher(
    //       discountAmount: 40,
    //       expDate: Timestamp.fromDate(DateTime(2023, 10, 7, 17, 30)),
    //       releasedDate: Timestamp.fromDate(DateTime(2023, 9, 7, 17, 30))),
    //   Voucher(
    //       discountAmount: 20,
    //       expDate: Timestamp.fromDate(DateTime(2023, 10, 7, 17, 30)),
    //       releasedDate: Timestamp.fromDate(DateTime(2023, 9, 7, 17, 30))),
    //   Voucher(
    //       discountPercent: 40,
    //       expDate: Timestamp.fromDate(DateTime(2023, 10, 7, 17, 30)),
    //       releasedDate: Timestamp.fromDate(DateTime(2023, 9, 7, 17, 30))),
    //   Voucher(
    //       discountPercent: 20,
    //       expDate: Timestamp.fromDate(DateTime(2023, 10, 7, 17, 30)),
    //       releasedDate: Timestamp.fromDate(DateTime(2023, 9, 7, 17, 30))),
    //   Voucher(
    //       discountAmount: 40,
    //       expDate: Timestamp.fromDate(DateTime(2023, 10, 7, 17, 30)),
    //       releasedDate: Timestamp.fromDate(DateTime(2023, 9, 7, 17, 30))),
    //   Voucher(
    //       discountAmount: 20,
    //       expDate: Timestamp.fromDate(DateTime(2023, 10, 7, 17, 30)),
    //       releasedDate: Timestamp.fromDate(DateTime(2023, 9, 7, 17, 30))),
    //   Voucher(
    //       discountPercent: 40,
    //       expDate: Timestamp.fromDate(DateTime(2023, 10, 7, 17, 30)),
    //       releasedDate: Timestamp.fromDate(DateTime(2023, 9, 7, 17, 30))),
    //   Voucher(
    //       discountPercent: 20,
    //       expDate: Timestamp.fromDate(DateTime(2023, 10, 7, 17, 30)),
    //       releasedDate: Timestamp.fromDate(DateTime(2023, 9, 7, 17, 30))),
    //   Voucher(
    //       discountAmount: 40,
    //       expDate: Timestamp.fromDate(DateTime(2023, 10, 7, 17, 30)),
    //       releasedDate: Timestamp.fromDate(DateTime(2023, 9, 7, 17, 30))),
    //   Voucher(
    //       discountAmount: 20,
    //       expDate: Timestamp.fromDate(DateTime(2023, 10, 7, 17, 30)),
    //       releasedDate: Timestamp.fromDate(DateTime(2023, 9, 7, 17, 30))),
    //   Voucher(
    //       discountPercent: 40,
    //       expDate: Timestamp.fromDate(DateTime(2023, 10, 7, 17, 30)),
    //       releasedDate: Timestamp.fromDate(DateTime(2023, 9, 7, 17, 30))),
    // ];
    // print("List length: ${listVoucher!.length}");
    return isLoading
        ? const Center(
            // child: CircularProgressIndicator(),
            )
        : listVoucher != null && listVoucher!.isNotEmpty
            ? GridView.builder(
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisSpacing: 5,
                  mainAxisSpacing: 5,
                  crossAxisCount: 2,
                  //mainAxisExtent: 200.h,
                  // childAspectRatio: 3 / 2,
                ),
                itemBuilder: (context, index) {
                  return ClipPath(
                    clipper: VoucherClipper(),
                    child: Row(
                      children: [
                        Container(
                          height: 160.h,
                          width: 50.w,
                          alignment: Alignment.center,
                          color: Colors.blue,
                          // child: Text(
                          //   list![index].id!,
                          //   style: TextStyle(color: Colors.white),
                          // ),
                        ),
                        Container(
                          height: 160.h,
                          width: 110.w,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                              width: 0.5.w,
                              color: Colors.grey,
                            ),
                          ),
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(0, 10.h, 2.w, 0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                listVoucher![index].discountAmount == null
                                    ? Text(
                                        "${LangText(context: context).getLocal()!.reduce_ucf}${listVoucher![index].discountPercent} %",
                                        maxLines: 3,
                                        style: TextStyle(
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.bold,
                                        ))
                                    : Text(
                                        "${LangText(context: context).getLocal()!.reduce_ucf}đ${listVoucher![index].discountAmount} k",
                                        style: TextStyle(
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        maxLines: 4,
                                      ),
                                SizedBox(
                                  height: 10.h,
                                ),
                                Text(LangText(context: context)
                                    .getLocal()!
                                    .from_ucf),
                                Text(
                                  '${listVoucher![index].releasedDate!.toDate().day}'
                                  "/"
                                  '${listVoucher![index].releasedDate!.toDate().month}'
                                  "/"
                                  '${listVoucher![index].releasedDate!.toDate().year}',
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    //fontWeight: FontWeight.w400,
                                  ),
                                ),
                                Text(LangText(context: context)
                                    .getLocal()!
                                    .to_ucf),
                                Text(
                                  '${listVoucher![index].expDate!.toDate().day}'
                                  "/"
                                  '${listVoucher![index].expDate!.toDate().month}'
                                  "/"
                                  '${listVoucher![index].expDate!.toDate().year}',
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    //fontWeight: FontWeight.w400,
                                  ),
                                ),
                                SizedBox(
                                  height: 10.h,
                                ),
                                buildSaveButton(
                                    listVoucher![index].id!, user!.id!)
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
                physics: BouncingScrollPhysics(),
                itemCount: listVoucher!.length,
              )
            : Center(
                child: Text(LangText(context: context)
                    .getLocal()!
                    .no_data_is_available),
              );
  }

  Widget buildSaveButton(String voucherID, String uid) {
    return StreamBuilder(
      stream: voucherForUserRepo.isCollectedVoucher(uid, voucherID),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Container();
        } else {
          if (snapshot.hasData) {
            if (snapshot.data != null) {
              final isExist = snapshot.data;
              if (!isExist! || isExist == null) {
                return Container(
                  height: 30.h,
                  width: 90.w,
                  child: ElevatedButton(
                    child: Text(LangText(context: context).getLocal()!.add_ucf),
                    onPressed: () async {
                      await voucherForUserRepo.updateVoucherForUser(
                          userID: uid, voucherID: voucherID);
                    },
                  ),
                );
              }
            }
          }
        }
        return Container();
      },
    );
  }
}