// import 'dart:developer';

import 'app_db.dart';
import '../../model/measurements_model.dart';

class LocalDataSource {
  final AppDB _appDB;
  LocalDataSource(this._appDB);

  void insertData(MeasurementsModel model) {
    int time = DateTime.now().millisecondsSinceEpoch;
    // log("millisecondsSinceEpoch: $time");
    _appDB.insert(
      heartRate: model.heartRate,
      oxygenRate: model.oxygenRate,
      temperature: model.temperature,
      glucoseRate: model.glucoseRate,
      time: time,
    );
  }
}
