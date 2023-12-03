import 'dart:async';

import 'package:dpl_ecommerce/data_sources/firestore_data_source/firestore_data.dart';
import 'package:dpl_ecommerce/models/voucher_for_user.dart';

class VoucherForUserRepo {
  FirestoreDatabase firestoreDatabase = FirestoreDatabase();
  Stream<VoucherForUser> getVoucherForUser(String uid) async* {
    firestoreDatabase.getListVoucherForUser(uid);
  }

  final VoucherForUser voucherForUser = VoucherForUser(
      userID: "user01", vouchers: ["voucher01", 'voucherID01', 'voucher02']);
}
