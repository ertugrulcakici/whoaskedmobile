import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:whoaskedmobile/product/constants/app_constants.dart';

final class ApiService {
  // singleton
  static final ApiService _instance = ApiService._();
  factory ApiService() => _instance;
  ApiService._();
  static ApiService get instance => _instance;

  Dio _dio = Dio(
    BaseOptions(
      baseUrl: AppConstants.baseUrl,
      // receiveTimeout: const Duration(seconds: 3),
      // connectTimeout: const Duration(seconds: 3),
    ),
  );

  void setBearerToken(String token) {
    // _dio.options.headers["Authorization"] = "Bearer $token";
    _dio = Dio(
      BaseOptions(
        baseUrl: AppConstants.baseUrl,
        // receiveTimeout: const Duration(seconds: 3),
        // connectTimeout: const Duration(seconds: 3),
        headers: {"Authorization": "Bearer $token"},
      ),
    );
  }

  Future<Response<T>> get<T>(String path,
      {Map<String, dynamic>? queryParameters}) async {
    try {
      final Response<T> response =
          await _dio.get<T>(path, queryParameters: queryParameters);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response<T>> post<T>(String path, Map<String, dynamic> data) async {
    try {
      log(path);
      log(data.toString());
      log(_dio.options.headers.toString());
      log(_dio.options.baseUrl);
      final Response<T> response = await _dio.post<T>(path, data: data);
      log("response is :${response.data}");
      return response;
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }
}
