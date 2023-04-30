import 'package:dio/dio.dart';

import '../../resources/constants/app_constants.dart';

class ApiService {
  static late Dio _dio;

  static Map<String, String> headers = {
    DataConstants.contentType: DataConstants.applicationJson,
    DataConstants.accept: DataConstants.applicationJson,
  };

  static Future<void> init() async {
    _dio = Dio(
      BaseOptions(
        baseUrl: DataConstants.baseUrl,
        headers: headers,
        receiveDataWhenStatusError: true,
        connectTimeout: const Duration(milliseconds: 3600),
        receiveTimeout: const Duration(milliseconds: 3600),
      ),
    );
  }

  Future<Response> getData({
    required String url,
    Map<String, dynamic>? query,
  }) async {
    return await _dio.get(
      url,
      queryParameters: query,
    );
  }
}
