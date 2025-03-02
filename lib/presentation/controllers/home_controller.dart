//create home controller

import 'package:get/get.dart';
import 'package:dio/dio.dart'; // Dio ni import qilamiz
import '../../../core/config/api_config.dart';
import '../../../core/data/models.dart'; // Modellarni import qilamiz

class HomeController extends GetxController {
  // ===== ASOSIY O'ZGARUVCHILAR =====

  // Kategoriyalar
  final selectedCategoryIndex = 0.obs;
  final previousCategoryIndex = 0.obs;
  final categories = <CategoryModel>[].obs;
  final topCategories = <CategoryModel>[].obs;

  // Barberlar
  final barbers = <BarberModel>[].obs;
  final filteredBarbers = <BarberModel>[].obs;
  final displayedBarbers = <BarberModel>[].obs;

  // Bannerlar
  final banners = <BannerModel>[].obs;

  // Kategoriyalar ro'yxatlari
  final allCategories = <CategoryModel>[].obs;
  final homeCategories = <CategoryModel>[].obs;
  final homeCategoriesByBarberCount = <CategoryModel>[].obs;
  final homeCategoriesById = <CategoryModel>[].obs;
  final barberSortedCategories = <CategoryModel>[].obs;
  final idSortedCategories = <CategoryModel>[].obs;

  // Keshirlash
  final Map<int, List<BarberModel>> _cachedBarbersByCategory = {};

  // Pagination
  final currentPage = 1.obs;
  final itemsPerPage = 10;
  final hasMoreItems = true.obs;
  final isLoadingMore = false.obs;

  // API va loading
  final dio = Dio();
  final isLoading = false.obs;
  final isCategoriesLoading = false.obs;
  final isBarbersLoading = false.obs;
  final error = ''.obs;
  final categoriesError = ''.obs;
  final barbersError = ''.obs;

  // ===== LIFECYCLE METODLARI =====

  @override
  void onInit() {
    super.onInit();
    _initializeData();
    _setupCategoryWatcher();
  }

  // ===== ASOSIY METODLAR =====

  // Kategoriya o'zgarishini kuzatish
  void _setupCategoryWatcher() {
    ever(selectedCategoryIndex, (int index) {
      if (index != previousCategoryIndex.value) {
        print('Yangi kategoriya tanlandi: $index');
        filterBarbersBySelectedCategory(forceReload: true);
        previousCategoryIndex.value = index;
      } else {
        print('Bir xil kategoriya tanlandi: $index');
      }
    });
  }

  // Barcha ma'lumotlarni yuklash
  Future<void> _initializeData() async {
    try {
      await loadCategories();
      await loadBarbers();
      updateCategoriesWithRealBarberCount();
      filterBarbersBySelectedCategory(forceReload: true);
      await loadBanners();
    } catch (e) {
      print('Ma\'lumotlarni yuklashda xatolik: $e');
      error.value = 'Ma\'lumotlarni yuklashda xatolik: $e';
    }
  }

  // ===== KATEGORIYALAR BILAN ISHLASH =====

  // Kategoriyalarni yuklash
  Future<void> loadCategories() async {
    try {
      isCategoriesLoading.value = true;
      categoriesError.value = '';

      final response =
          await dio.get('${ApiConfig.baseUrl}${ApiConfig.categoriesEndpoint}');

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        final retrievedCategories =
            data.map((json) => CategoryModel.fromJson(json)).toList();

        _processCategories(retrievedCategories);
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

  // Kategoriyalarni qayta ishlash
  void _processCategories(List<CategoryModel> retrievedCategories) {
    // Barcha kategoriyalar
    allCategories.value = List.from(retrievedCategories);

    // Barber soni 0 dan katta bo'lgan kategoriyalarni filtrlash
    final filteredCategories = retrievedCategories
        .where((category) => category.barbersCount > 0)
        .toList();

    // Agar filtrlandan keyin kategoriyalar bo'sh bo'lsa, original ro'yxatni ishlat
    final categoriesToUse =
        filteredCategories.isEmpty ? retrievedCategories : filteredCategories;

    // Home ekrani uchun kategoriyalarni saqlash
    homeCategories.value = List.from(categoriesToUse);

    // Kategoriyalarni saralash
    _sortCategories(categoriesToUse);
  }

  // Kategoriyalarni saralash
  void _sortCategories(List<CategoryModel> categoriesToSort) {
    // Barberlar soni bo'yicha saralash
    final sortedByBarberCount = List<CategoryModel>.from(categoriesToSort);
    sortedByBarberCount
        .sort((a, b) => b.barbersCount.compareTo(a.barbersCount));
    homeCategoriesByBarberCount.value = sortedByBarberCount;
    barberSortedCategories.value = sortedByBarberCount;
    categories.value = sortedByBarberCount;

    // ID bo'yicha saralash
    final sortedById = List<CategoryModel>.from(categoriesToSort);
    sortedById.sort((a, b) => a.id.compareTo(b.id));
    homeCategoriesById.value = sortedById;
    idSortedCategories.value = sortedById;

    // Top kategoriyalarni olish
    if (sortedByBarberCount.length > 4) {
      topCategories.value = sortedByBarberCount.sublist(0, 4);
    } else {
      topCategories.value = sortedByBarberCount;
    }
  }

  // Barberlar haqiqiy soniga ko'ra kategoriyalarni yangilash
  void updateCategoriesWithRealBarberCount() {
    try {
      // Har bir kategoriya uchun barberlar sonini hisoblash
      final Map<int, int> categoryBarberCounts =
          _calculateBarberCountsByCategory();

      // Barber soni 0 bo'lgan kategoriyalarni filtrlash
      final filteredHomeCategories =
          _filterCategoriesByRealBarberCount(categoryBarberCounts);

      // Agar filtrlashdan keyin ro'yxat bo'sh bo'lsa, hech narsa qilmaslik
      if (filteredHomeCategories.isEmpty) return;

      // Kategoriyalarni yangilash
      homeCategories.value = filteredHomeCategories;

      // Kategoriyalarni saralash
      _sortCategoriesByRealBarberCount(
          filteredHomeCategories, categoryBarberCounts);

      print('Kategoriyalar yangilandi: ${homeCategories.length} kategoriya');
    } catch (e) {
      print('Kategoriyalarni filtrlashda xatolik: $e');
    }
  }

  // Kategoriyalarni haqiqiy barber soni bo'yicha saralash
  void _sortCategoriesByRealBarberCount(
      List<CategoryModel> categories, Map<int, int> categoryBarberCounts) {
    // Barberlar soni bo'yicha saralash
    final sortedByBarberCount = List<CategoryModel>.from(categories);
    sortedByBarberCount.sort((a, b) {
      final countA = categoryBarberCounts[a.id] ?? 0;
      final countB = categoryBarberCounts[b.id] ?? 0;
      return countB.compareTo(countA);
    });

    homeCategoriesByBarberCount.value = sortedByBarberCount;
    barberSortedCategories.value = sortedByBarberCount;
    this.categories.value = sortedByBarberCount;

    // ID bo'yicha saralash
    final sortedById = List<CategoryModel>.from(categories);
    sortedById.sort((a, b) => a.id.compareTo(b.id));
    homeCategoriesById.value = sortedById;
    idSortedCategories.value = sortedById;

    // Top kategoriyalarni olish
    if (sortedByBarberCount.length > 4) {
      topCategories.value = sortedByBarberCount.sublist(0, 4);
    } else {
      topCategories.value = sortedByBarberCount;
    }
  }

  // Har bir kategoriya uchun barberlar sonini hisoblash
  Map<int, int> _calculateBarberCountsByCategory() {
    final Map<int, int> counts = {};
    for (var barber in barbers) {
      if (counts.containsKey(barber.categoryId)) {
        counts[barber.categoryId] = counts[barber.categoryId]! + 1;
      } else {
        counts[barber.categoryId] = 1;
      }
    }
    return counts;
  }

  // Barber soni 0 bo'lgan kategoriyalarni filtrlash
  List<CategoryModel> _filterCategoriesByRealBarberCount(
      Map<int, int> categoryBarberCounts) {
    return homeCategories
        .where((category) =>
            categoryBarberCounts[category.id] != null &&
            categoryBarberCounts[category.id]! > 0)
        .toList();
  }

  // Kategoriya indeksini o'rnatish
  void setSelectedCategoryIndex(int index) {
    if (index == selectedCategoryIndex.value) {
      print('Bir xil kategoriya indeksi tanlandi: $index');
      return;
    }

    print('Yangi kategoriya indeksi tanlanmoqda: $index');
    selectedCategoryIndex.value = index;
  }

  // Kategoriya ID orqali tanlash
  void selectCategoryById(int categoryId) {
    final index =
        homeCategoriesById.indexWhere((category) => category.id == categoryId);

    if (index == -1) {
      print('Kategoriya topilmadi: $categoryId');
      return;
    }

    if (selectedCategoryIndex.value == index) {
      print('Bir xil kategoriya tanlangan: $categoryId');
      return;
    }

    print('Kategoriya tanlandi: $categoryId (indeks: $index)');
    selectedCategoryIndex.value = index;
  }

  // ===== BARBERLAR BILAN ISHLASH =====

  // Barberlarni yuklash
  Future<void> loadBarbers() async {
    try {
      isBarbersLoading.value = true;
      barbersError.value = '';

      final response =
          await dio.get('${ApiConfig.baseUrl}${ApiConfig.barbersEndpoint}');

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

  // Tanlangan kategoriyaga qarab barberlarni filtrlash
  void filterBarbersBySelectedCategory({bool forceReload = false}) {
    if (_isFilteringNotPossible()) return;

    try {
      // Tanlangan kategoriya ID sini olish
      final selectedCategory = _getSelectedCategory();
      if (selectedCategory == null) return;

      final categoryId = selectedCategory.id;
      print('Tanlangan kategoriya: ${selectedCategory.name} (ID: $categoryId)');

      // Qayta yuklash kerak emas bo'lsa, qaytish
      if (_shouldSkipReloading(categoryId, forceReload)) return;

      // Barberlarni filtrlash
      _filterAndCacheBarbers(categoryId, forceReload);

      // Pagination parametrlarini qayta o'rnatish
      resetPagination();
    } catch (e) {
      print('Barberlarni filtrlashda xatolik: $e');
      _clearBarberLists();
    }
  }

  // Filtrlash mumkin emas bo'lsa
  bool _isFilteringNotPossible() {
    if (homeCategoriesById.isEmpty) {
      print('Kategoriyalar ro\'yxati bo\'sh');
      return true;
    }

    if (barbers.isEmpty) {
      print('Barberlar ro\'yxati bo\'sh');
      return true;
    }

    return false;
  }

  // Tanlangan kategoriyani olish
  CategoryModel? _getSelectedCategory() {
    // Indeks chegaradan chiqib ketmasligi uchun tekshirish
    if (selectedCategoryIndex.value >= homeCategoriesById.length) {
      print('Tanlangan indeks chegaradan tashqarida, 0-indeksga qaytarildi');
      selectedCategoryIndex.value = 0;
    }

    return homeCategoriesById.isNotEmpty
        ? homeCategoriesById[selectedCategoryIndex.value]
        : null;
  }

  // Qayta yuklash kerak emas bo'lsa
  bool _shouldSkipReloading(int categoryId, bool forceReload) {
    if (!forceReload &&
        filteredBarbers.isNotEmpty &&
        filteredBarbers.first.categoryId == categoryId) {
      print('Qayta yuklash qo\'llanilmadi: kategoriya o\'zgarmagan');
      return true;
    }
    return false;
  }

  // Barberlarni filtrlash va keshirlash
  void _filterAndCacheBarbers(int categoryId, bool forceReload) {
    // Cache'dan barberlarni olish
    if (_cachedBarbersByCategory.containsKey(categoryId) && !forceReload) {
      print(
          'Keshdan foydalanildi: ${_cachedBarbersByCategory[categoryId]!.length} barber');
      filteredBarbers.value = _cachedBarbersByCategory[categoryId]!;
      return;
    }

    // Yangi filtrlash
    final newFilteredBarbers =
        barbers.where((barber) => barber.categoryId == categoryId).toList();

    // Cache'ni yangilash
    _cachedBarbersByCategory[categoryId] = newFilteredBarbers;

    // Qiymatni o'rnatish
    filteredBarbers.value = newFilteredBarbers;
    print('Yangi filtrlash: ${newFilteredBarbers.length} barber');
  }

  // Barber ro'yxatlarini tozalash
  void _clearBarberLists() {
    filteredBarbers.value = [];
    displayedBarbers.value = [];
    hasMoreItems.value = false;
  }

  // Pagination parametrlarini qayta o'rnatish
  void resetPagination() {
    print('Pagination qayta o\'rnatilmoqda');
    currentPage.value = 1;
    hasMoreItems.value = true;
    displayedBarbers.clear();
    loadMoreBarbers();
  }

  // Keyingi sahifani yuklash
  Future<void> loadMoreBarbers() async {
    if (isLoadingMore.value) {
      print('Barberlar allaqachon yuklanmoqda');
      return;
    }

    try {
      isLoadingMore.value = true;

      // Sahifa indekslarini hisoblash
      final startIndex = (currentPage.value - 1) * itemsPerPage;
      final endIndex = startIndex + itemsPerPage;

      // Agar barberlar ro'yxati tugagan bo'lsa
      if (startIndex >= filteredBarbers.length) {
        hasMoreItems.value = false;
        isLoadingMore.value = false;
        print('Barcha barberlar ko\'rsatilgan');
        return;
      }

      // Keyingi sahifa indeksi
      final actualEndIndex =
          endIndex > filteredBarbers.length ? filteredBarbers.length : endIndex;

      // Yangi barberlarni olish
      final newBarbers = filteredBarbers.sublist(startIndex, actualEndIndex);

      // Kechikish (real API da kerak bo'lmaydi)
      await Future.delayed(const Duration(milliseconds: 300));

      // Barberlarni qo'shish
      displayedBarbers.addAll(newBarbers);

      // Keyingi sahifani belgilash
      currentPage.value++;

      // Yana barberlar bormi yo'qligini tekshirish
      hasMoreItems.value = endIndex < filteredBarbers.length;
    } catch (e) {
      print('Barberlarni sahifalashda xatolik: $e');
    } finally {
      isLoadingMore.value = false;
    }
  }

  // ===== BANNERLAR BILAN ISHLASH =====

  // Bannerlarni yuklash
  Future<void> loadBanners() async {
    try {
      isLoading.value = true;
      error.value = '';

      final response =
          await dio.get('${ApiConfig.baseUrl}${ApiConfig.bannersEndpoint}');

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

  // ===== YORDAMCHI METODLAR =====

  // Umumiy loading holati
  bool get isAnyLoading =>
      isLoading.value || isCategoriesLoading.value || isBarbersLoading.value;
}
