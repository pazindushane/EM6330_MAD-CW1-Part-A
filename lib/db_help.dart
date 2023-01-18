import 'dart:io';

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

import 'Model.dart';


class Db_help{
  Db_help._privateConstructor();
  static final Db_help instance =Db_help._privateConstructor();

  static Database? _database;

  Future<Database> get database async => _database ??= await _initDatabase();

  Future<Database> _initDatabase() async{
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path =join(documentDirectory.path,'app.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }
  Future _onCreate(Database db,int version) async {
    await db.execute('''
    CREATE TABLE model(
      id INTEGER PRIMARY KEY,
      name TEXT,
      number TEXT,
      email TEXT,
      imgPath TEXT
    )
    ''');
  }

  Future<List<Model>> getUsers() async{
    Database db =await instance.database;
    var contacts = await db.query('model', orderBy: 'name');
    List<Model> contactList = contacts.isNotEmpty
        ? contacts.map((c) => Model.fromMap(c)).toList()
        : [];
    return contactList;
  }
  Future<int> add(Model user) async {
    Database db = await instance.database;
    return await db.insert('model', user.toMap());
  }
  Future<int> delete(int id) async {
    Database db = await instance.database;
    return await db.delete('model',where: "id = ?", whereArgs: [id]);
  }
  Future<int> update(Model user) async {
    Database db = await instance.database;
    return await db.update('model', user.toMap(),
        where: "id = ?", whereArgs: [user.id]);
  }

  Future<List<Model>> searchContacts(String keyword) async {
    Database db = await instance.database;
    // final db = await dbProvider.database;
    List<Map<String, dynamic>> allRows = await db
        .query('model', where: 'name LIKE ?', whereArgs: ['%$keyword%']);
    List<Model> contacts =
    allRows.map((contact) => Model.fromMap(contact)).toList();
    return contacts;
  }

}