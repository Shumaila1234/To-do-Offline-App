import 'dart:developer';
import 'dart:io';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseHelper {
  final _databaseName = "todo_offline_app.db";
  static const _databaseVersion = 1;

  static const table = 'taskTb';
  static const taskId = 'id';
  static const taskTitleCol = 'taskTitle';
  static const dateCol = 'date';
  static const timeCol = 'time';
  // static const status = 'status';

  // make this a singleton class
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  // only have a single app-wide reference to the database
  static Database? _database;
  Future<Database?> get database async {
    log("_database  $_database");
    if (_database != null) return _database;
    // lazily instantiate the db the first time it is accessed
    _database = await _initDatabase();
    return _database;
  }

  // this opens the database (and creates it if it doesn't exist)
  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    Database db;
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  // SQL code to create the database table
  Future _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE $table (
            $taskId INTEGER PRIMARY KEY,
            $taskTitleCol TEXT NOT NULL,
            $dateCol TEXT NOT NULL,
            $timeCol TEXT NOT NULL
            
          )
          ''');
  }

  Future<int> insert(Map<String, dynamic> row) async {
    Database? db = await instance.database;
    return await db!.insert(table, row);
  }

  Future<int> insertByQuery(
    String? title,
    String? date,
    String? time,
  ) async {
    Database? db = await instance.database;
    int dataInserted = await db!.rawInsert(
        'INSERT INTO $table ($taskTitleCol, $dateCol, $timeCol) VALUES(?, ?, ?)',
        [title, date, time]);

    log("dataInserted  $dataInserted");
    return dataInserted;
  }

  // All of the rows are returned as a list of maps, where each map is
  // a key-value list of columns.
  Future<List<Map<String, dynamic>>> queryAllRows() async {
    Database? db = await instance.database;
    return await db!.query(table);
  }

  //Get all records which are unsynched
  Future<List<Map<String, dynamic>>> queryUnsynchedRecords() async {
    Database? db = await instance.database;
    return await db!.rawQuery('SELECT id,taskTitle,date,time FROM $table');
  }

  Future<List<Map<String, dynamic>>> queryAllRecords() async {
    Database? db = await instance.database;
    return await db!.rawQuery('SELECT id,taskTitle,date,time FROM $table');
  }

  // We are assuming here that the id column in the map is set. The other
  // column values will be used to update the row.
  Future<int> update(Map<String, dynamic> row) async {
    Database? db = await instance.database;
    int id = row[taskId];
    return await db!.update(table, row, where: '$taskId = ?', whereArgs: [id]);
  }

  Future<int> updateByQuery(
      String? title, String? date, String? time, int noteId) async {
    Database? db = await instance.database;
    int dataUpdated = await db!.rawUpdate(
        'UPDATE $table SET $taskTitleCol = ?, $dateCol = ? , $timeCol = ? WHERE $taskId = ?',
        [title, date, time, noteId]);
    return dataUpdated;
  }

  // Deletes the row specified by the id. The number of affected rows is
  // returned. This should be 1 as long as the row exists.
  Future<int> delete(int id) async {
    Database? db = await instance.database;
    return await db!.delete(table, where: '$taskId = ?', whereArgs: [id]);
  }

  Future<int> deleteByQuery(int id) async {
    Database? db = await instance.database;
    return await db!.rawDelete('DELETE FROM $table WHERE $taskId = ?', [id]);
  }
}
