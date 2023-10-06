import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'package:flutter_03/data/blogmodel.dart';

class DatabaseHelper {
// varible
  static const String blogTable = "blog_table";
  static const String colId = "id";
  static const String colTitle = "title";
  static const String colImageUrl = "imageUrl";

// constructor
  static final DatabaseHelper instance = DatabaseHelper();



  // database

  static Database? _database;

  Future<Database?> get database async {
    _database ??= await _initDatabase();
    return _database;
  }

// Database creation
  Future<Database> _initDatabase() async {
    return openDatabase(
        join(
          await getDatabasesPath(),
          'blogdb',
        ), onCreate: ((db, version) {
      return db.execute('''
        CREATE TABLE $blogTable (
        $colId TEXT PRIMARY KEY,
        $colTitle TEXT,
        $colImageUrl TEXT
      )
    ''');
    }),version: 1);
    
  }

// getblogdata in map
  Future<List<Blog>> getBlogList() async {
    Database? db = await database;

      final List<Map<String, dynamic>> maps = await db!.query(blogTable, orderBy: '$colId ASC');

      return List.generate(maps.length, (i) {
        return Blog(
      id: maps[i]['id'],
      imageUrl: maps[i]['imageUrl'],
      title: maps[i]['title'],
    );
  });
    
  }

// insert blog
  Future<int> insertBlog(Blog blog) async {
    Database? db = await database;
    return db!.insert(
      blogTable,
      {colId: blog.id, colImageUrl: blog.imageUrl, colTitle: blog.title},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

// delete blog
  Future<int> deleteBlog(String id) async {
    Database? db = await database;
    return db!.delete(blogTable, where: '$colId = ?', whereArgs: [id]);
  }

// getCount of blog
  Future<int> getCount() async {
    Database? db = await database;
    return Sqflite.firstIntValue(
            await db!.rawQuery('SELECT COUNT(*) FROM $blogTable')) ??0;
  }


}
