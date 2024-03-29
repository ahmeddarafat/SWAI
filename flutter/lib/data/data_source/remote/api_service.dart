import 'package:dio/dio.dart';

class EndPoints {
  EndPoints._();

  static const String baseUrl = "https://ahmeddarafat.wiremockapi.cloud/";
  static const String measurements = "/measurements";
  static const String articles = "/articles";
  static const String doctors = "/doctors";
  static const String medicines = "/medicines";
  static const String atricles = "/atricles";
  
}

class Headers {
  Headers._();

  static const String contentType = "content-type";
  static const String applicationJson = "application/json";
  static const String accept = "accept";
}

class ApiService {
  final Dio _dio;

  static Map<String, String> headers = {
    Headers.contentType: Headers.applicationJson,
    Headers.accept: Headers.applicationJson,
  };

  ApiService()
      : _dio = Dio(
          BaseOptions(
            baseUrl: EndPoints.baseUrl,
            headers: headers,
            receiveDataWhenStatusError: true,
            connectTimeout: const Duration(milliseconds: 5000),
            receiveTimeout: const Duration(milliseconds: 5000),
          ),
        );

  Future<Response> getData({
    required String endPoint,
    Map<String, dynamic>? query,
  }) async {
    return await _dio.get(
      endPoint,
      queryParameters: query,
    );
  }
}
