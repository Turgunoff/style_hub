import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import '../../../../core/services/auth_service.dart';
import '../../../../core/utils/logger.dart';

class ProfileController extends GetxController {
  final AuthService _authService;

  // Foydalanuvchi ma'lumotlari
  final userName = ''.obs;
  final userEmail = ''.obs;
  final userImage = ''.obs;

  // Ilova sozlamalari
  final isDarkMode = false.obs;
  final isLoading = false.obs;
  final isAuthenticated = false.obs;

  ProfileController(this._authService);

  @override
  void onInit() {
    super.onInit();
    AppLogger.debug('Initializing ProfileController');
    isAuthenticated.value = _authService.isAuthenticated.value;
    loadUserData();
  }

  // Foydalanuvchi ma'lumotlarini yuklash
  Future<void> loadUserData() async {
    isLoading.value = true;
    try {
      AppLogger.debug('Starting to load user data');
      final userData = await _authService.getUserInfo();

      if (userData == null) {
        AppLogger.info('No user data available - user not authenticated');
        return;
      }

      userName.value = userData['full_name'] ?? '';
      AppLogger.debug('Updated userName: ${userName.value}');

      userEmail.value = userData['email'] ?? '';
      AppLogger.debug('Updated userEmail: ${userEmail.value}');

      if (userData['avatar'] != null &&
          userData['avatar'].toString().isNotEmpty) {
        userImage.value = userData['avatar'];
        AppLogger.debug('Set avatar image: ${userImage.value}');
      } else {
        userImage.value =
            'https://ui-avatars.com/api/?name=${Uri.encodeComponent(userName.value)}&background=random';
        AppLogger.debug('Set default avatar image: ${userImage.value}');
      }
      AppLogger.info('User data loaded successfully');
    } catch (e) {
      AppLogger.error('Error loading user data: $e');
    } finally {
      isLoading.value = false;
    }
  }

  // Mavzuni o'zgartirish
  void toggleTheme(bool value) {
    isDarkMode.value = value;
    Get.changeThemeMode(value ? ThemeMode.dark : ThemeMode.light);
  }

  // Til tanlash dialogini ko'rsatish
  void showLanguageDialog() {
    Get.dialog(
      AlertDialog(
        title: const Text('Tilni tanlang'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: const Text('O\'zbek'),
              onTap: () {
                Get.updateLocale(const Locale('uz', 'UZ'));
                Get.back();
              },
            ),
            ListTile(
              title: const Text('English (US)'),
              onTap: () {
                Get.updateLocale(const Locale('en', 'US'));
                Get.back();
              },
            ),
          ],
        ),
      ),
    );
  }

  // Tizimdan chiqish dialogini ko'rsatish
  void showLogoutDialog() {
    AppLogger.debug('Showing logout confirmation dialog');
    Get.dialog(
      AlertDialog(
        title: const Text('Tizimdan chiqish'),
        content: const Text('Haqiqatan ham tizimdan chiqmoqchimisiz?'),
        actions: [
          TextButton(
            onPressed: () {
              AppLogger.debug('Logout cancelled by user');
              Get.back();
            },
            child: const Text('Bekor qilish'),
          ),
          TextButton(
            onPressed: () async {
              AppLogger.debug('User confirmed logout');
              await logout();
              Get.back();
            },
            child: const Text('Chiqish'),
          ),
        ],
      ),
    );
  }

  // Ilovani ulashish
  void shareApp() {
    Share.share('Bu ajoyib ilovani ko\'ring: https://example.com/app');
  }

  Future<void> logout() async {
    AppLogger.debug('Initiating logout process');
    try {
      await _authService.logout();
      AppLogger.info('User logged out successfully');
    } catch (e) {
      AppLogger.error('Error during logout: $e');
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
