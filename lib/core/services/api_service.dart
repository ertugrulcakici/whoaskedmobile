import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:whoaskedmobile/core/services/navigation_service.dart';
import 'package:whoaskedmobile/product/constants/app_constants.dart';

import 'auth_service.dart';

class PostHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

final class ApiService {
  // singleton
  static final ApiService _instance = ApiService._();
  ApiService._();
  static ApiService get instance => _instance;

  late final Dio _dio;

  static Future<void> init() async {
    HttpOverrides.global = PostHttpOverrides();
    _instance._dio = Dio(BaseOptions(baseUrl: AppConstants.baseUrl))
      ..interceptors.add(
        InterceptorsWrapper(
          onRequest: (options, handler) {
            return handler.next(options);
          },
          onResponse: (response, handler) {
            return handler.next(response);
          },
          onError: (DioException e, handler) {
            if (e.response?.statusCode == 401) {
              AuthService.instance.logout();
              Fluttertoast.showToast(
                  msg: "Your session has expired, please login again");
              Navigator.pushNamedAndRemoveUntil(
                  NavigationService.instance.currentContext!,
                  "/login",
                  (route) => false);
            }
            return handler.next(e);
          },
        ),
      );
  }

  void setBearerToken(String token) {
    _dio.options.headers["Authorization"] = "Bearer $token";
    // _dio = Dio(
    //   BaseOptions(
    //     baseUrl: AppConstants.baseUrl,
    //     // receiveTimeout: const Duration(seconds: 3),
    //     // connectTimeout: const Duration(seconds: 3),
    //     headers: {"Authorization": "Bearer $token"},
    //   ),
    // );
    //check bad certificate
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
      final Response<T> response = await _dio.post<T>(path, data: data);
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
