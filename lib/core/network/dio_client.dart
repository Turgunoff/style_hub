import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../config/env_config.dart';
import '../utils/logger.dart';

/// Tarmoq so'rovlarini boshqarish uchun Dio klienti
///
/// Bu klass barcha HTTP so'rovlarini boshqaradi va quyidagi funksiyalarni ta'minlaydi:
/// - So'rovlar uchun interceptorlar
/// - Xatoliklarni qayta ishlash
/// - Caching mexanizmi
/// - Logging
class DioClient {
  static DioClient? _instance;
  late Dio _dio;
  late CacheOptions _cacheOptions;
  final _storage = const FlutterSecureStorage();

  /// Singleton pattern orqali instance olish
  static DioClient get instance {
    _instance ??= DioClient._internal();
    return _instance!;
  }

  /// Private konstruktor
  DioClient._internal() {
    _initDio();
    _initCache();
    _addInterceptors();
  }

  /// Dio-ni ishga tushirish
  void _initDio() {
    _dio = Dio(
      BaseOptions(
        baseUrl: EnvConfig.apiBaseUrl,
        connectTimeout: Duration(milliseconds: EnvConfig.connectionTimeout),
        receiveTimeout: Duration(milliseconds: EnvConfig.connectionTimeout),
        sendTimeout: Duration(milliseconds: EnvConfig.connectionTimeout),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
      ),
    );

    // Logging interceptor
    if (EnvConfig.enableLogging) {
      _dio.interceptors.add(
        LogInterceptor(
          request: false,
          requestHeader: false,
          requestBody: false,
          responseHeader: false,
          responseBody: false,
          error: true,
          logPrint: (obj) {
            final message = obj.toString();
            if (message.contains('Error')) {
              AppLogger.error(message);
            } else {
              AppLogger.debug(message);
            }
          },
        ),
      );
    }

    // Error interceptor
    _dio.interceptors.add(
      InterceptorsWrapper(
        onError: (DioException e, ErrorInterceptorHandler handler) {
          AppLogger.error('Dio Error: ${e.message}');
          return handler.next(e);
        },
      ),
    );
  }

  /// Cache mexanizmini ishga tushirish
  void _initCache() {
    _cacheOptions = CacheOptions(
      store: MemCacheStore(),
      policy: CachePolicy.refreshForceCache,
      maxStale: const Duration(days: 1),
      priority: CachePriority.normal,
    );

    _dio.interceptors.add(DioCacheInterceptor(options: _cacheOptions));
  }

  /// Auth interceptor
  void _addInterceptors() {
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        final token = await _storage.read(key: 'auth_token');
        if (token != null) {
          options.headers['Authorization'] = 'Bearer $token';
        }
        return handler.next(options);
      },
    ));
  }

  /// GET so'rovi yuborish
  Future<Response> get(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    try {
      final response = await _dio.get(
        path,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
      return response;
    } catch (e) {
      AppLogger.error('GET request error: $e');
      rethrow;
    }
  }

  /// POST so'rovi yuborish
  Future<Response> post(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    try {
      final response = await _dio.post(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
      return response;
    } catch (e) {
      AppLogger.error('POST request error: $e');
      rethrow;
    }
  }

  /// PUT so'rovi yuborish
  Future<Response> put(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    try {
      final response = await _dio.put(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
      return response;
    } catch (e) {
      AppLogger.error('PUT request error: $e');
      rethrow;
    }
  }

  /// DELETE so'rovi yuborish
  Future<Response> delete(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    try {
      final response = await _dio.delete(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
      return response;
    } catch (e) {
      AppLogger.error('DELETE request error: $e');
      rethrow;
    }
  }
}
