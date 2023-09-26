import 'package:google_solution2/data/data_source/local/app_db/constants_db.dart';


class PointModel {
  final double number;
  final DateTime time;
  PointModel(this.time, this.number);

  @override
  String toString() {
    return "Point($number,$time)";
  }
}

class CompletePointModel {
  final double heartRate;
  final double temperature;
  final double oxygenRate;
  final double glucoseRate;
  final DateTime time;

  CompletePointModel({
    required this.heartRate,
    required this.temperature,
    required this.oxygenRate,
    required this.glucoseRate,
    required this.time,
  });

  factory CompletePointModel.fromDB(Map<String, dynamic> map) {
    DateTime t = DateTime.fromMillisecondsSinceEpoch(map[ConstantsDB.time]);
    return CompletePointModel(
      heartRate: map[ConstantsDB.heartRate],
      temperature: map[ConstantsDB.temperature],
      oxygenRate: map[ConstantsDB.oxygenRate],
      glucoseRate: map[ConstantsDB.glucoseRate],
      time: t,
    );
  }
}
