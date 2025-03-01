//create home controller

import 'package:get/get.dart';
import 'package:dio/dio.dart'; // Dio ni import qilamiz
import '../../../core/config/api_config.dart';

class BannerModel {
  final int id;
  final DateTime? startDate;
  final DateTime? endDate;
  final bool isActive;
  final String? imageUrl;

  BannerModel({
    required this.id,
    this.startDate,
    this.endDate,
    required this.isActive,
    this.imageUrl,
  });

  factory BannerModel.fromJson(Map<String, dynamic> json) {
    return BannerModel(
      id: json['id'],
      startDate: json['start_date'] != null
          ? DateTime.parse(json['start_date'])
          : null,
      endDate:
          json['end_date'] != null ? DateTime.parse(json['end_date']) : null,
      isActive: json['is_active'],
      imageUrl: json['image_url'],
    );
  }
}

class HomeController extends GetxController {
  final selectedCategoryIndex = 0.obs; // RxInt tipidagi observable
  final categories = <String>[].obs; // RxList tipidagi observable
  final banners = <BannerModel>[].obs;
  final dio = Dio(); // Dio instance
  final isLoading = false.obs;
  final error = ''.obs;

  @override
  void onInit() {
    super.onInit();
    // Kategoriyalarni yuklash
    loadCategories();
    loadBanners();
  }

  void loadCategories() {
    categories.value = [
      'All',
      'Haircut',
      'Shaving',
      'Facial',
      'Hair Color',
      'Massage',
    ];
  }

  void setSelectedCategoryIndex(int index) {
    selectedCategoryIndex.value = index;
  }

  Future<void> loadBanners() async {
    try {
      isLoading.value = true;
      error.value = '';

      final response = await dio.get('${ApiConfig.baseUrl}/banners/');

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        banners.value = data.map((json) => BannerModel.fromJson(json)).toList();
      } else {
        error.value = 'Failed to load banners';
      }
    } catch (e) {
      error.value = 'Error loading banners: $e';
      print('Error loading banners: $e');
    } finally {
      isLoading.value = false;
    }
  }
}
