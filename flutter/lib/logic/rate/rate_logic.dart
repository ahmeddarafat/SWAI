import 'dart:developer';

import 'package:google_solution2/data/data_source/local/app_db.dart';

class RateLogic {
  final AppDB _appDB;
  RateLogic({
    required AppDB appDB,
  })  : _appDB = appDB;

  Future<int> getPoints() async {
    List<Map<String, Object?>> data = await _appDB.selectAll();
    log(data.toString());

    return 0;
  }
}
