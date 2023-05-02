import '../data_source/local/app_db.dart';

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
    DateTime t = DateTime.fromMillisecondsSinceEpoch(map[AppDB.time]);
    return CompletePointModel(
      heartRate: map[AppDB.heartRate],
      temperature: map[AppDB.temperature],
      oxygenRate: map[AppDB.oxygenRate],
      glucoseRate: map[AppDB.glucoseRate],
      time: t,
    );
  }
}
