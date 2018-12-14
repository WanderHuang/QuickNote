import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as p;
import 'package:quick_note/constants/index.dart' show dbTableName, dbTaskId, dbTaskDate, dbTaskDetail, dbTaskTitle;

/// create、close your sqlite database, or get the database manager
class DataBaseManager {

  static final DataBaseManager _manager = DataBaseManager._internal();
  DataBaseManager._internal();

  static DataBaseManager get () => _manager;

  Database _db;
  bool hasDb = false;

  Future _init() async {
    String databasesPath = await getDatabasesPath();
    String path = p.join(databasesPath, 'todo-release-1.db');
    _db = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await _createTable(db);
    }, onUpgrade: (Database db, int oldVersion, int newVersion) async {
      await db.execute("DROP TABLE $dbTableName");
      await _createTable(db);
    });
    hasDb = true;
  }

  _createTable(Database db) {
    return db.transaction((Transaction transaction) async {
      transaction.execute("CREATE TABLE $dbTableName ($dbTaskId INTEGER PRIMARY KEY AUTOINCREMENT, $dbTaskTitle TEXT, $dbTaskDetail TEXT, $dbTaskDate TEXT);");
    });
  }

  Future<void> close() async {
    if (!hasDb) return
    _db.close();
  }

  Future<Database> getDatabase() async {
    if (!hasDb) await _init();
    return _db;
  }

}