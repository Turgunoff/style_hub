import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';

class ProfileController extends GetxController {
  final userName = 'Daniel Austin'.obs;
  final userEmail = 'daniel_austin@yourdomain.com'.obs;
  final userImage = 'https://example.com/profile.jpg'.obs;
  final isDarkMode = false.obs;

  void toggleTheme(bool value) {
    isDarkMode.value = value;
    Get.changeThemeMode(value ? ThemeMode.dark : ThemeMode.light);
  }

  void showLanguageDialog() {
    Get.dialog(
      AlertDialog(
        title: Text('select_language'.tr),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: const Text('English (US)'),
              onTap: () {
                Get.updateLocale(const Locale('en', 'US'));
                Get.back();
              },
            ),
            ListTile(
              title: const Text('O\'zbek'),
              onTap: () {
                Get.updateLocale(const Locale('uz', 'UZ'));
                Get.back();
              },
            ),
          ],
        ),
      ),
    );
  }

  void showLogoutDialog() {
    Get.dialog(
      AlertDialog(
        title: Text('logout'.tr),
        content: Text('logout_confirmation'.tr),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text('cancel'.tr),
          ),
          TextButton(
            onPressed: () {
              // Implement logout logic
              Get.offAllNamed('/login');
            },
            child: Text(
              'logout'.tr,
              style: const TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }

  void shareApp() {
    Share.share('Check out this amazing app: https://example.com/app');
  }
}