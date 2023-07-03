import 'dart:developer';

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
  final LocalDataSourceImpl _localDataSource;
  RepositoryImpl({
    required ApiService apiService,
    required NetworkInfo networkInfo,
    required LocalDataSourceImpl localDataSource,
  })  : _localDataSource = localDataSource,
        _networkInfo = networkInfo,
        _apiService = apiService;

  @override
  Future<MeasurementsModel> getMeasurements() async {
    if (await _networkInfo.isConnected) {
      final response =
          await _apiService.getData(url: DataConstants.measurementsEndpoint);
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
            await _apiService.getData(url: DataConstants.articlesEndpoint);
        final articles = (response.data["articles"] as List)
            .map((element) => ArticleModel.fromJson(element))
            .toList();
        _localDataSource.setArticlesData(articles);
        return articles;
      } else {
        // TODO: network conneciton
        throw Exception("Check your network connection");
      }
    }
  }
}
