import 'dart:async';
import 'dart:convert';
import 'package:alibtisam/features/store/models/product_model.dart';
import 'package:fpdart/fpdart.dart';
import 'package:logger/logger.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  static Database? _database;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'cart.db');
    return await openDatabase(
      path,
      version: 8,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
    );
  }

  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < newVersion) {
      await db.execute('DROP TABLE IF EXISTS cart');
      await _onCreate(db, newVersion);
    }
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE cart(
        _id TEXT PRIMARY KEY,
        name TEXT,
        images TEXT,
        sizes TEXT,
        colors TEXT,
        customizable TEXT,
        customizationCost INTEGER,
        availableStock INTEGER,
        price REAL,
        category TEXT,
        description TEXT,
        colorsAndSizes TEXT
      )
    ''');
  }

  // CRUD Operations
  Future<void> insertOrUpdateProduct(ProductModel product) async {
    final db = await database;

    // Check if product already exists
    bool exists = await doesProductExist(product.id);

    if (exists) {
      // If it exists, update the quantity
      await db.update(
        'cart',
        product.toMap(), // Ensure `toMap` includes quantity update logic
        where: '_id = ?',
        whereArgs: [product.id],
      );
    } else {
      // If it does not exist, insert it
      await db.insert(
        'cart',
        product.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
  }

  Future<bool> doesProductExist(String id) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'cart',
      where: '_id = ?',
      whereArgs: [id],
    );
    return maps.isNotEmpty;
  }

  Future<List<ProductModel>> getProducts() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('cart');

    return List.generate(maps.length, (i) {
      return ProductModel.fromJson(maps[i]);
    });
  }

  Future<void> updateProduct(ProductModel product) async {
    final db = await database;
    await db.update(
      'cart',
      product.toMap(),
      where: '_id = ?',
      whereArgs: [product.id],
    );
  }

  Future<void> clearCart() async {
    final db = await database;
    await db.delete('cart');
  }

  Future<void> deleteProduct(String id) async {
    final db = await database;
    await db.delete(
      'cart',
      where: '_id = ?',
      whereArgs: [id],
    );
  }
}
