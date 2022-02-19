import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo/models/task.dart';

class DBHelper {
  static Database? _database;
  static const int _version = 1;
  static const String _tableName = 'tasks';

//database create
  static Future<void> initDb() async {
    if (_database != null) {
      debugPrint('Database already created');
      return;
    } else {
      try {
        String _path = await getDatabasesPath() + 'task.db';
        debugPrint('in database path');
        _database = await openDatabase(_path, version: _version,
            onCreate: (Database db, int version) async {
          debugPrint('Creating a new Database');
          return db.execute(
              'CREATE TABLE $_tableName(id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, note TEXT, date TEXT, startTime TEXT, endTime TEXT, remind INTEGER, repeat TEXT, color INTEGER, isCompleted INTEGER)');
        });
        print('Database has Created !');
      } catch (e) {
        print(e);
      }
    }
  }

//database insert
  static Future<int> insert(Task? task) async {
    print('insert function called');
    try {
      return await _database!.insert(_tableName, task!.toJson());
    } catch (e) {
      print('we here');
      return 90000;
    }
  }

//database delete
  static Future<int> delete(Task task) async {
    print('delete function called');
    return await _database!
        .delete(_tableName, where: 'id = ?', whereArgs: [task.id]);
  }

  static Future<int> deleteAll() async {
    print('deleteAll function called \n and all data has deleted');
    return await _database!.delete(_tableName);
  }

  //database query to select items
  static Future<List<Map<String, dynamic>>> query() async {
    print('query function called');
    return await _database!.query(_tableName);
  }

//database update
  static Future<int> update(int id) async {
    print('updatefunction called');
    return await _database!.rawUpdate('''
 update $_tableName 
 set isCompleted = ?
 where id = ?
 ''', [1, id]);
  }
}
