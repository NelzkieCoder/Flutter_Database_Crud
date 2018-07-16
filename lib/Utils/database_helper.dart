import 'dart:async';
import 'dart:io';
import 'package:database_crud_sample/Model/user.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DataBaseHelper {
  final String tableUser = "userTable";
  final String columnID = "id";
  final String columnUserName = "username";
  final String columnPassword = "password";

  static final DataBaseHelper instance = new DataBaseHelper.init();

  factory DataBaseHelper() => instance;

  static Database _db;

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDB();
    return _db;
  }

  DataBaseHelper.init();

  initDB() async {
    Directory documentDir = await getApplicationDocumentsDirectory();
    String path = join(documentDir.path, "MainDb.db");

    var ourDB = await openDatabase(path, version: 1, onCreate: _onCreate);
    return ourDB;
  }

  void _onCreate(Database db, int version) async {
    await db.execute(
        "CREATE TABLE $tableUser($columnID INTEGER PRIMARY KEY, $columnUserName TEXT, $columnPassword TEXT)");
  }

  Future<int> saveUser(User user) async {
    var dbClient = await db;
    int result = await dbClient.insert("$tableUser", user.toMap());
    return result;
  }

  Future<List> getAllUsers() async {
    var dbClient = await db;
    var result = await dbClient.rawQuery("SELECT * FROM $tableUser");
    return result.toList();
  }

  Future<int> getCount() async {
    var dbClient = await db;
    return Sqflite.firstIntValue(
        await dbClient.rawQuery("SELECT COUNT(*) from $tableUser"));
  }

  Future<User> getUser(int ID) async {
    var dbClient = await db;
    var result =
        await dbClient.rawQuery("SELECT * FROM $tableUser WHERE $columnID=$ID");
    return result.length == 0 ? null : new User.fromMap(result.first);
  }

  Future<int> deleteUser(int id) async {
    var dbClient = await db;
    return await dbClient
        .delete(tableUser, where: "$columnID = ?", whereArgs: [id]);
  }

  Future<int> updateUser(User user) async {
    var dbClient = await db;
    return await dbClient.update(tableUser, user.toMap(),
        where: "$columnID=?", whereArgs: [user.id]);
  }

  Future close() async {
    var dbClient = await db;
    return dbClient.close();
  }
}
