import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dpl_ecommerce/data_sources/firestore_data_source/firestore_data.dart';
import 'package:dpl_ecommerce/models/voucher.dart';

class VoucherRepo {
  FirestoreDatabase firestoreDatabase = FirestoreDatabase();
  List<Voucher>? listVoucher;

  // get methods
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

  // post methods
  Future<void> addVoucher(Voucher voucher) async {
    await firestoreDatabase.addVoucher(voucher);
  }

  Future<void> editVoucher(
      {required String id, required Voucher voucher}) async {
    await firestoreDatabase.editVoucher(id: id, voucher: voucher);
  }

  Future<void> dispose() async {
    await firestoreDatabase.dispose();
    listVoucher?.clear();
  }
}
