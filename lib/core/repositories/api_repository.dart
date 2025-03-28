import 'package:dio/dio.dart';
import '../config/api_config.dart';
import '../data/models.dart';
import '../utils/logger.dart';
import 'base_repository.dart';

/// API repository
///
/// Bu klass API so'rovlarini amalga oshirish va ma'lumotlarni modelga o'girish uchun ishlatiladi.
class ApiRepository extends BaseRepository {
  /// Kategoriyalarni olish
  Future<List<CategoryModel>> getCategories() async {
    try {
      final response = await dioClient.get(ApiConfig.categoriesEndpoint);
      return parseResponse(
        response,
        (data) =>
            (data as List).map((json) => CategoryModel.fromJson(json)).toList(),
      );
    } on DioException catch (e) {
      handleError(e);
      rethrow;
    }
  }

  /// Barberlarni olish
  Future<List<BarberModel>> getBarbers() async {
    try {
      final response = await dioClient.get(ApiConfig.barbersEndpoint);
      return parseResponse(
        response,
        (data) =>
            (data as List).map((json) => BarberModel.fromJson(json)).toList(),
      );
    } on DioException catch (e) {
      handleError(e);
      rethrow;
    }
  }

  /// Bannerlarni olish
  Future<List<BannerModel>> getBanners() async {
    try {
      final response = await dioClient.get(ApiConfig.bannersEndpoint);
      return parseResponse(
        response,
        (data) =>
            (data as List).map((json) => BannerModel.fromJson(json)).toList(),
      );
    } on DioException catch (e) {
      handleError(e);
      rethrow;
    }
  }

  /// Kategoriya bo'yicha barberlarni olish
  Future<List<BarberModel>> getBarbersByCategory(int categoryId) async {
    try {
      final response = await dioClient.get(
        ApiConfig.barbersEndpoint,
        queryParameters: {'category_id': categoryId},
      );
      return parseResponse(
        response,
        (data) =>
            (data as List).map((json) => BarberModel.fromJson(json)).toList(),
      );
    } on DioException catch (e) {
      handleError(e);
      rethrow;
    }
  }

  /// Barber ma'lumotlarini olish
  Future<BarberModel> getBarberDetails(int barberId) async {
    try {
      final response =
          await dioClient.get('${ApiConfig.barbersEndpoint}$barberId');
      return parseResponse(response, (data) => BarberModel.fromJson(data));
    } on DioException catch (e) {
      handleError(e);
      rethrow;
    }
  }
}
