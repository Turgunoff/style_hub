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
  final String? linkUrl;

  BannerModel({
    required this.id,
    this.startDate,
    this.endDate,
    required this.isActive,
    this.imageUrl,
    this.linkUrl,
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
      linkUrl: json['link_url'],
    );
  }
}

class CategoryModel {
  final int id;
  final DateTime createdAt;
  final String name;
  final String description;
  final String imageUrl;
  final int barbersCount; // Barberlar soni

  CategoryModel({
    required this.id,
    required this.createdAt,
    required this.name,
    required this.description,
    required this.imageUrl,
    this.barbersCount = 0,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'],
      createdAt: DateTime.parse(json['created_at']),
      name: json['name'],
      description: json['description'],
      imageUrl: json['image_url'],
      barbersCount: json['barbers_count'] ?? 0,
    );
  }
}

class HomeController extends GetxController {
  final selectedCategoryIndex = 0.obs; // RxInt tipidagi observable
  final categories = <CategoryModel>[].obs; // RxList tipidagi observable
  final topCategories =
      <CategoryModel>[].obs; // Eng ko'p barberli kategoriyalar
  final banners = <BannerModel>[].obs;
  final dio = Dio(); // Dio instance
  final isLoading = false.obs;
  final isCategoriesLoading = false.obs;
  final error = ''.obs;
  final categoriesError = ''.obs;

  @override
  void onInit() {
    super.onInit();
    // Kategoriyalarni yuklash
    loadCategories();
    loadBanners();
  }

  Future<void> loadCategories() async {
    try {
      isCategoriesLoading.value = true;
      categoriesError.value = '';

      final response =
          await dio.get('http://159.223.43.76:7777/api/v1/categories/');

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        categories.value =
            data.map((json) => CategoryModel.fromJson(json)).toList();

        // Kategoriyalarni barberlar soni bo'yicha tartiblash
        categories.sort((a, b) => b.barbersCount.compareTo(a.barbersCount));
        print(categories.length);
        print(categories);
        // Eng ko'p barberli 4 ta kategoriyani olish
        if (categories.length > 4) {
          topCategories.value = categories.sublist(0, 4);
        } else {
          topCategories.value = categories;
        }
      } else {
        categoriesError.value = 'Kategoriyalarni yuklashda xatolik';
      }
    } catch (e) {
      categoriesError.value = 'Kategoriyalarni yuklashda xatolik: $e';
      print('Kategoriyalarni yuklashda xatolik: $e');
    } finally {
      isCategoriesLoading.value = false;
    }
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
