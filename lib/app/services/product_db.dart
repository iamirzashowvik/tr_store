import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as p;
import 'package:tr_store/app/data/models/products.dart';

class DatabaseHelper {
  static Database? _database;
  static const int _version = 1;
  static const String _tablename = 'products';

  static Future<void> initDatabase() async {
    if (_database != null) {
      return;
    }
    try {
      var databasesPath = await getDatabasesPath();
      String path = p.join(databasesPath, 'products.db');

      _database =
          await openDatabase(path, version: _version, onCreate: (db, version) {
        return db.execute(
          """CREATE TABLE $_tablename(
            id INTEGER PRIMARY KEY,
            slug TEXT,
            url TEXT,
            title TEXT,
            content TEXT,
            image TEXT,
            thumbnail TEXT,
            status TEXT,
            category TEXT,
            publishedAt TEXT,
            updatedAt TEXT,
            userId INTEGER,
            count INTEGER
          )""",
        );
      });
    } catch (e) {}
  }

  static Future<void> insertProduct(Products product) async {
    try {
      await _database!.insert(
        _tablename,
        product.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } catch (e) {}
  }

  static Future<List<Products>> getAllProducts() async {
    final List<Map<String, dynamic>> maps = await _database!.query(_tablename);

    var products = <Products>[];
    products.assignAll(maps.map((data) => Products.fromJson(data)).toList());
    return products;
  }

  static Future<void> updateProduct(Products product) async {
    await _database!.update(
      _tablename,
      product.toJson(),
      where: 'id = ?',
      whereArgs: [product.id],
    );
  }

  static Future<void> deleteProduct(int id) async {
    await _database!.delete(
      'products',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
