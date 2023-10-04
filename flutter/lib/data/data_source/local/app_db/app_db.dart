import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

import 'constants_db.dart';

class AppDB {
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
      version: 2,
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
    create table '${ConstantsDB.measurementsTable}' (
      '${ConstantsDB.id}' integer not null primary key autoincrement,
      '${ConstantsDB.heartRate}' real not null,
      '${ConstantsDB.oxygenRate}' real not null,
      '${ConstantsDB.temperature}' real not null,
      '${ConstantsDB.glucoseRate}' real not null,
      '${ConstantsDB.time}' integer not null
    )
    ''');
    debugPrint('=============== create =============');
  }

  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    await db.execute('''
    create table '${ConstantsDB.cartTable}' (
      '${ConstantsDB.id}' integer not null primary key autoincrement,
      '${ConstantsDB.medicineId}' integer not null,
      '${ConstantsDB.countsOfProduct}' integer not null
    )
    ''');
    debugPrint('=============== onUpgrade =============');
  }

  /// select
  Future<List<Map<String, Object?>>> selectAll(String table) async {
    String query = "select * from '$table'";
    return await _select(query);
  }

  Future<List<Map<String, Object?>>> _select(String query) async {
    Database? mydb = await db;
    List<Map<String, Object?>> data = await mydb!.rawQuery(query);
    return data;
  }

  /// Insert
  Future<int> insertMeasurementTable({
    required double heartRate,
    required double oxygenRate,
    required double temperature,
    required double glucoseRate,
    required int time,
  }) async {
    // - the value should be in quotes
    // - Throw error, if you put a comma after the last item ex: (item1, item2, item3 ",")
    String query = """ insert into '${ConstantsDB.measurementsTable}' 
        ('${ConstantsDB.heartRate}', '${ConstantsDB.oxygenRate}', '${ConstantsDB.temperature}', '${ConstantsDB.glucoseRate}','${ConstantsDB.time}') 
        values 
        ($heartRate,$oxygenRate, $temperature, $glucoseRate,$time)
        """;
    return await _insert(query);
  }

  Future<int> insertCartTable({
    required int medicineId,
  }) async {
    // - the value should be in quotes
    // - Throw error, if you put a comma after the last item ex: (item1, item2, item3 ",")
    String query = """ insert into '${ConstantsDB.cartTable}' 
        ('${ConstantsDB.medicineId}', '${ConstantsDB.countsOfProduct}') 
        values 
        ($medicineId, 1)
        """;
    return await _insert(query);
  }

  Future<int> _insert(String query) async {
    Database? mydb = await db;
    // - return int (index of row)
    return await mydb!.rawInsert(query);
  }

  /// Update
  Future<int> updateCartTable({
    required int medicineId,
    required int count,
  }) async {
    // - the string variable should be in quotes
    // - the int variable may be in quotes or not
    String query =
        "update '${ConstantsDB.cartTable}' set '${ConstantsDB.countsOfProduct}' = $count where '${ConstantsDB.medicineId}' = $medicineId";
    return await _update(query);
  }

  Future<int> _update(String query) async {
    Database? mydb = await db;
    return await mydb!.rawUpdate(query);
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
