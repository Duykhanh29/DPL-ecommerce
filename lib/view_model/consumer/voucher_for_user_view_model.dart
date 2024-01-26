import 'package:dpl_ecommerce/data_sources/firestore_data_source/firestore_data.dart';
import 'package:dpl_ecommerce/models/user.dart';
import 'package:dpl_ecommerce/models/voucher.dart';
import 'package:dpl_ecommerce/models/voucher_for_user.dart';
import 'package:dpl_ecommerce/view_model/auth_view_model.dart';
import 'package:flutter/material.dart';

class VoucherForUserViewModel extends ChangeNotifier {
  // FirestoreDatabase firestoreDatabase = FirestoreDatabase();

  // AuthViewModel? _authViewModel;
  // UserModel? userModel;
  // VoucherForUser? voucherForUser;
  // Stream<void> _voucherForUser() async* {
  //   if (userModel != null) {
  //     firestoreDatabase.getListVoucherForUser(userModel!.id!);
  //     notifyListeners();
  //   }
  // }

  // VoucherForUserViewModel(this._authViewModel) {
  //   userModel = _authViewModel!.currentUser; // _auth null here
  //   _voucherForUser();
  // }

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
  VoucherForUser? voucherForUser;
  List<String> voucherOfAdmin = [];
  List<Voucher> listVoucherOfAdmin = [];
  Voucher? selectedVoucher;
  void setVoucherOfAdmin(List<String> list) {
    voucherOfAdmin = list;
    notifyListeners();
  }

  void setVoucherForUser(VoucherForUser voucher) {
    voucherForUser = voucher;
    notifyListeners();
  }

  void addNewVoucherID(String voucherID) {
    voucherForUser!.vouchers!.add(voucherID);
    notifyListeners();
  }

  void deleteVoucherID(String voucherID) {
    if (voucherForUser!.vouchers != null) {
      // for (var element in voucherForUser!.vouchers!) {
      //   if (element == voucherID) {
      //     voucherForUser!.vouchers!.remove(element);
      //   }
      // }
      voucherForUser!.vouchers!.removeWhere((element) => element == voucherID);
    }
    notifyListeners();
  }

  List<Voucher> list = [];
  void setList(List<Voucher> listVocuher) {
    list = listVocuher;
    notifyListeners();
  }

  void addNewVoucher(Voucher voucher) {
    list.add(voucher);
    notifyListeners();
  }

  // void addVoucherForUser(String voucherID) {
  //   if (!voucherForUser!.vouchers!.contains(voucherID)) {
  //     voucherForUser!.vouchers!.add(voucherID);
  //     notifyListeners();
  //   }
  // }

  // bool isSaved(String voucherID) {
  //   if (voucherForUser!.vouchers!.contains(voucherID)) {
  //     return true;
  //   }
  //   return false;
  // }

  // with purpose for checking out
  void setListVoucherOfAdmin(List<Voucher> list) {
    listVoucherOfAdmin = list;
    selectedVoucher = list[0];
    notifyListeners();
  }

  void changeSelectedVoucher(Voucher voucher) {
    selectedVoucher = voucher;
    notifyListeners();
  }

  void resetData() {
    selectedVoucher = null;
    listVoucherOfAdmin = [];
    notifyListeners();
  }
}
