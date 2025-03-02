//create home controller

import 'package:get/get.dart';
import 'package:dio/dio.dart'; // Dio ni import qilamiz
import '../../../core/config/api_config.dart';
import '../../../core/data/models.dart'; // Modellarni import qilamiz

class HomeController extends GetxController {
  final selectedCategoryIndex = 0.obs; // RxInt tipidagi observable
  final previousCategoryIndex = 0.obs; // Avvalgi tanlangan kategoriya indeksi
  final categories = <CategoryModel>[].obs; // RxList tipidagi observable
  final topCategories =
      <CategoryModel>[].obs; // Eng ko'p barberli kategoriyalar

  // Barcha kategoriyalar ro'yxatlari (filtrsiz)
  final allCategories = <CategoryModel>[].obs; // Barcha kategoriyalar
  final allCategoriesByBarberCount =
      <CategoryModel>[].obs; // Barberlar soni bo'yicha
  final allCategoriesById = <CategoryModel>[].obs; // ID bo'yicha

  // Home ekrani uchun filtrlangan kategoriyalar (barber soni > 0)
  final homeCategories = <CategoryModel>[].obs; // Home ekrani uchun
  final homeCategoriesByBarberCount =
      <CategoryModel>[].obs; // Barberlar soni bo'yicha
  final homeCategoriesById = <CategoryModel>[].obs; // ID bo'yicha

  // Eski o'zgaruvchilarni yangilari bilan moslashtirish
  final barberSortedCategories =
      <CategoryModel>[].obs; // Barberlar soni bo'yicha saralangan
  final idSortedCategories = <CategoryModel>[].obs; // ID bo'yicha saralangan

  final banners = <BannerModel>[].obs;
  final barbers = <BarberModel>[].obs; // Barcha barberlar
  final filteredBarbers = <BarberModel>[].obs; // Filtrlangan barberlar
  final displayedBarbers =
      <BarberModel>[].obs; // Ko'rsatiladigan barberlar (pagination uchun)

  // API so'rovlari sonini kamaytirish uchun cash
  final Map<int, List<BarberModel>> _cachedBarbersByCategory = {};

  // Pagination parametrlari
  final currentPage = 1.obs;
  final itemsPerPage = 10;
  final hasMoreItems = true.obs;
  final isLoadingMore = false.obs;

  final dio = Dio(); // Dio instance
  final isLoading = false.obs;
  final isCategoriesLoading = false.obs;
  final isBarbersLoading = false.obs;
  final error = ''.obs;
  final categoriesError = ''.obs;
  final barbersError = ''.obs;

  // Umumiy loading holati
  bool get isAnyLoading =>
      isLoading.value || isCategoriesLoading.value || isBarbersLoading.value;

  @override
  void onInit() {
    super.onInit();

    // Barcha ma'lumotlarni bir marta yuklash
    _initializeData();

    // Kategoriya o'zgarishini kuzatish - faqat kategoriya haqiqatan o'zgargandagina
    ever(selectedCategoryIndex, (int index) {
      // DEBUG: Kategoriya o'zgarishi haqida xabar
      print(
          'Kategoriya indeksi o\'zgardi: $index, avvalgi: ${previousCategoryIndex.value}');

      // Faqat indeks o'zgargandagina filter qilish
      if (index != previousCategoryIndex.value) {
        print('Haqiqatan yangi kategoriya tanlandi, filtrlash...');
        filterBarbersBySelectedCategory(forceReload: true);
        previousCategoryIndex.value = index;
      } else {
        print('Bir xil kategoriya tanlandi, filtrlash amalga oshirilmaydi');
      }
    });
  }

  // Barcha ma'lumotlarni yuklash uchun yagona metod
  Future<void> _initializeData() async {
    try {
      // Kategoriyalarni yuklash
      await loadCategories();

      // Barberlarni yuklash
      await loadBarbers();

      // Barberlar va kategoriyalar yuklangandan so'ng:
      // 1. Kategoriyalarni real barber soni bo'yicha yangilash
      updateCategoriesWithRealBarberCount();

      // 2. Dastlabki tanlangan kategoriya uchun barberlarni filtrlash
      filterBarbersBySelectedCategory(forceReload: true);

      // 3. Bannerlarni yuklash
      await loadBanners();
    } catch (e) {
      print('Ma\'lumotlarni yuklashda xatolik: $e');
      error.value = 'Ma\'lumotlarni yuklashda xatolik: $e';
    }
  }

  // Barberlar haqiqiy soniga ko'ra kategoriyalarni yangilash
  void updateCategoriesWithRealBarberCount() {
    try {
      // Har bir kategoriya uchun barberlar sonini hisoblash
      final Map<int, int> categoryBarberCounts = {};
      for (var barber in barbers) {
        if (categoryBarberCounts.containsKey(barber.categoryId)) {
          categoryBarberCounts[barber.categoryId] =
              categoryBarberCounts[barber.categoryId]! + 1;
        } else {
          categoryBarberCounts[barber.categoryId] = 1;
        }
      }

      // Barber soni 0 bo'lgan kategoriyalarni filtrlash
      final filteredHomeCategories = homeCategories
          .where((category) =>
              categoryBarberCounts[category.id] != null &&
              categoryBarberCounts[category.id]! > 0)
          .toList();

      // Agar filtrlashdan keyin ro'yxat bo'sh bo'lsa, original ro'yxatni saqlash
      if (filteredHomeCategories.isNotEmpty) {
        // Barcha ro'yxatlarni yangilash
        homeCategories.value = filteredHomeCategories;

        // Barberlar soni bo'yicha saralash
        final sortedByBarberCount =
            List<CategoryModel>.from(filteredHomeCategories);
        sortedByBarberCount.sort((a, b) {
          final countA = categoryBarberCounts[a.id] ?? 0;
          final countB = categoryBarberCounts[b.id] ?? 0;
          return countB.compareTo(countA);
        });
        homeCategoriesByBarberCount.value = sortedByBarberCount;

        // ID bo'yicha saralash
        final sortedById = List<CategoryModel>.from(filteredHomeCategories);
        sortedById.sort((a, b) => a.id.compareTo(b.id));
        homeCategoriesById.value = sortedById;

        // Eski o'zgaruvchilarni yangilash
        barberSortedCategories.value = sortedByBarberCount;
        idSortedCategories.value = sortedById;
        categories.value = sortedByBarberCount;

        // Eng ko'p barberli 4 ta kategoriyani olish
        if (sortedByBarberCount.length > 4) {
          topCategories.value = sortedByBarberCount.sublist(0, 4);
        } else {
          topCategories.value = sortedByBarberCount;
        }

        // Barcha kategoriyalar ro'yxatlarini ham yangilash
        allCategoriesByBarberCount.value = sortedByBarberCount;
        allCategoriesById.value = sortedById;
      }

      print(
          'Kategoriyalar haqiqiy barber soniga ko\'ra filtrlandi. Natija: ${homeCategories.length} kategoriya');
    } catch (e) {
      print('Kategoriyalarni filtrlashda xatolik: $e');
    }
  }

  // Tanlangan kategoriyaga qarab barberlarni filtrlash
  void filterBarbersBySelectedCategory({bool forceReload = false}) {
    if (homeCategoriesById.isEmpty) {
      print('Kategoriyalar ro\'yxati bo\'sh');
      return;
    }

    if (barbers.isEmpty) {
      print('Barberlar ro\'yxati bo\'sh');
      return;
    }

    try {
      // Indeks chegaradan chiqib ketmasligi uchun tekshirish
      if (selectedCategoryIndex.value >= homeCategoriesById.length) {
        print('Tanlangan indeks chegaradan tashqarida, 0-indeksga qaytarildi');
        selectedCategoryIndex.value = 0;
      }

      // Tanlangan kategoriya ID sini olish
      final selectedCategory = homeCategoriesById[selectedCategoryIndex.value];
      final categoryId = selectedCategory.id;

      print('Tanlangan kategoriya: ${selectedCategory.name} (ID: $categoryId)');

      // MUHIM: Qayta-qayta yuklashni oldini olish uchun tekshirish:
      // 1. Agar forceReload false bo'lsa
      // 2. Va filteredBarbers bo'sh bo'lmasa
      // 3. Va birinchi barberning kategoriyasi tanlangan kategoriyaning ID'siga teng bo'lsa
      if (!forceReload &&
          filteredBarbers.isNotEmpty &&
          filteredBarbers.first.categoryId == categoryId) {
        print(
            'QAYTA YUKLASH QO\'LLANILMADI: Kategoriya o\'zgarmagan: ${selectedCategory.name}');
        return;
      }

      print(
          'FILTERLASH BOSHLANDI: Kategoriya ${selectedCategory.name} uchun barberlar filterlanyapti');

      // Cache'dan barberlarni olish yoki cash yangilash
      if (_cachedBarbersByCategory.containsKey(categoryId) && !forceReload) {
        print(
            'KESHDAN FOYDALANILDI: ${_cachedBarbersByCategory[categoryId]!.length} barber topildi');
        filteredBarbers.value = _cachedBarbersByCategory[categoryId]!;
      } else {
        // Shu kategoriyaga tegishli barberlarni filtrlash
        final newFilteredBarbers =
            barbers.where((barber) => barber.categoryId == categoryId).toList();

        // Cache'ni yangilash
        _cachedBarbersByCategory[categoryId] = newFilteredBarbers;

        // Qiymatni o'rnatish
        filteredBarbers.value = newFilteredBarbers;
        print(
            'YANGI FILTERLASH: ${newFilteredBarbers.length} barber filterlandi');
      }

      // Pagination parametrlarini qayta o'rnatish
      resetPagination();
    } catch (e) {
      print('Barberlarni filtrlashda xatolik: $e');
      // Xatolik yuz berganda bo'sh ro'yxat qaytarish
      filteredBarbers.value = [];
      displayedBarbers.value = [];
      hasMoreItems.value = false;
    }
  }

  // Kategoriya ID orqali tanlash (boshqa joylardan chaqirish uchun)
  void selectCategoryById(int categoryId) {
    final index =
        homeCategoriesById.indexWhere((category) => category.id == categoryId);

    if (index != -1) {
      print(
          'selectCategoryById: Kategoriya ID: $categoryId indeksi topildi: $index');

      // Agar index bir xil bo'lsa, boshqa amallar qilishga hojat yo'q
      if (selectedCategoryIndex.value == index) {
        print(
            'selectCategoryById: Bir xil kategoriya tanlangan, qayta filterlash qo\'llanilmaydi');
        return;
      }

      // Yangi indeksni o'rnatish - bu ever() orqali filterBarbersBySelectedCategory ni chaqiradi
      selectedCategoryIndex.value = index;
    } else {
      print('selectCategoryById: Kategoriya ID: $categoryId topilmadi');
    }
  }

  // Pagination parametrlarini qayta o'rnatish
  void resetPagination() {
    print('Pagination qayta o\'rnatilmoqda');
    currentPage.value = 1;
    hasMoreItems.value = true;
    // Avvalgi ko'rsatilgan barberlarni tozalash
    displayedBarbers.clear();
    // Birinchi sahifani yuklash
    loadMoreBarbers();
  }

  // Keyingi sahifani yuklash
  Future<void> loadMoreBarbers() async {
    if (isLoadingMore.value) {
      print('Barberlar allaqachon yuklanmoqda, qayta yuklash bekor qilindi');
      return;
    }

    try {
      isLoadingMore.value = true;
      print(
          'Barberlar uchun keyingi sahifa yuklanmoqda: sahifa ${currentPage.value}');

      // Sahifa indekslarini hisoblash
      final startIndex = (currentPage.value - 1) * itemsPerPage;
      final endIndex = startIndex + itemsPerPage;

      // Agar barberlar ro'yxati tugagan bo'lsa
      if (startIndex >= filteredBarbers.length) {
        hasMoreItems.value = false;
        isLoadingMore.value = false;
        print('Barcha barberlar ko\'rsatilgan, boshqa barber yo\'q');
        return;
      }

      // Keyingi sahifa indeksi
      final actualEndIndex =
          endIndex > filteredBarbers.length ? filteredBarbers.length : endIndex;

      // Yangi barberlarni olish
      final newBarbers = filteredBarbers.sublist(startIndex, actualEndIndex);
      print(
          '${newBarbers.length} ta yangi barber yuklandi (${startIndex + 1}-$actualEndIndex)');

      // Yangi sahifa uchun kechikish (real API da kerak bo'lmaydi)
      await Future.delayed(const Duration(milliseconds: 300));

      // Barberlarni qo'shish
      displayedBarbers.addAll(newBarbers);
      print('Jami ${displayedBarbers.length} barber ko\'rsatilmoqda');

      // Keyingi sahifani belgilash
      currentPage.value++;

      // Yana barberlar bormi yo'qligini tekshirish
      hasMoreItems.value = endIndex < filteredBarbers.length;
      if (!hasMoreItems.value) {
        print('Barcha barberlar ko\'rsatildi, boshqa yuklash imkoniyati yo\'q');
      }
    } catch (e) {
      print('Barberlarni sahifalashda xatolik: $e');
    } finally {
      isLoadingMore.value = false;
    }
  }

  // Kategoriyalarni barberlar soni bo'yicha saralash - Home ekrani uchun
  void sortCategoriesByBarberCount() {
    categories.value = List.from(homeCategoriesByBarberCount);
    barberSortedCategories.value = List.from(homeCategoriesByBarberCount);
  }

  // Kategoriyalarni ID bo'yicha saralash - Home ekrani uchun
  void sortCategoriesById() {
    categories.value = List.from(homeCategoriesById);
    idSortedCategories.value = List.from(homeCategoriesById);
  }

  // Barcha kategoriyalarni qaytarish (filtrsiz) - boshqa ekranlar uchun
  List<CategoryModel> getAllCategories() {
    return allCategories;
  }

  // Barberlar soni bo'yicha saralangan barcha kategoriyalarni qaytarish
  List<CategoryModel> getAllCategoriesByBarberCount() {
    return allCategoriesByBarberCount;
  }

  // ID bo'yicha saralangan barcha kategoriyalarni qaytarish
  List<CategoryModel> getAllCategoriesById() {
    return allCategoriesById;
  }

  void setSelectedCategoryIndex(int index) {
    // Agar bir xil indeks tanlansa, hech narsa qilmaslik
    if (index == selectedCategoryIndex.value) {
      print(
          'setSelectedCategoryIndex: Bir xil kategoriya indeksi tanlandi ($index), o\'zgarish yo\'q');
      return;
    }

    print(
        'setSelectedCategoryIndex: Yangi kategoriya indeksi tanlanmoqda: $index (avvalgi: ${selectedCategoryIndex.value})');
    selectedCategoryIndex.value = index;
    // Bu ever() watcher'ni ishga tushiradi va filterBarbersBySelectedCategory avtomatik chaqiriladi
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
        final retrievedCategories =
            data.map((json) => CategoryModel.fromJson(json)).toList();

        // Barcha kategoriyalar o'z ichiga oladi BARCHA kategoriyalarni
        allCategories.value = List.from(retrievedCategories);

        // Barber soni 0 dan katta bo'lgan kategoriyalarni filtrlash
        final filteredCategories = retrievedCategories
            .where((category) => category.barbersCount > 0)
            .toList();

        // Agar filtrlandan keyin kategoriyalar bo'sh bo'lsa, bu holda original ro'yxatni ishlat
        final categoriesToUse = filteredCategories.isEmpty
            ? retrievedCategories
            : filteredCategories;

        // Barcha joylarda foydalanish uchun filter qilingan kategoriyalarni ishlatamiz

        // Home ekrani uchun va boshqa ekranlar uchun ham
        homeCategories.value = List.from(categoriesToUse);

        // Barberlar soni bo'yicha saralash
        final sortedByBarberCount = List<CategoryModel>.from(categoriesToUse);
        sortedByBarberCount
            .sort((a, b) => b.barbersCount.compareTo(a.barbersCount));
        homeCategoriesByBarberCount.value = sortedByBarberCount;

        // ID bo'yicha saralash
        final sortedById = List<CategoryModel>.from(categoriesToUse);
        sortedById.sort((a, b) => a.id.compareTo(b.id));
        homeCategoriesById.value = sortedById;

        // Eski o'zgaruvchilarni yangilash uchun
        barberSortedCategories.value = sortedByBarberCount;
        idSortedCategories.value = sortedById;
        categories.value = sortedByBarberCount;

        // Eng ko'p barberli 4 ta kategoriyani olish
        if (sortedByBarberCount.length > 4) {
          topCategories.value = sortedByBarberCount.sublist(0, 4);
        } else {
          topCategories.value = sortedByBarberCount;
        }

        // Barcha kategoriyalar ro'yxatlari uchun ham filter qilingan kategoriyalarni ishlatamiz
        allCategoriesByBarberCount.value = sortedByBarberCount;
        allCategoriesById.value = sortedById;
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
