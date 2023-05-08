// import 'dart:developer';

import 'package:google_solution2/data/data_source/local/app_cache.dart';

import '../../model/article_model.dart';
import 'app_db.dart';
import '../../model/measurements_model.dart';

abstract class LocalDataSource {
  /// status Page
  void insertPointsData(MeasurementsModel model);

  /// Articles Page
  List<ArticleModel> getArticlesData();
  void setArticlesData(List<ArticleModel> articles);
  void clearCache();
  void removeFromCache(String key);
}

class LocalDataSourceImpl implements LocalDataSource {
  final AppDB _appDB;
  final AppCahce _appCahce;
  LocalDataSourceImpl({
    required AppDB appDB,
    required AppCahce appCahce,
  })  : _appDB = appDB,
        _appCahce = appCahce;

  @override
  void insertPointsData(MeasurementsModel model) {
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

  @override
  void clearCache() {
    _appCahce.clearCache();
  }

  @override
  void removeFromCache(String key) {
    _appCahce.removeFromCache(key);
  }

  @override
  List<ArticleModel> getArticlesData() {
    return _appCahce.getArticlesData();
  }

  @override
  void setArticlesData(List<ArticleModel> articles) {
    _appCahce.setArticlesData(articles);
  }
}
