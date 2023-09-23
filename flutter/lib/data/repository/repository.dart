import 'dart:async';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_solution2/data/model/doctor_info_model.dart';
import 'package:google_solution2/data/model/medicine_model.dart';

import '../data_source/local/local_data_source.dart';
import '../data_source/remote/remote_data_source.dart';
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

  Future<Stream<QuerySnapshot<Map<String, dynamic>>>> getMessages(
    DoctorInfoModel doctor,
  );
  // Future<void> sendMessage(String text);
}

class RepositoryImpl implements Repository {
  final NetworkInfo _networkInfo;
  final RemoteDataSource _remoteDataSource;
  final LocalDataSource _localDataSource;
  RepositoryImpl({
    required NetworkInfo networkInfo,
    required RemoteDataSource remoteDataSource,
    required LocalDataSource localDataSource,
  })  : _localDataSource = localDataSource,
        _networkInfo = networkInfo,
        _remoteDataSource = remoteDataSource;

  /// Using Firebase

  @override
  Future<bool> login(LoginRequest request) async {
    if (await _networkInfo.isConnected) {
      final credential = await _remoteDataSource.login(request);
      if (credential != null) {
        final userInfo =
            await _remoteDataSource.getUserInfo(id: credential.user!.uid);
        await _localDataSource.setUserInfo(
            name: userInfo[0], phone: userInfo[1]);
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
      final credential = await _remoteDataSource.register(request);
      if (credential != null) {
        await _localDataSource.setUserInfo(
            name: request.name, phone: request.phone);
        _remoteDataSource.addUserInfo(
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
      if (await _remoteDataSource.isEmailUsed(email)) {
        return true;
      } else {
        throw CustomException("Email dose not exist");
      }
    } else {
      throw CustomException("Check your network connection");
    }
  }

  /// using restful apis
  @override
  Future<MeasurementsModel> getMeasurements() async {
    if (await _networkInfo.isConnected) {
      final response =
          await _remoteDataSource.getData(endPoint: EndPoints.measurements);
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
    if (await _networkInfo.isConnected) {
      final response =
          await _remoteDataSource.getData(endPoint: EndPoints.articles);
      final articles = (response.data as List)
          .map((article) => ArticleModel.fromJson(article))
          .toList();
      log(articles.toString());
      return articles;
    } else {
      throw CustomException("Check your network connection");
    }
  }

  @override
  Future<List<DoctorInfoModel>> getDoctors() async {
    if (await _networkInfo.isConnected) {
      final response =
          await _remoteDataSource.getData(endPoint: EndPoints.doctors);
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
      final response =
          await _remoteDataSource.getData(endPoint: EndPoints.medicines);
      final medicines = (response.data as List)
          .map((medicine) => MedicineModel.fromJson(medicine))
          .toList();
      log(medicines.toString());
      return medicines;
    } else {
      throw CustomException("Check your network connection");
    }
  }

  @override
  Future<Stream<QuerySnapshot<Map<String, dynamic>>>> getMessages(
      DoctorInfoModel doctor) async {
    if (await _networkInfo.isConnected) {
      log("repo: get mesage");
      return _remoteDataSource.getMessages(doctor);
    } else {
      throw CustomException("Check your network connection");
    }
  }

  // @override
  // Future<void> sendMessage(String text) async {
  //   if (await _networkInfo.isConnected) {
  //     _remoteDataSource.addMessage(text);
  //   } else {
  //     throw CustomException("Check your network connection");
  //   }
  // }
}
