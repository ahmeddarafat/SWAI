import 'package:dio/dio.dart';
import '../../app/constants.dart';

class ApiService {
  static late Dio _dio;

  static Map<String, String> headers = {
    Constants.contentType: Constants.applicationJson,
    Constants.accept: Constants.applicationJson,
  };

  static Future<void> init() async {
    _dio = Dio(
      BaseOptions(
        baseUrl: Constants.baseUrl,
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
