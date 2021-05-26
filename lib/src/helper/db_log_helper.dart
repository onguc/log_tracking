import 'dart:async';
import 'dart:core';

import 'package:log_tracking/src/utils/date_time_util.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DbLogHelper {
  static DbLogHelper _instance = DbLogHelper.internal();
  final int dbVersion = 5;

  factory DbLogHelper() => _instance;

  static Database? _db;

  DbLogHelper.internal();

  static DbLogHelper get instance {
    return _instance;
  }

  static bool isStarted = false;

  Future<Database>? get db async {
    if (_db != null) return _db!;
    _db = await _initDb();
    return _db!;
  }

  Future<Database> _initDb() async {
    try {
      var dbPath = await getDatabasesPath();
      String dbName = "Log.db";
      String path = join(dbPath, dbName);
      var ourDb = await openDatabase(path,
          version: dbVersion,
          onCreate: _onCreate,
          onUpgrade: _onUpgrade,
          onConfigure: _onConfigure);
      return ourDb;
    } catch (e) {
      print(e);
      throw e;
    }
  }

  FutureOr<void> _onCreate(Database db, int version) async {
    await db.execute(createTableLog);
  }

  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < newVersion) {
      if (oldVersion <= 1) {
        await db.execute("ALTER TABLE Log ADD COLUMN version TEXT");
      }

      if (oldVersion <= 4) {
        DateTime beforeAWeek = DateTime.now().subtract(Duration(days: 14));
        String dateTimeString = DateTimeUtil.getDateTimeForLog(beforeAWeek);
        String query = " DELETE FROM Log WHERE dateTime<=?";
        await db.execute(query, [dateTimeString]);
        // try{
        //   // await db.rawQuery("VACUUM");
        //   // await db.execute("VACUUM");
        // }catch (e){
        //   int x=0;
        // }
      }
    }
  }

  Future _onConfigure(Database db) async {
    // await db.execute('PRAGMA foreign_keys = ON');
    // await db.execute("PRAGMA cache_size=10000");
    // await db.execute("PRAGMA temp_store = 2"); //store temp table in memory, not on disk
    // await db.execute("PRAGMA journal_mode=WAL "); //bu çalışmadı. Ama normal androidde çalışıyor galiba.  bu şekilde çalışıyor mu bilmiyorum. Bu olursa eş zamanlı insert vs. olması mümkün olur
  }

  String get createTableLog => ""
      "CREATE TABLE Log ("
      "  id INTEGER PRIMARY KEY AUTOINCREMENT,"
      "  className TEXT,"
      "  methodName TEXT,"
      "  text TEXT, "
      "  dateTime TEXT,"
      "  errorString TEXT, "
      "  logTypeString TEXT, "
      "  stacktraceString TEXT, "
      "  version TEXT"
      ")";
}
