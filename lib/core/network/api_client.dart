import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import '../config/api_config.dart';
import '../utils/logger.dart';

/// API klient
///
/// Bu klass API so'rovlarini amalga oshirish uchun ishlatiladi.
class ApiClient {
  final Dio _dio;

  ApiClient({Dio? dio}) : _dio = dio ?? Dio() {
    _setupDio();
  }

  void _setupDio() {
    _dio.options.baseUrl = ApiConfig.baseUrl;
    _dio.options.connectTimeout = const Duration(seconds: 30);
    _dio.options.receiveTimeout = const Duration(seconds: 30);
    _dio.options.headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };

    // Interceptorlar
    _dio.interceptors.clear();
    // TODO: API logs vaqtincha o'chirildi
    // _dio.interceptors.add(LogInterceptor(
    //   requestBody: true,
    //   responseBody: true,
    //   logPrint: (obj) => debugPrint(obj.toString()),
    // ));
  }

  /// GET so'rovi
  Future<dynamic> get(String endpoint,
      {Map<String, dynamic>? queryParams}) async {
    try {
      final response = await _dio.get(
        endpoint,
        queryParameters: queryParams,
      );
      return _processResponse(response);
    } on DioException catch (e) {
      return _handleError(e);
    }
  }

  /// POST so'rovi
  Future<dynamic> post(String endpoint, {dynamic data}) async {
    try {
      final response = await _dio.post(
        endpoint,
        data: data,
      );
      return _processResponse(response);
    } on DioException catch (e) {
      return _handleError(e);
    }
  }

  /// PUT so'rovi
  Future<dynamic> put(String endpoint, {dynamic data}) async {
    try {
      final response = await _dio.put(
        endpoint,
        data: data,
      );
      return _processResponse(response);
    } on DioException catch (e) {
      return _handleError(e);
    }
  }

  /// DELETE so'rovi
  Future<dynamic> delete(String endpoint) async {
    try {
      final response = await _dio.delete(endpoint);
      return _processResponse(response);
    } on DioException catch (e) {
      return _handleError(e);
    }
  }

  /// Javobni qayta ishlash
  dynamic _processResponse(Response response) {
    switch (response.statusCode) {
      case 200:
      case 201:
        return response.data;
      case 400:
        throw Exception('Bad request');
      case 401:
      case 403:
        throw Exception('Unauthorized');
      case 404:
        throw Exception('Not found');
      case 500:
      default:
        throw Exception('Server error');
    }
  }

  /// Xatolarni qayta ishlash
  dynamic _handleError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        AppLogger.error('Timeout error: ${error.message}');
        throw Exception('Connection timeout');
      case DioExceptionType.badResponse:
        AppLogger.error(
            'Bad response: ${error.response?.statusCode} - ${error.response?.data}');
        return _processResponse(error.response!);
      case DioExceptionType.cancel:
        AppLogger.error('Request cancelled: ${error.message}');
        throw Exception('Request cancelled');
      default:
        AppLogger.error('Network error: ${error.message}');
        throw Exception('Network error');
    }
  }
}
