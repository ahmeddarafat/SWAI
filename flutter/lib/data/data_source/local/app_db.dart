import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

class AppDB {
  static const String measurements = "Measurements";
  static const String id = "id";
  static const String heartRate = "Heart Rate";
  static const String oxygenRate = "Oxygen Rate";
  static const String temperature = "Temperature";
  static const String glucoseRate = "Glucose Rate";
  static const String time = "Time";

  static Database? _db;

  Future<Database?> get db async {
    _db ??= await _init();
    return _db;
  }

  Future<Database> _init() async {
    // indinifiy the path of database in you phone sotrage
    String localDb = await getDatabasesPath();
    String pathDb = '$localDb/app.db';
    Database db = await openDatabase(
      pathDb,
      version: 1,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
      readOnly: false,
    );
    return db;
  }

  /// create
  //    - it's executed only one time when initializing the database
  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
    create table '$measurements' (
      '$id' integer not null primary key autoincrement,
      '$heartRate' real not null,
      '$oxygenRate' real not null,
      '$temperature' real not null,
      '$glucoseRate' real not null,
      '$time' integer not null
    )
    ''');
    debugPrint('===============create =============');
  }

  /// upgrade
  //    - it's executed when changing the version of database
  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
//     await db.execute("""
//     alter table notes add column
//       title text
//  """);
//     debugPrint('============ Upgrad ===========');
  }

  /// select
  Future<List<Map<String, Object?>>> selectAll() async {
    String query = "select * from '$measurements'";
    return await _select(query);
  }

  Future<List<Map<String, Object?>>> _select(String query) async {
    Database? mydb = await db;
    List<Map<String, Object?>> data = await mydb!.rawQuery(query);
    return data;
  }

  /// Insert
  Future<int> insert({
    required double heartRate,
    required double oxygenRate,
    required double temperature,
    required double glucoseRate,
    required int time,
  }) async {
    // - the value should be in quotes
    // - Throw error, if you put a comma after the last item ex: (item1, item2, item3 ",")
    String query = """ insert into '$measurements' 
        ('${AppDB.heartRate}', '${AppDB.oxygenRate}', '${AppDB.temperature}', '${AppDB.glucoseRate}','${AppDB.time}') 
        values 
        ($heartRate,$oxygenRate, $temperature, $glucoseRate,$time)
        """;
    return await _insert(query);
  }

  Future<int> _insert(String query) async {
    Database? mydb = await db;
    // - return int (index of row)
    return await mydb!.rawInsert(query);
  }
}



// todo: Draft

/// Delete
// Future<int> deleteAll() async {
//   Database? mydb = await db;
//   return await mydb!.delete("notes");
// }
// Future<int> deleteNote(int atId) async {
//   String query = "Delete from notes where id = $atId";
//   return await _delete(query);
// }
// Future<int> _delete(String query) async {
//   Database? mydb = await db;
//   // return 1 when deleteing
//   //        0 if it dosen't existing
//   return await mydb!.rawDelete(query);
// }
// -------------------------------------
/// Update
// Future<int> update({
//   required int atId,
//   required double heartRate,
//   required double oxygenRate,
//   required double oxygenRate,
//   required double oxygenRate,
// }) async {
//   // - the string variable should be in quotes
//   // - the int variable may be in quotes or not
//   String query =
//       "update '$_measurements' set note = '$note', title = '$title' where id = $atId";
//   return await _update(query);
// }
// Future<int> _update(String query) async {
//   Database? mydb = await db;
//   return await mydb!.rawUpdate(query);
// }
