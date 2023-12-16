import 'package:dpl_ecommerce/data_sources/local_data_source/sqlite_database.dart';
import 'package:dpl_ecommerce/models/search_history.dart';

class SearchHistoryRepo {
  // SeacrhHistory seacrhHistory = SeacrhHistory(
  //     list: ["Men shoes", "Phone", "Balo", "Packet", "Wallet", "userID007"]);
  SQLiteDatabase sqLiteDatabase = SQLiteDatabase();
  Future<List<SeacrhHistory>?> getListSearchHistory() async {
    List<SeacrhHistory>? list = await sqLiteDatabase.fetchAllData();
    return list;
  }

  Future<int?> insertSearchKey(
      {required String uid, required String searchKey}) async {
    try {
      int result =
          await sqLiteDatabase.insertData(uid: uid, searchKey: searchKey);
      if (result != 0) {
        print("Succeed");
      } else {
        print("Succeed");
      }
      return result;
    } catch (e) {
      print("An error occurred: $e");
    }
  }

  Future<int?> deleteByID(int id) async {
    try {
      int result = await sqLiteDatabase.deleteData(id);
      if (result != 0) {
        print("Succeed");
      } else {
        print("Succeed");
      }
      return result;
    } catch (e) {
      print("An error occurred: $e");
    }
  }

  Future<int?> deleteSearchKey({required String searchKey}) async {
    try {
      int result =
          await sqLiteDatabase.deleteDataWithParams(searchKey: searchKey);
      if (result != 0) {
        print("Succeed");
      } else {
        print("Succeed");
      }
      return result;
    } catch (e) {
      print("An error occurred: $e");
    }
  }

  Future<List<String>?> convertSeacrhListToListString(
      List<SeacrhHistory>? list) async {
    List<String>? result = await sqLiteDatabase.getListSearchInLocalData(list!);
    return result;
  }
}
