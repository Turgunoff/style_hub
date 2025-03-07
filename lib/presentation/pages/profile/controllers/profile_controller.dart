import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import '../../../../core/services/auth_service.dart';

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
      debugPrint('Starting to load user data...');
      final userData = await _authService.getUserInfo();
      debugPrint('Received user data in ProfileController: $userData');

      if (userData == null) {
        throw Exception('User data is null');
      }

      userName.value = userData['full_name'] ?? '';
      debugPrint('Set userName.value to: ${userName.value}');

      userEmail.value = userData['email'] ?? '';
      debugPrint('Set userEmail.value to: ${userEmail.value}');

      // Default rasm URL'i
      if (userData['avatar'] != null &&
          userData['avatar'].toString().isNotEmpty) {
        userImage.value = userData['avatar'];
        debugPrint('Set userImage.value to avatar: ${userImage.value}');
      } else {
        userImage.value =
            'https://ui-avatars.com/api/?name=${Uri.encodeComponent(userName.value)}&background=random';
        debugPrint('Set userImage.value to default: ${userImage.value}');
      }
    } catch (e, stackTrace) {
      debugPrint('Error in loadUserData: $e');
      debugPrint('Stack trace: $stackTrace');
      Get.snackbar(
        'Xatolik',
        'Ma\'lumotlarni yuklashda xatolik yuz berdi',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
      debugPrint('Loading completed. Current values:');
      debugPrint('userName: ${userName.value}');
      debugPrint('userEmail: ${userEmail.value}');
      debugPrint('userImage: ${userImage.value}');
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
