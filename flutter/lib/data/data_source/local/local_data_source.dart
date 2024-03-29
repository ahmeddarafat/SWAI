// import 'dart:developer';

import 'package:google_solution2/data/data_source/local/app_cache/app_cache.dart';
import 'package:google_solution2/data/data_source/local/app_db/constants_db.dart';

import '../../model/article_model.dart';
import 'app_db/app_db.dart';
import '../../model/measurements_model.dart';
import 'app_prefs/app_prefs.dart';

abstract class LocalDataSource {
  /// App DB
  void insertPointsData(MeasurementsModel model);
  Future<void> insertToCart(int medicineId);
  Future<void> updateToCart({required int medicineId, required int newCount});
  Future<List<Map<String, Object?>>> getAllCartItem();

  /// App Cache
  List<ArticleModel> getArticlesData();
  void setArticlesData(List<ArticleModel> articles);
  void clearCache();
  void removeFromCache(String key);

  /// App Prefs
  Future<void> setOnBoardingViewed();
  bool isOnBoardingViewed();
  Future<void> setUserLoggedIn();
  bool isUserLoggedIn();
  Future<void> logout();
  Future<void> setUserInfo({
    required String name,
    required String phone,
  });
  List<String> getUserInfo();
}

class LocalDataSourceImpl implements LocalDataSource {
  final AppDB _appDB;
  final AppCahce _appCahce;
  final AppPrefs _appPrefs;
  LocalDataSourceImpl({
    required AppDB appDB,
    required AppCahce appCahce,
    required AppPrefs appPrefs,
  })  : _appDB = appDB,
        _appCahce = appCahce,
        _appPrefs = appPrefs;

  @override
  void insertPointsData(MeasurementsModel model) {
    int time = DateTime.now().millisecondsSinceEpoch;
    // log("millisecondsSinceEpoch: $time");
    _appDB.insertMeasurementTable(
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

  /// OnBoarding
  @override
  Future<void> setOnBoardingViewed() async {
    await _appPrefs.setOnBoardingViewed();
  }

  @override
  bool isOnBoardingViewed() {
    return _appPrefs.isOnBoardingViewed();
  }

  /// Auth
  @override
  Future<void> setUserLoggedIn() async {
    await _appPrefs.setUserLoggedIn();
  }

  @override
  bool isUserLoggedIn() {
    return _appPrefs.isUserLoggedIn();
  }

  @override
  Future<void> logout() async {
    await _appPrefs.logout();
  }

  /// user info
  @override
  Future<void> setUserInfo({
    required String name,
    required String phone,
  }) async {
    await _appPrefs.setUserInfo(name: name, phone: phone);
  }

  @override
  List<String> getUserInfo() {
    return _appPrefs.getUserInfo();
  }

  @override
  Future<void> insertToCart(int medicineId) async {
    await _appDB.insertCartTable(medicineId: medicineId);
  }

  @override
  Future<void> updateToCart(
      {required int medicineId, required int newCount}) async {
    await _appDB.updateCartTable(medicineId: medicineId, count: newCount);
  }

  Future<List<Map<String, Object?>>> getAllCartItem() async {
    return await _appDB.selectAll(ConstantsDB.cartTable);
  }
}
