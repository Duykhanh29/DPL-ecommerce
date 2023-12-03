import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dpl_ecommerce/data_sources/firestore_data_source/firestore_data.dart';
import 'package:dpl_ecommerce/models/voucher.dart';

class VoucherRepo {
  FirestoreDatabase firestoreDatabase = FirestoreDatabase();
  List<Voucher>? listVoucher;
  Future<List<Voucher>?> getListVoucher() async {
    List<Voucher>? result = await firestoreDatabase.getActivceVoucherList();
    return result;
  }

  Future<List<Voucher>?> getListVoucherByShop(String shopID) async {
    List<Voucher>? result =
        await firestoreDatabase.getListVoucherByShop(shopID);
    return result;
  }

  Future<List<Voucher>?> getListVoucherByProduct(String productID) async {
    List<Voucher>? result =
        await firestoreDatabase.getListVoucherByProduct(productID);
    return result;
  }

  Future<Voucher?> getVoucherByID(String id) async {
    return await firestoreDatabase.getVoucherByID(id);
  }

  void dispose() {
    listVoucher?.clear();
  }
}
