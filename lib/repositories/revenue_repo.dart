import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dpl_ecommerce/data_sources/firestore_data_source/firestore_data.dart';
import 'package:dpl_ecommerce/models/daily_revenue.dart';

class RevenueRepo {
  FirestoreDatabase firestoreDatabase = FirestoreDatabase();
  // get method
  Future<List<DailyRevenue>?> getListDailyRevenueByShop(String shopID) async {
    return await firestoreDatabase.getListDailyRevenueByShop(shopID);
  }
}
