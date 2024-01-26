import 'dart:async';

import 'package:dpl_ecommerce/data_sources/firestore_data_source/firestore_data.dart';
import 'package:dpl_ecommerce/models/voucher_for_user.dart';

class VoucherForUserRepo {
  FirestoreDatabase firestoreDatabase = FirestoreDatabase();
  Stream<VoucherForUser?> getVoucherForUser(String uid) {
    return firestoreDatabase.getListVoucherForUser(uid);
  }

  Future<VoucherForUser?> getVoucher(String uid) async {
    return await firestoreDatabase.getVoucherUser(uid);
  }

  // Future<List<String>?> getListVoucherOfAdminInVoucherFOrUser(
  //     String uid) async {
  //   return firestoreDatabase.getListVoucherOfAdminInVoucherFOrUser(uid);
  // }

  Future<void> addVoucherForUser(VoucherForUser voucherForUser) async {
    await firestoreDatabase.addVoucherForUser(voucherForUser);
  }

  Stream<bool> isCollectedVoucher(String uid, String voucherID) {
    return firestoreDatabase.isCollectedVoucher(uid: uid, voucherID: voucherID);
  }

  Future<void> updateVoucherForUser(
      {required String userID, required String voucherID}) async {
    await firestoreDatabase.updateVoucherForUser(
        userID: userID, voucherID: voucherID);
  }

  Future<void> deleteVoucherIDForUser(
      {required String uid, required String voucherID}) async {
    await firestoreDatabase.deleteVoucherIDForUser(
        uid: uid, voucherID: voucherID);
  }

  final VoucherForUser voucherForUser = VoucherForUser(
      userID: "user01", vouchers: ["voucher01", 'voucherID01', 'voucher02']);
  Future<void> dispose() async {
    await firestoreDatabase.dispose();
  }
}
