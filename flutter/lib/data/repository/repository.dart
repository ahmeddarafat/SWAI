import 'dart:developer';

// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:google_solution2/data/error_handler/error_handler.dart';
// import 'package:google_solution2/data/model/requests_model.dart';

import 'package:google_solution2/data/data_source/remote/firebase_service.dart';
import 'package:google_solution2/data/model/doctor_info_model.dart';
import 'package:google_solution2/data/model/medicine_model.dart';
import 'package:google_solution2/resources/di/di.dart';

import '../data_source/local/app_prefs.dart';
import '../data_source/local/local_data_source.dart';
import '../error_handler/error_handler.dart';
import '../model/article_model.dart';
import '../model/measurements_model.dart';
import '../data_source/remote/api_service.dart';

import '../model/requests_model.dart';
import '../network/network_info.dart';

abstract class Repository {
  Future<bool> login(LoginRequest request);
  Future<bool> register(RegisterRequest request);
  Future<bool> forgotPassword(String email);

  Future<MeasurementsModel> getMeasurements();
  Future<List<ArticleModel>> getArticles();
  Future<List<DoctorInfoModel>> getDoctors();
  Future<List<MedicineModel>> getMedicines();
}

class RepositoryImpl implements Repository {
  final ApiService _apiService;
  final NetworkInfo _networkInfo;
  final LocalDataSource _localDataSource;
  RepositoryImpl({
    required ApiService apiService,
    required NetworkInfo networkInfo,
    required LocalDataSource localDataSource,
  })  : _localDataSource = localDataSource,
        _networkInfo = networkInfo,
        _apiService = apiService;

  /// Using Firebase
  var firebaseService = getIt<FirebaseService>();
  var appPrefs = getIt<AppPrefs>();

  @override
  Future<bool> login(LoginRequest request) async {
    if (await _networkInfo.isConnected) {
      final credential = await firebaseService.login(request);
      if (credential != null) {
        final userInfo =
            await firebaseService.getUserInfo(id: credential.user!.uid);
        await appPrefs.setUserInfo(name: userInfo[0], phone: userInfo[1]);
        return true;
      }
    } else {
      throw CustomException("Check your network connection");
    }
    return false;
  }

  @override
  Future<bool> register(RegisterRequest request) async {
    if (await _networkInfo.isConnected) {
      final credential = await firebaseService.register(request);
      if (credential != null) {
        await appPrefs.setUserInfo(name: request.name, phone: request.phone);
        firebaseService.addUserInfo(
          id: credential.user!.uid,
          request: request,
        );
        return true;
      }
    } else {
      throw CustomException("Check your network connection");
    }
    return false;
  }

  @override
  Future<bool> forgotPassword(String email) async {
    if (await _networkInfo.isConnected) {
      if (await firebaseService.isEmailUsed(email)) {
        return true;
      } else {
        throw CustomException("Email dose not exist");
      }
    } else {
      throw CustomException("Check your network connection");
    }
  }

  @override
  Future<MeasurementsModel> getMeasurements() async {
    if (await _networkInfo.isConnected) {
      final response =
          await _apiService.getData(endPoint: EndPoints.measurements);
      final model = MeasurementsModel.fromJson(response.data);
      _localDataSource.insertPointsData(model);
      return model;
    } else {
      // TODO: network conneciton
      throw Exception("Check your network connection");
    }
  }

  @override
  Future<List<ArticleModel>> getArticles() async {
    try {
      return _localDataSource.getArticlesData();
    } catch (cacheError) {
      log(cacheError.toString());
      if (await _networkInfo.isConnected) {
        final response =
            await _apiService.getData(endPoint: EndPoints.articles);
        final articles = (response.data["articles"] as List)
            .map((element) => ArticleModel.fromJson(element))
            .toList();
        _localDataSource.setArticlesData(articles);
        return articles;
      } else {
        throw CustomException("Check your network connection");
      }
    }
  }

  @override
  Future<List<DoctorInfoModel>> getDoctors() async {
    if (await _networkInfo.isConnected) {
      final response = await _apiService.getData(endPoint: EndPoints.doctors);
      final doctors = (response.data as List)
          .map((element) => DoctorInfoModel.fromJson(element))
          .toList();
      log(doctors.toString());
      return doctors;
    } else {
      throw CustomException("Check your network connection");
    }
  }

  @override
  Future<List<MedicineModel>> getMedicines() async {
    if (await _networkInfo.isConnected) {
      final response = await _apiService.getData(endPoint: EndPoints.medicines);
      final medicines = (response.data as List)
          .map((medicine) => MedicineModel.fromJson(medicine))
          .toList();
      log(medicines.toString());
      return medicines;
    } else {
      throw CustomException("Check your network connection");
    }
  }
}
