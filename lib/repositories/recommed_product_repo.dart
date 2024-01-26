import 'package:dpl_ecommerce/data_sources/local_data_source/recommeded_product_data.dart';
import 'package:dpl_ecommerce/models/recommeded_product.dart';

class RecommededProductRepo {
  RecommededSQLiteDatabase sqLiteDatabase = RecommededSQLiteDatabase();
  Future<List<RecommendedProducts>?> getListRecommededProduct() async {
    return await sqLiteDatabase.fetchAllData();
  }

  Future<List<RecommendedProducts>?> fetchRecentData() async {
    return await sqLiteDatabase.fetchRecentData(2);
  }

  Future<void> insertData(
      {required String uid, String? shopId, String? categoryID}) async {
    await sqLiteDatabase.insertData(
        uid: uid, categoryID: categoryID, shopID: shopId);
  }

  Future<List<String>?> getListCategoryID(
      List<RecommendedProducts> list) async {
    return await sqLiteDatabase.getListCategoryID(list);
  }

  Future<List<String>?> getListShopID(List<RecommendedProducts> list) async {
    return await sqLiteDatabase.getListShopID(list);
  }
}
