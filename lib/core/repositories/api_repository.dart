import '../config/api_config.dart';
import '../network/api_client.dart';
import '../data/models.dart';
import '../utils/logger.dart';

/// API repository
///
/// Bu klass API so'rovlarini amalga oshirish va ma'lumotlarni modelga o'girish uchun ishlatiladi.
class ApiRepository {
  final ApiClient _apiClient = ApiClient();

  /// Singleton pattern
  static final ApiRepository _instance = ApiRepository._internal();
  factory ApiRepository() => _instance;

  ApiRepository._internal();

  /// Kategoriyalarni olish
  Future<List<CategoryModel>> getCategories() async {
    try {
      final response = await _apiClient.get(ApiConfig.categoriesEndpoint);
      final List<dynamic> data = response;
      return data.map((json) => CategoryModel.fromJson(json)).toList();
    } catch (e) {
      AppLogger.error('Kategoriyalarni yuklashda xatolik: $e');
      throw Exception('Kategoriyalarni yuklashda xatolik: $e');
    }
  }

  /// Barberlarni olish
  Future<List<BarberModel>> getBarbers() async {
    try {
      final response = await _apiClient.get(ApiConfig.barbersEndpoint);
      final List<dynamic> data = response;
      return data.map((json) => BarberModel.fromJson(json)).toList();
    } catch (e) {
      AppLogger.error('Barberlarni yuklashda xatolik: $e');
      throw Exception('Barberlarni yuklashda xatolik: $e');
    }
  }

  /// Bannerlarni olish
  Future<List<BannerModel>> getBanners() async {
    try {
      final response = await _apiClient.get(ApiConfig.bannersEndpoint);
      final List<dynamic> data = response;
      return data.map((json) => BannerModel.fromJson(json)).toList();
    } catch (e) {
      AppLogger.error('Bannerlarni yuklashda xatolik: $e');
      throw Exception('Bannerlarni yuklashda xatolik: $e');
    }
  }

  /// Kategoriya bo'yicha barberlarni olish
  Future<List<BarberModel>> getBarbersByCategory(int categoryId) async {
    try {
      final response = await _apiClient.get(
        ApiConfig.barbersEndpoint,
        queryParams: {'category_id': categoryId},
      );
      final List<dynamic> data = response;
      return data.map((json) => BarberModel.fromJson(json)).toList();
    } catch (e) {
      AppLogger.error('Barberlarni yuklashda xatolik: $e');
      throw Exception('Barberlarni yuklashda xatolik: $e');
    }
  }
}
