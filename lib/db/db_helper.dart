import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo/models/task.dart';

class DBHelper {
  static Database? _database;
  static const int _version = 1;
  static const String _tableName = 'tasks';

  // Database creation
  static Future<void> initDb() async {
    if (_database != null) {
      debugPrint('Database already created');
      return;
    }
    
    try {
      final String path = await getDatabasesPath() + '/task.db';
      debugPrint('Database path: $path');
      
      _database = await openDatabase(
        path,
        version: _version,
        onCreate: (Database db, int version) async {
          debugPrint('Creating a new Database');
          await db.execute('''
            CREATE TABLE $_tableName(
              id INTEGER PRIMARY KEY AUTOINCREMENT,
              title TEXT,
              note TEXT,
              date TEXT,
              startTime TEXT,
              endTime TEXT,
              remind INTEGER,
              repeat TEXT,
              color INTEGER,
              isCompleted INTEGER
            )
          ''');
        },
        onUpgrade: (Database db, int oldVersion, int newVersion) async {
          debugPrint('Upgrading database from $oldVersion to $newVersion');
        },
      );
      debugPrint('Database has been created successfully!');
    } catch (e) {
      debugPrint('Error creating database: $e');
      rethrow;
    }
  }

  // Database insert
  static Future<int> insert(Task task) async {
    debugPrint('Insert function called for task: ${task.title}');
    try {
      if (_database == null) {
        throw Exception('Database not initialized');
      }
      return await _database!.insert(_tableName, task.toJson());
    } catch (e) {
      debugPrint('Error inserting task: $e');
      rethrow;
    }
  }

  // Database delete
  static Future<int> delete(Task task) async {
    debugPrint('Delete function called for task: ${task.title}');
    try {
      if (_database == null) {
        throw Exception('Database not initialized');
      }
      return await _database!.delete(
        _tableName,
        where: 'id = ?',
        whereArgs: [task.id],
      );
    } catch (e) {
      debugPrint('Error deleting task: $e');
      rethrow;
    }
  }

  static Future<int> deleteAll() async {
    debugPrint('DeleteAll function called');
    try {
      if (_database == null) {
        throw Exception('Database not initialized');
      }
      final result = await _database!.delete(_tableName);
      debugPrint('All data has been deleted');
      return result;
    } catch (e) {
      debugPrint('Error deleting all tasks: $e');
      rethrow;
    }
  }

  // Database query to select items
  static Future<List<Map<String, dynamic>>> query() async {
    debugPrint('Query function called');
    try {
      if (_database == null) {
        throw Exception('Database not initialized');
      }
      return await _database!.query(_tableName);
    } catch (e) {
      debugPrint('Error querying tasks: $e');
      rethrow;
    }
  }

  // Database update
  static Future<int> update(int id) async {
    debugPrint('Update function called for id: $id');
    try {
      if (_database == null) {
        throw Exception('Database not initialized');
      }
      return await _database!.rawUpdate('''
        UPDATE $_tableName 
        SET isCompleted = ?
        WHERE id = ?
      ''', [1, id]);
    } catch (e) {
      debugPrint('Error updating task: $e');
      rethrow;
    }
  }

  // Close database
  static Future<void> close() async {
    if (_database != null) {
      await _database!.close();
      _database = null;
      debugPrint('Database closed');
    }
  }
}
