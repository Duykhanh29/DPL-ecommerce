import 'package:dpl_ecommerce/data_sources/firestore_data_source/firestore_data.dart';
import 'package:dpl_ecommerce/models/user.dart';
import 'package:dpl_ecommerce/models/voucher_for_user.dart';
import 'package:dpl_ecommerce/view_model/auth_view_model.dart';
import 'package:flutter/material.dart';

class VoucherForUserViewModel extends ChangeNotifier {
  FirestoreDatabase firestoreDatabase = FirestoreDatabase();

  AuthViewModel? _authViewModel;
  UserModel? userModel;
  VoucherForUser? voucherForUser;
  Stream<void> _voucherForUser() async* {
    if (userModel != null) {
      firestoreDatabase.getListVoucherForUser(userModel!.id!);
      notifyListeners();
    }
  }

  VoucherForUserViewModel(this._authViewModel) {
    userModel = _authViewModel!.currentUser; // _auth null here
    _voucherForUser();
  }

  // final VoucherForUser voucherForUser =
  //     VoucherForUser(userID: "userID01", vouchers: [
  //   "voucher01",
  //   "voucher02",
  //   "voucher03",
  //   "voucher04",
  //   "voucher05",
  //   "voucher06",
  //   "voucher07",
  //   "voucher08",
  //   "voucher09",
  //   "voucher10",
  //   "voucher11",
  //   "voucher12"
  // ]);
  void addVoucherForUser(String voucherID) {
    if (!voucherForUser!.vouchers!.contains(voucherID)) {
      voucherForUser!.vouchers!.add(voucherID);
      notifyListeners();
    }
  }

  bool isSaved(String voucherID) {
    if (voucherForUser!.vouchers!.contains(voucherID)) {
      return true;
    }
    return false;
  }
}
