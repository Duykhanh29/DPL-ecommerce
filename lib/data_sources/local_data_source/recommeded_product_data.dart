import 'package:dpl_ecommerce/models/recommeded_product.dart';
import 'package:dpl_ecommerce/models/search_history.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

class RecommededSQLiteDatabase {
  static final RecommededSQLiteDatabase instance = RecommededSQLiteDatabase();
  static Database? _database;
  final String recommededProductTable = 'recommededProducts';
  final String idRaw = "id";
  final userIDRow = 'userID';
  final shopIDRaw = 'shopID';
  final categoryIDRaw = 'categoryID';
  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    } else {
      _database = await initialDB();
      return _database!;
    }
  }

  Future<String> getPullPath() async {
    final name = recommededProductTable;
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
    await database.execute("CREATE TABLE $recommededProductTable ("
        "$idRaw INTEGER PRIMARY KEY AUTOINCREMENT,"
        "$userIDRow TEXT,"
        "$categoryIDRaw TEXT,"
        "$shopIDRaw TEXT"
        ")");
  }

  // insert data
  Future<int> insertData(
      {required String uid, String? categoryID, String? shopID}) async {
    final db = await instance.database;
    // var result = await db.rawInsert(
    //     "INSERT INTO $table_name (null,$nameCityRaw,$longitudeRaw,$latitudeRaw)"
    //     " VALUES (?,?,?)",
    //     [city, longitude, latitude],);
    var result = await db.insert(recommededProductTable,
        {userIDRow: uid, categoryIDRaw: categoryID, shopIDRaw: shopID},
        nullColumnHack: idRaw);
    return result;
  }

  Future<bool> isExists(String? categoryID, String? shopID) async {
    final db = await instance.database;
    final result = await db.query(
      instance.recommededProductTable,
      where: '$categoryIDRaw = ? OR $shopIDRaw = ?',
      whereArgs: [categoryID, shopID],
    );

    return result.isNotEmpty;
  }

  Future<List<RecommendedProducts>?> fetchAllData() async {
    final db = await instance.database;
    final data = await db.rawQuery("SELECT * FROM $recommededProductTable");
    return data.map((e) => RecommendedProducts.fromJson(e)).toList();
  }

  Future<List<RecommendedProducts>?> fetchRecentData(int limitNumber) async {
    final db = await instance.database;
    final data = await db.rawQuery(
        "SELECT * FROM $recommededProductTable LIMIT ?", [limitNumber]);
    return data.map((e) => RecommendedProducts.fromJson(e)).toList();
  }

  Future<RecommendedProducts>? fetchDataByID(int id) async {
    final data = await _database!.rawQuery(
        "SELECT * FROM $recommededProductTable WHERE $idRaw = ?", [id]);
    return RecommendedProducts.fromJson(data.first);
  }

  // query
  Future<List<String>> getListCategoryID(
      List<RecommendedProducts> listData) async {
    var query = await _database!
        .query(recommededProductTable, columns: [categoryIDRaw]);
    List<String> list = query.map((e) => e[categoryIDRaw].toString()).toList();
    return list;
  }

  Future<List<String>> getListShopID(List<RecommendedProducts> listData) async {
    var query =
        await _database!.query(recommededProductTable, columns: [shopIDRaw]);
    List<String> list = query.map((e) => e[shopIDRaw].toString()).toList();
    return list;
  }
}
