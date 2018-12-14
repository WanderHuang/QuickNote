import 'package:sqflite/sqflite.dart';
import 'package:quick_note/database/db_manager.dart';
import 'package:quick_note/models/task.dart';
import 'package:quick_note/constants/index.dart' show dbTableName, dbTaskId, dbTaskDate, dbTaskDetail, dbTaskTitle;
/// Task database operations
class TaskDbManager {
  static Future<bool> delete(int id) async {
    Database db = await DataBaseManager.get().getDatabase();
    if (id == null) {
      return false;
    } else {
      try {
        await db.transaction((Transaction transaction) async {
          await transaction.rawDelete('DELETE FROM $dbTableName WHERE $dbTaskId = $id;');
        });
      } catch(e) {
        print('DELETE ERROR');
        print(e);
        return false;
      }
      return true;
    }
  }

  static Future<List<Task>> getAll() async {
    Database db = await DataBaseManager.get().getDatabase();
    List<Map<String, dynamic>> result = await db.rawQuery('SELECT * FROM $dbTableName');
    List<Task> _list = List();
    for (Map<String, dynamic> map in result) {
      _list.add(Task.fromMap(map));
    }
    return _list;
  }

  static Future insert(Task item) async {
    Database db = await DataBaseManager.get().getDatabase();
    try {
      await db.transaction((Transaction transaction) async {
        await transaction.rawInsert('INSERT INTO $dbTableName($dbTaskTitle,$dbTaskDetail,$dbTaskDate) VALUES("${item.title}", "${item.detail}", "${item.date}");');
      });
    } catch (e) {
      print('INSERT ERROR');
      print(e);
      return false;
    }
    return true;
  }

  static Future update(Task item) async {
    Database db = await DataBaseManager.get().getDatabase();
    try {
      await db.transaction((Transaction transaction) async {
        await transaction.rawInsert('UPDATE $dbTableName SET $dbTaskTitle = "${item.title}", $dbTaskDetail = "${item.detail}", $dbTaskDate = "${item.date}" WHERE $dbTaskId = ${item.id}');
      });
    } catch (e) {
      print('UPDATE ERROR');
      print(e);
      return false;
    }
    return true;
  }
}