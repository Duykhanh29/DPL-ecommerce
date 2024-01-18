import 'package:dpl_ecommerce/data_sources/firestore_data_source/firestore_data.dart';

class StatisticsRepo {
  FirestoreDatabase firestoreDatabase = FirestoreDatabase();
  Future<int?> getTotalUsers() async {
    return await firestoreDatabase.getTotalConsumer();
  }

  Future<int?> getTotalShop() async {
    return await firestoreDatabase.getTotalSeller();
  }

  Future<int?> getTotalOrder() async {
    return await firestoreDatabase.getTotalOrder();
  }

  Future<int?> getTotalProduct() async {
    return await firestoreDatabase.getTotalProduct();
  }

  Future<int?> getTotaleliveryService() async {
    return await firestoreDatabase.getTotalDeliveryService();
  }

  Future<int?> getTotalCategory() async {
    return await firestoreDatabase.getTotalCategory();
  }

  Future<void> dispose() async {
    await firestoreDatabase.dispose();
  }
}
