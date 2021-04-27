//import 'package:path/path.dart';
//import 'package:sqflite/sqflite.dart';
//
//class DatabaseProvider {
//  static const String tableTransactions = "transactions";
//  static const String columnId = "id";
//  static const String columnTransactions = "alltransactions";
//  static const String columnDate = "date";
//
//  DatabaseProvider._();
//  static final DatabaseProvider db = DatabaseProvider._();
//
//  Database _database;
//  Future<Database> get database async {
//    if (_database != null) {
//      return _database;
//    }
//
//    _database = await createDatabase();
//    return _database;
//  }
//
//  Future<Database> createDatabase() async {
//    String dbPath = await getDatabasesPath();
//    return await openDatabase(
//      join(dbPath, 'transactionsDB.db'),
//      version: 1,
//      onCreate: (Database db, int version) async {
//        print("creating table");
//        await db.execute(
//          """
//          CREATE TABLE $tableTransactions(
//          $columnId INTEGER PRIMARY KEY
//          $columnTransactions REAL
//          $columnDate TEXT
//          )
//          """,
//        );
//      },
//    );
//  }
//}
