import 'dart:async';

import 'package:dpl_ecommerce/data_sources/firestore_data_source/firestore_data.dart';
import 'package:dpl_ecommerce/models/voucher_for_user.dart';

class VoucherForUserRepo {
  FirestoreDatabase firestoreDatabase = FirestoreDatabase();
  Stream<VoucherForUser> getVoucherForUser(String uid) async* {
    firestoreDatabase.getListVoucherForUser(uid);
  }

  Future<void> addVoucherForUser(VoucherForUser voucherForUser) async {
    await firestoreDatabase.addVoucherForUser(voucherForUser);
  }

  Future<void> updateVoucherForUser(
      {required String userID, required String voucherID}) async {
    await firestoreDatabase.updateVoucherForUser(
        userID: userID, voucherID: voucherID);
  }

  final VoucherForUser voucherForUser = VoucherForUser(
      userID: "user01", vouchers: ["voucher01", 'voucherID01', 'voucher02']);
  Future<void> dispose() async {
    await firestoreDatabase.dispose();
  }
}
