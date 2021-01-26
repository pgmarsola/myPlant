import 'dart:io';
import 'dart:async';
import 'package:my_plant/models/applications.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseHelper {
  static final _databaseName = "Internal.db";
  static final _databaseVersion = 1;

  static final table = 'programs_table';

  static final columnId = '_id';
  static final columnCod = 'cod';
  static final columnName = 'name';
  static final columnDose = 'dose';
  static final columnApplication = 'application';
  static final columnDate = 'date';
  static final columnAnnotation = 'annotation';
  static final columnDateApplication = 'dateApplication';

  // make this a singleton class
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  // only have a single app-wide reference to the database
  static Database _database;
  Future<Database> get database async {
    if (_database != null) return _database;
    // lazily instantiate the db the first time it is accessed
    _database = await _initDatabase();
    return _database;
  }

  // this opens the database (and creates it if it doesn't exist)
  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
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
            $columnDateApplication TEXT
          )
          ''');
  }

  Future<int> insert(Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.insert(table, row);
  }

  Future<List<Map<String, dynamic>>> getProdsMap() async {
    Database db = await this.database;
    var result = await db.rawQuery("SELECT * FROM $table");
    return result;
  }

  Future<int> updateApplication(Applications applications, int id) async {
    var db = await this.database;
    var result = await db.rawUpdate(
        "UPDATE $table SET $columnCod = '${applications.cod}, $columnName ='${applications.name}', $columnDose = '${applications.dose}', $columnApplication = '${applications.application}', $columnDate = '${applications.date}', $columnAnnotation = '${applications.annotation}', $columnDateApplication = '${applications.dateApplication}' WHERE $columnId = '$id'");
    return result;
  }

  Future<int> update(Map<String, dynamic> row, int id) async {
    Database db = await instance.database;
    return await db.update(table, row, where: '$columnId = ?', whereArgs: [id]);
  }

  Future<int> delete(int id) async {
    Database db = await instance.database;
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

  deleteDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    return await databaseFactory.deleteDatabase(path);
  }
}
