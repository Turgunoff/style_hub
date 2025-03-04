import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';

class ProfileController extends GetxController {
  // Foydalanuvchi ma'lumotlari
  final userName = 'Aziz Sultonov'.obs;
  final userEmail = 'aziz.sultonov@gmail.com'.obs;
  final userImage = 'https://example.com/profile.jpg'.obs;

  // Ilova sozlamalari
  final isDarkMode = false.obs;

  // Mavzuni o'zgartirish
  void toggleTheme(bool value) {
    isDarkMode.value = value;
    Get.changeThemeMode(value ? ThemeMode.dark : ThemeMode.light);
  }

  // Til tanlash dialogini ko'rsatish
  void showLanguageDialog() {
    Get.dialog(
      AlertDialog(
        title: Text('Tilni tanlang'),
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
            onPressed: () {
              // Tizimdan chiqish logikasi
              Get.offAllNamed('/login');
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
