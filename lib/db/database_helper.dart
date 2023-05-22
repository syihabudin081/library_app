import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static const String _dbName = 'libApp.db';
  static const String _tableName = 'users';

  late Database _database;

  Future<void> _initializeDatabase() async {
    String databasePath = await getDatabasesPath();
    String path = join(databasePath, _dbName);

    _database = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        db.execute(
          'CREATE TABLE $_tableName (id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, username TEXT, password TEXT)',
        );
      },
    );
  }

  Future<void> insertUser(User user) async {
    await _initializeDatabase();

    await _database.insert(
      _tableName,
      user.toMap(),
    );
  }

  Future<User?> getUserByUsername(String username) async {
    await _initializeDatabase();

    List<Map<String, dynamic>> users = await _database.query(
      _tableName,
      where: 'username = ?',
      whereArgs: [username],
    );

    if (users.isNotEmpty) {
      return User.fromMap(users.first);
    }

    return null;
  }
}

class User {
  final String name;
  final String username;
  final String password;

  User({
    required this.name,
    required this.username,
    required this.password,
  });

  Map<String, dynamic> toMap() {
    return {
      'name' : name,
      'username': username,
      'password': password,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      name: map['name'],
      username: map['username'],
      password: map['password'],
    );
  }
}