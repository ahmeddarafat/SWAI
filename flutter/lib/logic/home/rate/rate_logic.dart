import 'dart:developer';

import 'package:google_solution2/data/data_source/local/app_db/constants_db.dart';
import 'package:google_solution2/resources/constants/app_constants.dart';

import '../../../data/data_source/local/app_db/app_db.dart';
import '../../../data/model/point_model.dart';
import '../../../data/model/statistics_model.dart';

import '../../../resources/constants/app_strings.dart';

class RateLogic {
  final AppDB _appDB;
  RateLogic({
    required AppDB appDB,
  }) : _appDB = appDB;

  Future<StatisticsModel> getStatistics(String title) async {
    List<PointModel> points = await getPoints(title);
    double max = 0, min = 0, avg = 0;
    for (var p in points) {
      min = p.number;
      avg += p.number;
      if (p.number > max) max = p.number;
      if (p.number < min) min = p.number;
    }
    avg /= points.length;
    max = double.parse(max.toStringAsFixed(1));
    min = double.parse(min.toStringAsFixed(1));
    avg = double.parse(avg.toStringAsFixed(1));
    return StatisticsModel(max: max, min: min, avg: avg);
  }

  Future<List<PointModel>> getPoints(String title) async {
    List<CompletePointModel> completePoints = await _convertPoints();
    List<PointModel> points = [];
    switch (title) {
      case AppStrings.heartRate:
        for (var p in completePoints) {
          points.add(PointModel(p.time, p.heartRate));
        }
        break;
      case AppStrings.temperature:
        for (var p in completePoints) {
          points.add(PointModel(p.time, p.temperature));
        }
        break;
      case AppStrings.oxygenRate:
        for (var p in completePoints) {
          points.add(PointModel(p.time, p.oxygenRate));
        }
        break;
      case AppStrings.glucoseRate:
        for (var p in completePoints) {
          points.add(PointModel(p.time, p.glucoseRate));
        }
        break;
      default:
        break;
    }
    log(points.toString());
    return points;
  }

  Future<List<CompletePointModel>> _convertPoints() async {
    List<Map<String, Object?>> data = await _appDB.selectAll(ConstantsDB.measurementsTable);
    List<CompletePointModel> points = [];

    for (var element in data) {
      points.add(CompletePointModel.fromDB(element));
    }
    return points;
  }
}
