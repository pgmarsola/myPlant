import 'dart:io';
import 'dart:async';
import 'package:my_plant/models/applications.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseHelper {
  static DatabaseHelper _databaseHelper;
  static Database _database;

  static final table = 'programs_table';

  static final columnId = '_id';
  static final columnCod = 'cod';
  static final columnName = 'name';
  static final columnDose = 'dose';
  static final columnApplication = 'application';
  static final columnDate = 'date';
  static final columnAnnotation = 'annotation';
  static final columnDateApplication = 'dateApplication';
  static final columnPolygons = "polygons";
  static final columnLongB = "longB";
  static final columnLatB = "latB";

  DatabaseHelper._createInstance();
  factory DatabaseHelper() {
    if (_databaseHelper == null) {
      _databaseHelper = DatabaseHelper._createInstance();
    }

    return _databaseHelper;
  }

  Future<Database> get database async {
    if (_database == null) {
      _database = await initDb();
    }

    return _database;
  }

  Future<Database> initDb() async {
    Directory diretorio = await getApplicationDocumentsDirectory();
    String path = diretorio.path + 'programs.db';

    var dbTarefas = await openDatabase(path, version: 1, onCreate: _onCreate);
    return dbTarefas;
  }

  // SQL code to create the database table
  Future _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE IF NOT EXISTS $table (
            $columnId INTEGER PRIMARY KEY,
            $columnCod INTEGER,
            $columnName TEXT,
            $columnDose TEXT,
            $columnApplication INTEGER,
            $columnDate TEXT,
            $columnAnnotation TEXT,
            $columnDateApplication TEXT,
            $columnPolygons TEXT,
            $columnLongB TEXT,
            $columnLatB TEXT
          )
          ''');
  }

  Future<int> insert(Map<String, dynamic> row) async {
    Database db = await this.database;
    return await db.insert(table, row);
  }

  Future<List<Map<String, dynamic>>> getProdsMap() async {
    Database db = await this.database;
    var result = await db.rawQuery("SELECT * FROM $table");
    return result;
  }

  Future<int> update(Map<String, dynamic> row, int id) async {
    Database db = await this.database;
    return await db.update(table, row, where: '$columnId = ?', whereArgs: [id]);
  }

  Future<int> delete(int id) async {
    Database db = await this.database;
    return await db.delete(table, where: '$columnId = ?', whereArgs: [id]);
  }

  Future<List<Applications>> getProds() async {
    var prodsMapList = await getProdsMap();
    int count = prodsMapList.length;
    List<Applications> applications = <Applications>[];
    for (int i = 0; i < count; i++) {
      applications.add(Applications.fromMap(prodsMapList[i]));
    }
    return applications;
  }
}
