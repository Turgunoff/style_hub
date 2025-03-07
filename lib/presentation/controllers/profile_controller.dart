import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import '../../core/services/auth_service.dart';

class ProfileController extends GetxController {
  final _authService = Get.find<AuthService>();

  // Foydalanuvchi ma'lumotlari
  final userName = ''.obs;
  final userEmail = ''.obs;
  final userImage = ''.obs;

  // Ilova sozlamalari
  final isDarkMode = false.obs;
  final isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    loadUserData();
  }

  // Foydalanuvchi ma'lumotlarini yuklash
  Future<void> loadUserData() async {
    isLoading.value = true;
    try {
      final userData = await _authService.getUserInfo();
      userName.value = userData['name'] ?? '';
      userEmail.value = userData['email'] ?? '';
      // Default rasm URL'i
      userImage.value =
          'https://ui-avatars.com/api/?name=${Uri.encodeComponent(userName.value)}&background=random';
    } catch (e) {
      debugPrint('Error loading user data: $e');
    }
    isLoading.value = false;
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
    Get.dialog(
      AlertDialog(
        title: const Text('Tizimdan chiqish'),
        content: const Text('Haqiqatan ham tizimdan chiqmoqchimisiz?'),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text('Bekor qilish'),
          ),
          TextButton(
            onPressed: () async {
              await _authService.logout();
              Get.back(); // Dialog oynasini yopish
            },
            child: const Text(
              'Chiqish',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }

  // Ilovani ulashish
  void shareApp() {
    Share.share('Bu ajoyib ilovani ko\'ring: https://example.com/app');
  }
}
