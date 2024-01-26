import 'package:dpl_ecommerce/const/app_theme.dart';
import 'package:dpl_ecommerce/customs/custom_app_bar.dart';
import 'package:dpl_ecommerce/helpers/toast_helper.dart';
import 'package:dpl_ecommerce/models/voucher.dart';
import 'package:dpl_ecommerce/repositories/voucher_repo.dart';
import 'package:dpl_ecommerce/utils/lang/lang_text.dart';
import 'package:dpl_ecommerce/view_model/user_view_model.dart';
import 'package:dpl_ecommerce/views/admin/screens/voucher/add_coupon_admin.dart';
import 'package:dpl_ecommerce/views/admin/screens/voucher/display_coupon_admin.dart';
import 'package:dpl_ecommerce/views/admin/screens/voucher/edit_voucher_admin..dart';
import 'package:dpl_ecommerce/views/seller/screens/voucher/add_coupon.dart';
import 'package:dpl_ecommerce/views/seller/screens/voucher/display_coupon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class VoucherAdmin extends StatefulWidget {
  VoucherAdmin({super.key, this.isDrawer = false});
  bool isDrawer;
  @override
  State<VoucherAdmin> createState() => __VoucherAdminState();
}

class __VoucherAdminState extends State<VoucherAdmin> {
  List<Voucher> vouchers = [
    // Voucher(
    //   id: DateTime.now().millisecondsSinceEpoch.toString(),
    //   name: 'Voucher 1',

    // ),

    // Add more products if needed
  ];
  VoucherRepo voucherRepo = VoucherRepo();
  bool isLoading = true;
  List<Voucher>? listVoucher;
  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    listVoucher = await voucherRepo.getListVoucherByAdmin();
    isLoading = false;
    if (mounted) {
      setState(() {});
    }
  }

  Future<void> onRefressh() async {
    reset();
    await fetchData();
  }

  reset() {
    listVoucher = null;
    isLoading = true;
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserViewModel>(context);
    // final shopProvider = Provider.of<ShopViewModel>(context);
    final user = userProvider.currentUser;
    // final shop = shopProvider.shop;
    print("First time");
    return Scaffold(
      appBar: CustomAppBar(
              title: LangText(context: context).getLocal()!.vouchers_ucf,
              context: context,
              centerTitle: true,
              isLeading: widget.isDrawer)
          .show(),
      body: buildBody(context),
      floatingActionButton: FloatingActionButton(
        backgroundColor: MyTheme.accent_color,
        onPressed: () {
          // if (!user!.userInfor!.sellerInfor!.isVerified!) {
          //   showDialog();
          // }
          //  else {
          _navigateToAddVocherScreen(context);
          // }
        },
        child: Icon(
          Icons.add,
          size: 20.h,
          color: MyTheme.white,
        ),
      ),
    );
  }

  Widget buildBody(BuildContext context) {
    return RefreshIndicator(
      onRefresh: onRefressh,
      child: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : listVoucher != null && listVoucher!.isNotEmpty
              ? buildListVoucher(context, listVoucher!)
              : Center(
                  child: Text(LangText(context: context)
                      .getLocal()!
                      .no_data_is_available),
                ),
    );
  }

  void _navigateToAddVocherScreen(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddVoucher(),
      ),
    ).whenComplete(() async {
      await onRefressh();
    });
  }

  Widget buildListVoucher(BuildContext context, List<Voucher> list) {
    return ListView.builder(
        itemCount: list!.length,
        padding: EdgeInsets.all(20.h),
        itemBuilder: (context, index) {
          final voucher = list![index];
          return GestureDetector(
            onTap: () {
              _navigateToEditVoucherScreen(context, voucher.id!);
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
                                height: 10.h,
                              ),
                              Text(
                                // "ggggg"
                                '${voucher.name}',
                                //style: theme.textTheme.titleSmall,

                                style: TextStyle(fontSize: 20.sp),
                              ),
                              Row(
                                children: [
                                  Text(voucher.discountAmount != null
                                          ? LangText(context: context)
                                              .getLocal()!
                                              .amount
                                          : LangText(context: context)
                                              .getLocal()!
                                              .percent
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
                          IconButton(
                            color: Colors.blue,
                            icon: Icon(
                              Icons.edit,
                              size: 15.h,
                            ),
                            onPressed: () {
                              _navigateToEditVoucherScreen(
                                  context, voucher.id!);
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
                            icon: Icon(Icons.delete, size: 20.h),
                            color: Colors.redAccent,
                            onPressed: () async {
                              await voucherRepo.deleteVoucherByID(voucher.id!);
                              await onRefressh();
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

  Widget buildShimer() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.9,
      child: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  void _navigateToEditVoucherScreen(
      BuildContext context, String voucherID) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditAdminVoucher(
          voucherID: voucherID,
          // onVoucherUpdated: widget.onVoucherUpdated,
          // vouchers: [],
        ),
      ),
    ).whenComplete(() async {
      await onRefressh();
    });
  }
}
