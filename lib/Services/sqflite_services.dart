import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart' as sql;

class SQLHelper {
  static Future<void> createTables(sql.Database database) async {
    await database.execute("""CREATE TABLE userWalletInfo(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        userID TEXT,
        userPassword TEXT,
        createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
      )
      """);
  }
// id: the id of a item
// title, description: name and description of your activity
// created_at: the time that the item was created. It will be automatically handled by SQLite

  static Future<sql.Database> db() async {
    return sql.openDatabase(
      'satoshiAirline.db',
      version: 1,
      onCreate: (sql.Database database, int version) async {
        await createTables(database);
      },
    );
  }

  // Create new item (journal)
  static Future<int> createInfo(String uid, String? uPassword) async {
    final db = await SQLHelper.db();

    final data = {'userId': uid, 'userPassword': uPassword};
    final id = await db.insert('userWalletInfo', data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return id;
  }

  // Read all Info
  static Future<List<Map<String, dynamic>>> getAllInfo() async {
    final db = await SQLHelper.db();
    return db.query('userWalletInfo', orderBy: "id");
  }

  // Read a single Info by Userid
  static Future<List<Map<String, dynamic>>> getInfoById(String id) async {
    final db = await SQLHelper.db();
    return db.query('userWalletInfo', where: "userId = ?", whereArgs: [id], limit: 1);
  }

  // Update an item by id
  static Future<void> updateInfo(String userID, String? uPassword) async {
    try{
      final db = await SQLHelper.db();

    final data = {
      'userPassword': uPassword,
      'createdAt': DateTime.now().toString()
    };

    await db.update('userWalletInfo', data, where: "userId = ?", whereArgs: [userID]);
    } catch (err) {
      debugPrint("Something went wrong when update an info: $err");
    }
  }

  // Delete
  static Future<void> deleteItem(int id) async {
    final db = await SQLHelper.db();
    try {
      await db.delete("userWalletInfo", where: "userId = ?", whereArgs: [id]);
    } catch (err) {
      debugPrint("Something went wrong when deleting an item: $err");
    }
  }
}