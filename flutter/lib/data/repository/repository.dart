import 'dart:developer';

import 'package:dio/src/response.dart';
import 'package:flutter/material.dart';

import '../data_source/local/local_data_source.dart';
import '../model/article_model.dart';
import '../model/measurements_model.dart';
import '../data_source/remote/api_service.dart';

import '../../resources/constants/app_constants.dart';
import '../network/network_info.dart';

abstract class Repository {
  Future<MeasurementsModel> getMeasurements();
  Future<List<ArticleModel>> getArticles();
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

  @override
  Future<MeasurementsModel> getMeasurements() async {
    if (await _networkInfo.isConnected) {
      final response =
          await _apiService.getData(url: DataConstants.measurementsEndpoint);
      final model = MeasurementsModel.fromJson(response.data);
      _localDataSource.insertData(model);
      return model;
    } else {
      // TODO: network conneciton
      throw Exception("Check your network connection");
    }
  }

  @override
  Future<List<ArticleModel>> getArticles() async {
    List<ArticleModel> articles = List.empty(growable: true);

    if (await _networkInfo.isConnected) {
      final response = await _apiService.getData(
        url: DataConstants.articleEndPoint,
        query: {
          "country": "us",
          "category": "health",
          "apiKey": "5ed9c19376de424a838686529f7ebd6d",
        },
      );
      // int i = 0;
      // log(response.data["articles"]);
      // for (Map<String,dynamic> article in response.data["articles"] as List) {
      //   debugPrint(article.toString()[1]);
      //   debugPrint(i.toString());
      //   i++;
      //   articles.add(ArticleModel.fromJson(article));
      //   debugPrint(articles.toString());
      // }
      // log(articles.toString());
      // log(response.data.runtimeType.toString());
      // log(response.data["articles"].runtimeType.toString());
      // log(response.data["articles"][0].runtimeType.toString());
      log(response.data["articles"][0].toString());
      log("heer");
      log((response.data["articles"] as List)
          .map((element) => ArticleModel.fromJson(element))
          .toList()
          .toString());

      return (response.data["articles"] as List<Map<String, dynamic>>)
          .map((element) => ArticleModel.fromJson(element))
          .toList();
    } else {
      // TODO: network conneciton

      throw Exception("Check your network connection");
    }
  }
}
