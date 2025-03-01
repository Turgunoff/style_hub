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

class BarberModel {
  final int id;
  final String fullName;
  final String phone;
  final String email;
  final String bio;
  final int experience;
  final double rating;
  final int categoryId;
  final String imageUrl;
  final double distance;

  BarberModel({
    required this.id,
    required this.fullName,
    required this.phone,
    required this.email,
    required this.bio,
    required this.experience,
    required this.rating,
    required this.categoryId,
    required this.imageUrl,
    this.distance = 0.0,
  });

  factory BarberModel.fromJson(Map<String, dynamic> json) {
    return BarberModel(
      id: json['id'],
      fullName: json['full_name'] ?? 'Nomsiz barber',
      phone: json['phone'] ?? '',
      email: json['email'] ?? '',
      bio: json['bio'] ?? '',
      experience: json['experience'] ?? 0,
      rating: (json['rating'] ?? 0.0).toDouble(),
      categoryId: json['category_id'] ?? 0,
      imageUrl: json['image_url'] ?? 'assets/image/photo.jpg',
      distance: (json['distance'] ?? 0.0).toDouble(),
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
  final barberSortedCategories =
      <CategoryModel>[].obs; // Barberlar soni bo'yicha saralangan
  final idSortedCategories = <CategoryModel>[].obs; // ID bo'yicha saralangan
  final banners = <BannerModel>[].obs;
  final barbers = <BarberModel>[].obs; // Barcha barberlar
  final filteredBarbers = <BarberModel>[].obs; // Filtrlangan barberlar
  final dio = Dio(); // Dio instance
  final isLoading = false.obs;
  final isCategoriesLoading = false.obs;
  final isBarbersLoading = false.obs;
  final error = ''.obs;
  final categoriesError = ''.obs;
  final barbersError = ''.obs;

  @override
  void onInit() {
    super.onInit();

    // Kategoriyalarni yuklash va barberlarni yuklash ketma-ketligini to'g'rilash
    loadCategories().then((_) {
      loadBarbers().then((_) {
        // Barberlar va kategoriyalar yuklangandan so'ng filtrlashni bajarish
        filterBarbersBySelectedCategory();
      });
    });

    loadBanners();

    // Kategoriya o'zgarishini kuzatish
    ever(selectedCategoryIndex, (_) {
      filterBarbersBySelectedCategory();
    });
  }

  // Tanlangan kategoriyaga qarab barberlarni filtrlash
  void filterBarbersBySelectedCategory() {
    if (idSortedCategories.isEmpty || barbers.isEmpty) return;

    try {
      // Tanlangan kategoriya ID sini olish
      final selectedCategory = idSortedCategories[selectedCategoryIndex.value];

      // Agar filteredBarbers bo'sh bo'lmasa va birinchi barber tanlangan kategoriyaga tegishli bo'lsa,
      // qayta filtrlashni bajarmaslik (rasmlarni qayta yuklanishini oldini olish)
      if (filteredBarbers.isNotEmpty &&
          filteredBarbers.first.categoryId == selectedCategory.id) {
        return;
      }

      // Shu kategoriyaga tegishli barberlarni filtrlash
      filteredBarbers.value = barbers
          .where((barber) => barber.categoryId == selectedCategory.id)
          .toList();

      print(
          'Filtered barbers for category ${selectedCategory.name}: ${filteredBarbers.length}');
    } catch (e) {
      print('Error filtering barbers: $e');
      // Xatolik yuz berganda bo'sh ro'yxat qaytarish
      filteredBarbers.value = [];
    }
  }

  // Kategoriyalarni barberlar soni bo'yicha saralash
  void sortCategoriesByBarberCount() {
    categories.value = List.from(barberSortedCategories);
  }

  // Kategoriyalarni ID bo'yicha saralash
  void sortCategoriesById() {
    categories.value = List.from(idSortedCategories);
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

  // Barcha kategoriyalarni yuklash
  Future<void> loadCategories() async {
    try {
      isCategoriesLoading.value = true;
      categoriesError.value = '';

      final response =
          await dio.get('http://159.223.43.76:7777/api/v1/categories/');

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        final allCategories =
            data.map((json) => CategoryModel.fromJson(json)).toList();

        // Barberlar soni bo'yicha saralash
        final byBarberCount = List<CategoryModel>.from(allCategories);
        byBarberCount.sort((a, b) => b.barbersCount.compareTo(a.barbersCount));
        barberSortedCategories.value = byBarberCount;

        // ID bo'yicha saralash
        final byId = List<CategoryModel>.from(allCategories);
        byId.sort((a, b) => a.id.compareTo(b.id));
        idSortedCategories.value = byId;

        // Asosiy kategoriyalar ro'yxatini yangilash (default: barber soni bo'yicha)
        categories.value = byBarberCount;

        // Eng ko'p barberli 4 ta kategoriyani olish
        if (byBarberCount.length > 4) {
          topCategories.value = byBarberCount.sublist(0, 4);
        } else {
          topCategories.value = byBarberCount;
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

  // Barcha barberlarni yuklash
  Future<void> loadBarbers() async {
    try {
      isBarbersLoading.value = true;
      barbersError.value = '';

      final response =
          await dio.get('http://159.223.43.76:7777/api/v1/barbers/');

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        barbers.value = data.map((json) => BarberModel.fromJson(json)).toList();
      } else {
        barbersError.value = 'Barberlarni yuklashda xatolik';
      }
    } catch (e) {
      barbersError.value = 'Barberlarni yuklashda xatolik: $e';
      print('Barberlarni yuklashda xatolik: $e');
    } finally {
      isBarbersLoading.value = false;
    }
  }
}
