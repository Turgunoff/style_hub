import 'package:dio/dio.dart';
import '../network/dio_client.dart';
import '../utils/logger.dart';

/// Barcha repositorylar uchun asosiy klass
///
/// Bu klass repository pattern asosida tuzilgan va quyidagi funksiyalarni ta'minlaydi:
/// - DioClient bilan ishlash
/// - Xatoliklarni qayta ishlash
/// - Response ma'lumotlarini parse qilish
abstract class BaseRepository {
  final DioClient _dioClient = DioClient.instance;

  /// DioClient instance olish
  DioClient get dioClient => _dioClient;

  /// Response ma'lumotlarini parse qilish
  T parseResponse<T>(Response response, T Function(dynamic) fromJson) {
    try {
      return fromJson(response.data);
    } catch (e) {
      AppLogger.error('Error parsing response: $e');
      rethrow;
    }
  }

  /// Xatoliklarni qayta ishlash
  void handleError(DioException e) {
    AppLogger.error('Repository error: ${e.message}');
    // Bu yerda xatoliklarni qayta ishlash logikasi bo'lishi mumkin
    throw e;
  }
}
