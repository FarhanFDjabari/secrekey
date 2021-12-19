import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:secrekey/data/models/generated_key_model.dart';
import 'package:secrekey/util/encrypt.dart';
import 'package:sqflite_common_porter/sqflite_porter.dart';
import 'package:sqflite_sqlcipher/sqflite.dart';

class SecreKeyLocalDB {
  static SecreKeyLocalDB? _secreKeyLocalDB;

  SecreKeyLocalDB._instance() {
    _secreKeyLocalDB = this;
  }

  factory SecreKeyLocalDB() => _secreKeyLocalDB ?? SecreKeyLocalDB._instance();

  static Database? _database;

  Future<Database?> get database async {
    _database ??= await _initDb();
    return _database;
  }

  Future<Database> _initDb() async {
    final path = await getDatabasesPath();
    final databasePath = '$path/secrekeyDB.db';

    var db = await openDatabase(
      databasePath,
      version: 1,
      onCreate: _onCreate,
      password: encrypt('SECRET'),
    );
    return db;
  }

  void _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE secrekey_user (
        id INTEGER PRIMARY KEY,
        key TEXT NOT NULL,
        description TEXT NOT NULL
      );
    ''');
  }

  Future<List<Map<String, dynamic>>?> getKeyFromDB() async {
    final db = await database;
    final results = await db!.query(
      'secrekey_user',
    );

    if (results.isNotEmpty) {
      return results;
    } else {
      return null;
    }
  }

  Future<Map<String, dynamic>?> getKeyFromDbByKey(String key) async {
    final db = await database;
    final results = await db!.query(
      'secrekey_user',
      where: 'key = ?',
      whereArgs: [key],
    );

    if (results.isNotEmpty) {
      return results.first;
    } else {
      return null;
    }
  }

  Future<int> insertKeyToDB(GeneratedKeyModel generatedKey) async {
    final db = await database;
    return await db!.insert('secrekey_user', generatedKey.toJson());
  }

  Future<int> removeKeyFromDB(GeneratedKeyModel generatedKey) async {
    final db = await database;
    return await db!.delete(
      'secrekey_user',
      where: 'id = ?',
      whereArgs: [generatedKey.id],
    );
  }

  Future<String> exportDB() async {
    final db = await database;
    var export = await dbExportSql(db!);
    String dir = (await getExternalStorageDirectory())!.absolute.path +
        "/secrekey_backup";
    File f = File(
        dir + "secrekey_${DateTime.now().year}-${DateTime.now().month}.sql");
    f.writeAsString(export.toString());
    return f.absolute.path;
  }

  Future<String> importDB(String directory) async {
    final db = await database;
    final input = File(directory).openRead();
    final fields = await input.transform(utf8.decoder).toList();
    var import = await dbImportSql(db!, fields);
    return '$import';
  }

  Future<List<dynamic>> insertAll(String table, List<dynamic> objects) async {
    List<dynamic> listRes = [];
    final db = await database;
    List res;
    try {
      await db!.transaction((db) async {
        for (var obj in objects) {
          try {
            var iRes = await db.insert(table, obj.toMap());
            listRes.add(iRes);
          } catch (ex) {
            log("Error! $ex");
          }
        }
      });
      log("$listRes");
      res = listRes;
      return res;
    } catch (er) {
      log("Error! $er");
      return [];
    }
  }
}
