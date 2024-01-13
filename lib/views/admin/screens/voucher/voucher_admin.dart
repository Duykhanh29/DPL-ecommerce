import 'package:dpl_ecommerce/customs/custom_app_bar.dart';
import 'package:dpl_ecommerce/helpers/toast_helper.dart';
import 'package:dpl_ecommerce/models/voucher.dart';
import 'package:dpl_ecommerce/repositories/voucher_repo.dart';
import 'package:dpl_ecommerce/utils/lang/lang_text.dart';
import 'package:dpl_ecommerce/view_model/seller/shop_view_model.dart';
import 'package:dpl_ecommerce/view_model/user_view_model.dart';
import 'package:dpl_ecommerce/views/admin/screens/voucher/display_coupon_admin.dart';
import 'package:dpl_ecommerce/views/seller/screens/voucher/add_coupon.dart';
import 'package:dpl_ecommerce/views/seller/screens/voucher/display_coupon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class VoucherAdmin extends StatefulWidget {
  const VoucherAdmin({super.key});

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
  List<Voucher>? listVoucher;
  VoucherRepo voucherRepo = VoucherRepo();
  bool isLoading = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  Future<void> fetchData() async {
    listVoucher = await voucherRepo.getListVoucherByAdmin();
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserViewModel>(context);
    final shopProvider = Provider.of<ShopViewModel>(context);
    final user = userProvider.currentUser;
    final shop = shopProvider.shop;
    return Scaffold(
      appBar: CustomAppBar(
              title: LangText(context: context).getLocal()!.vouchers_ucf,
              context: context,
              centerTitle: true)
          .show(),
      body: Consumer<ShopViewModel>(builder: (context, value, child) {
        if (value.shop == null) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return DisplayVoucher(
              // vouchers: vouchers,
              // onVoucherDeleted: _deleteVoucher,
              // onVoucherUpdated: _updateVoucher,
              );
        }
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // if (!user!.userInfor!.sellerInfor!.isVerified!) {
          //   showDialog();
          // }
          //  else {
          _navigateToAddVocherScreen(context, shop!.id!);
          // }
        },
        child: Icon(
          Icons.add,
          size: 20.h,
        ),
      ),
    );
  }

  void _navigateToAddVocherScreen(BuildContext context, String shopID) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddCoupon(
          shopID: shopID,
        ),
      ),
    );
  }

  // void _addVoucher(Voucher newVoucher) {
  //   setState(() {
  //     vouchers.add(newVoucher);
  //   });
  // }

  // void _updateVoucher(Voucher updatedVoucher) {
  //   setState(() {
  //     int index =
  //         vouchers.indexWhere((voucher) => voucher.id == updatedVoucher.id);
  //     if (index != -1) {
  //       vouchers[index] = updatedVoucher;
  //     }
  //   });
  // }

  // void _deleteVoucher(String voucherId) {
  //   setState(() {
  //     vouchers.removeWhere((voucher) => voucher.id == voucherId);
  //   });
  // }
}
