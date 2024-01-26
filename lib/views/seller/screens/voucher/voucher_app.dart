import 'package:dpl_ecommerce/const/app_theme.dart';
import 'package:dpl_ecommerce/customs/custom_app_bar.dart';
import 'package:dpl_ecommerce/helpers/toast_helper.dart';
import 'package:dpl_ecommerce/models/voucher.dart';
import 'package:dpl_ecommerce/repositories/voucher_repo.dart';
import 'package:dpl_ecommerce/utils/lang/lang_text.dart';
import 'package:dpl_ecommerce/view_model/seller/shop_view_model.dart';
import 'package:dpl_ecommerce/view_model/user_view_model.dart';
import 'package:dpl_ecommerce/views/seller/screens/voucher/add_coupon.dart';
import 'package:dpl_ecommerce/views/seller/screens/voucher/display_coupon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class VoucherApp extends StatefulWidget {
  VoucherApp({
    super.key,
  });

  @override
  State<VoucherApp> createState() => __VoucherAppState();
}

class __VoucherAppState extends State<VoucherApp> {
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

  // String tempShopID = "PkHVNq0E1ZnTUyRnqG4O";
  // Future<void> fetchData() async {
  //   listVoucher = await voucherRepo.getListVoucherByShop(widget.shopID);
  // }

  showDialog() {
    ToastHelper.showDialog(
        LangText(context: context).getLocal()!.your_account_is_unverified,
        gravity: ToastGravity.CENTER,
        duration: Toast.LENGTH_LONG);
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
          return DisplayCoupon(
            shopID: value.shop!.id!,
            // vouchers: vouchers,
            // onVoucherDeleted: _deleteVoucher,
            // onVoucherUpdated: _updateVoucher,
          );
        }
      }),
      floatingActionButton: FloatingActionButton(
        backgroundColor: MyTheme.accent_color,
        onPressed: () {
          if (!user!.userInfor!.sellerInfor!.isVerified!) {
            showDialog();
          } else {
            _navigateToAddVocherScreen(context, shop!.id!);
          }
        },
        child: Icon(
          Icons.add,
          size: 20.h,
          color: MyTheme.white,
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
