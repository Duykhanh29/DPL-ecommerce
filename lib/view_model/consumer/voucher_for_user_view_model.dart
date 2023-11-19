import 'package:dpl_ecommerce/models/voucher_for_user.dart';
import 'package:flutter/material.dart';

class VoucherForUserViewModel extends ChangeNotifier {
  final VoucherForUser voucherForUser =
      VoucherForUser(userID: "userID01", vouchers: [
    "voucher01",
    "voucher02",
    "voucher03",
    "voucher04",
    "voucher05",
    "voucher06",
    "voucher07",
    "voucher08",
    "voucher09",
    "voucher10",
    "voucher11",
    "voucher12"
  ]);
  void addVoucherForUser(String voucherID) {
    if (!voucherForUser.vouchers!.contains(voucherID)) {
      voucherForUser.vouchers!.add(voucherID);
      notifyListeners();
    }
  }

  bool isSaved(String voucherID) {
    if (voucherForUser.vouchers!.contains(voucherID)) {
      return true;
    }
    return false;
  }
}
