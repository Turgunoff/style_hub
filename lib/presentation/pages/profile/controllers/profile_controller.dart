import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import '../../../../core/services/auth_service.dart';
import '../../../../core/utils/logger.dart';

/// Profil sahifasi uchun controller
///
/// Bu controller profil sahifasidagi barcha holatlarni va amallarni
/// boshqarish uchun ishlatiladi. Foydalanuvchi ma'lumotlarini yuklaydi,
/// til va mavzu sozlamalarini o'zgartiradi, tizimdan chiqish va ilova
/// ulashish funksiyalarini bajaradi.
class ProfileController extends GetxController {
  /// Autentifikatsiya xizmati
  ///
  /// Foydalanuvchi ma'lumotlari va autentifikatsiya holatini
  /// boshqarish uchun ishlatiladi.
  final AuthService _authService;

  // =========== FOYDALANUVCHI MA'LUMOTLARI ===========

  /// Foydalanuvchining to'liq ismi
  ///
  /// API dan olingan foydalanuvchi ismini saqlaydi.
  final userName = ''.obs;

  /// Foydalanuvchining elektron pochtasi
  ///
  /// API dan olingan foydalanuvchi emailini saqlaydi.
  final userEmail = ''.obs;

  /// Foydalanuvchi profilining rasmiga URL
  ///
  /// API dan olingan foydalanuvchi avatarini saqlaydi.
  /// Agar avatar bo'lmasa, standart avatar generatsiya qilinadi.
  final userImage = ''.obs;

  // =========== ILOVA SOZLAMALARI ===========

  /// Qorong'i mavzu holatini ko'rsatadi
  ///
  /// true - qorong'i mavzu yoqilgan
  /// false - yorug' mavzu yoqilgan
  final isDarkMode = false.obs;

  /// Yuklash holati indikatori
  ///
  /// Ma'lumotlar yuklanayotganda true qiymatida bo'ladi
  final isLoading = false.obs;

  /// Foydalanuvchi autentifikatsiya holatini ko'rsatadi
  ///
  /// true - foydalanuvchi tizimga kirgan
  /// false - foydalanuvchi tizimga kirmagan
  final isAuthenticated = false.obs;

  /// Controller konstruktori
  ///
  /// AuthService ni DI orqali oladi
  ProfileController(this._authService);

  /// Controller ishga tushganda chaqiriladigan metod
  ///
  /// Foydalanuvchi autentifikatsiya holatini tekshiradi
  /// va ma'lumotlarni yuklaydi
  @override
  void onInit() {
    super.onInit();
    AppLogger.debug('Initializing ProfileController');
    // AuthService dan autentifikatsiya holatini olish
    isAuthenticated.value = _authService.isAuthenticated.value;
    // Foydalanuvchi ma'lumotlarini yuklash
    loadUserData();
  }

  /// Foydalanuvchi ma'lumotlarini yuklash
  ///
  /// API orqali foydalanuvchi ma'lumotlarini oladi va
  /// controller o'zgaruvchilarini yangilaydi.
  /// Ma'lumotlarni yuklash davomida xatolik yuz berganda,
  /// xatolik qayd qilinadi, ammo UI ga xatolik ko'rsatilmaydi.
  Future<void> loadUserData() async {
    // Yuklash holatini true qilish (UI da loading ko'rsatish uchun)
    isLoading.value = true;
    try {
      AppLogger.debug('Starting to load user data');
      // AuthService dan foydalanuvchi ma'lumotlarini olish
      final userData = await _authService.getUserInfo();

      // Foydalanuvchi tizimga kirmagan bo'lsa
      if (userData == null) {
        AppLogger.info('No user data available - user not authenticated');
        return;
      }

      // Foydalanuvchi ismini yangilash
      userName.value = userData['full_name'] ?? '';
      AppLogger.debug('Updated userName: ${userName.value}');

      // Foydalanuvchi emailini yangilash
      userEmail.value = userData['email'] ?? '';
      AppLogger.debug('Updated userEmail: ${userEmail.value}');

      // Foydalanuvchi avatarini yangilash
      if (userData['avatar'] != null &&
          userData['avatar'].toString().isNotEmpty) {
        // API dan kelgan avatarni o'rnatish
        userImage.value = userData['avatar'];
        AppLogger.debug('Set avatar image: ${userImage.value}');
      } else {
        // Avatar bo'lmasa, UI Avatars orqali generatsiya qilish
        userImage.value =
            'https://ui-avatars.com/api/?name=${Uri.encodeComponent(userName.value)}&background=random';
        AppLogger.debug('Set default avatar image: ${userImage.value}');
      }
      AppLogger.info('User data loaded successfully');
    } catch (e) {
      // Xatolikni qayd qilish
      AppLogger.error('Error loading user data: $e');
      // Bu yerda UI ga xatolik ko'rsatish mumkin
    } finally {
      // Yuklash holatini false qilish
      isLoading.value = false;
    }
  }

  /// Mavzuni o'zgartirish
  ///
  /// Yorug' va qorong'i mavzuni o'zgartirib, ilovaga qo'llaydi.
  /// @param value Qorong'i mavzu yoqilgan (true) yoki o'chirilgan (false)
  void toggleTheme(bool value) {
    // isDarkMode o'zgaruvchisini yangilash
    isDarkMode.value = value;
    // GetX tizimida mavzuni o'zgartirish
    Get.changeThemeMode(value ? ThemeMode.dark : ThemeMode.light);
  }

  /// Til tanlash dialogini ko'rsatish
  ///
  /// Foydalanuvchiga til tanlash imkoniyatini beradi va
  /// tanlangan tilni ilovaga qo'llaydi.
  /// Hozirda faqat o'zbek va ingliz tillari mavjud.
  void showLanguageDialog() {
    // Dialog oynasini ko'rsatish
    Get.dialog(
      AlertDialog(
        title: const Text('Tilni tanlang'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // O'zbek tilini tanlash
            ListTile(
              title: const Text('O\'zbek'),
              onTap: () {
                // O'zbek tiliga o'zgartirish
                Get.updateLocale(const Locale('uz', 'UZ'));
                // Dialog oynasini yopish
                Get.back();
              },
            ),
            // Ingliz tilini tanlash
            ListTile(
              title: const Text('English (US)'),
              onTap: () {
                // Ingliz tiliga o'zgartirish
                Get.updateLocale(const Locale('en', 'US'));
                // Dialog oynasini yopish
                Get.back();
              },
            ),
          ],
        ),
      ),
    );
  }

  /// Tizimdan chiqish dialogini ko'rsatish
  ///
  /// Foydalanuvchiga tizimdan chiqish amali tasdiqlash so'raladi.
  /// "Chiqish" tugmasi bosilganda, logout() metodi chaqiriladi.
  void showLogoutDialog() {
    AppLogger.debug('Showing logout confirmation dialog');
    // Dialog oynasini ko'rsatish
    Get.dialog(
      AlertDialog(
        title: const Text('Tizimdan chiqish'),
        content: const Text('Haqiqatan ham tizimdan chiqmoqchimisiz?'),
        actions: [
          // Bekor qilish tugmasi
          TextButton(
            onPressed: () {
              AppLogger.debug('Logout cancelled by user');
              // Dialog oynasini yopish
              Get.back();
            },
            child: const Text('Bekor qilish'),
          ),
          // Chiqish tugmasi
          TextButton(
            onPressed: () async {
              AppLogger.debug('User confirmed logout');
              // Tizimdan chiqish amalini bajarish
              await logout();
              // Dialog oynasini yopish
              Get.back();
            },
            child: const Text('Chiqish'),
          ),
        ],
      ),
    );
  }

  /// Ilovani ulashish
  ///
  /// Ilova haqidagi ma'lumotlarni boshqalar bilan ulashish
  /// imkoniyatini beradi. Share Plus paketi orqali amalga oshiriladi.
  void shareApp() {
    // Ulashish dialogini ko'rsatish
    Share.share('Bu ajoyib ilovani ko\'ring: https://example.com/app');
  }

  /// Tizimdan chiqish
  ///
  /// Foydalanuvchini tizimdan chiqarish amalini bajaradi.
  /// AuthService orqali qo'shimcha amallar ham bajariladi
  /// (tokenni o'chirish, sessiyani tugatish va h.k.).
  Future<void> logout() async {
    AppLogger.debug('Initiating logout process');
    try {
      // AuthService dagi logout metodini chaqirish
      await _authService.logout();
      AppLogger.info('User logged out successfully');
    } catch (e) {
      // Xatolikni qayd qilish
      AppLogger.error('Error during logout: $e');
      // Xatolik xabarini ko'rsatish
      Get.snackbar(
        'Xatolik',
        'Tizimdan chiqishda xatolik yuz berdi',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }
}
