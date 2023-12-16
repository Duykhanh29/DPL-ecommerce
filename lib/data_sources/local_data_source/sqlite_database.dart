import 'package:dpl_ecommerce/models/search_history.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

class SQLiteDatabase {
  static final SQLiteDatabase instance = SQLiteDatabase();
  static Database? _database;
  final String searchHistoryTable = 'seacrhHistories';
  final String idRaw = "id";
  final userIDRow = 'userID';
  final searchKeyRaw = 'searchKey';
  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    } else {
      _database = await initialDB();
      return _database!;
    }
  }

  Future<String> getPullPath() async {
    final name = searchHistoryTable;
    final path = await getDatabasesPath();
    return join(path, name);
  }

  Future<Database> initialDB() async {
    final path = await getPullPath();
    var database = await openDatabase(path, version: 1, onCreate: create);
    return database;
  }

  Future<void> create(Database database, int version) async {
    createTable(database);
  }

  Future<void> createTable(Database database) async {
    await database.execute("CREATE TABLE $searchHistoryTable ("
        "$idRaw INTEGER PRIMARY KEY AUTOINCREMENT,"
        "$searchKeyRaw TEXT,"
        "$userIDRow TEXT"
        ")");
  }

  // insert data
  Future<int> insertData(
      {required String uid, required String searchKey}) async {
    final db = await instance.database;
    // var result = await db.rawInsert(
    //     "INSERT INTO $table_name (null,$nameCityRaw,$longitudeRaw,$latitudeRaw)"
    //     " VALUES (?,?,?)",
    //     [city, longitude, latitude],);
    var result = await db.insert(
        searchHistoryTable, {userIDRow: uid, searchKeyRaw: searchKey},
        nullColumnHack: idRaw);
    return result;
  }

  Future<bool> isSearchKeyExists(String searchKey) async {
    final db = await instance.database;
    final result = await db.query(
      instance.searchHistoryTable,
      where: '$searchKeyRaw = ?',
      whereArgs: [searchKey],
    );

    return result.isNotEmpty;
  }

  Future<List<SeacrhHistory>?> fetchAllData() async {
    final db = await instance.database;
    final data = await db.rawQuery("SELECT * FROM $searchHistoryTable");
    return data.map((e) => SeacrhHistory.fromJson(e)).toList();
  }

  Future<SeacrhHistory>? fetchDataByID(int id) async {
    final data = await _database!
        .rawQuery("SELECT * FROM $searchHistoryTable WHERE $idRaw = ?", [id]);
    return SeacrhHistory.fromJson(data.first);
  }

  // query
  Future<List<String>> getListSearchInLocalData(
      List<SeacrhHistory> listData) async {
    var query =
        await _database!.query(searchHistoryTable, columns: [searchKeyRaw]);
    List<String> list = query.map((e) => e[searchKeyRaw].toString()).toList();
    return list;
  }

  Future<SeacrhHistory> getLocalDataByParams(String searchKey) async {
    final sql = await _database!.query(searchHistoryTable,
        where: '$searchKeyRaw = ?', whereArgs: [searchKey], limit: 1);
    Map<String, dynamic> data = sql.first;
    return SeacrhHistory.fromJson(data);
  }

  Future<int> deleteData(int id) async {
    var result = await _database!
        .delete(searchHistoryTable, where: "$idRaw =?", whereArgs: [id]);
    // return result;
    return await _database!
        .rawDelete("DELETE FROM $searchHistoryTable WHERE $idRaw = ? ", [id]);
  }

  Future<int> deleteDataWithParams({required String searchKey}) async {
    final SeacrhHistory seacrhHistory = await getLocalDataByParams(searchKey);
    var result = await _database!.delete(searchHistoryTable,
        where: '$searchKeyRaw= ?',
        whereArgs: [seacrhHistory.searchKey] as List<String?>);

    return result;
  }
}
