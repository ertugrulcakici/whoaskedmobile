import 'package:dio/dio.dart';

final class ApiService {
  // singleton
  static final ApiService _instance = ApiService._();
  factory ApiService() => _instance;
  ApiService._();

  final Dio _dio = Dio(
    BaseOptions(
        baseUrl: '',
        receiveTimeout: const Duration(seconds: 3),
        connectTimeout: const Duration(seconds: 3)),
  );

  Future<Map<String, dynamic>> get(String path) async {
    try {
      final Response<Map<String, dynamic>> response =
          await _dio.get<Map<String, dynamic>>(path);
      return response.data!;
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> post(
      String path, Map<String, dynamic> data) async {
    try {
      final Response<Map<String, dynamic>> response =
          await _dio.post<Map<String, dynamic>>(path, data: data);
      return response.data!;
    } catch (e) {
      rethrow;
    }
  }
}
