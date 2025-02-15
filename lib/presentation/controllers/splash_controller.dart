import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../routes/app_routes.dart';

class SplashController extends GetxController {
  final _storage = GetStorage(); // GetStorage instance

  @override
  void onInit() {
    super.onInit();
    _checkFirstLaunch();
  }

  Future<void> _checkFirstLaunch() async {
    try {
      // 3 sekund kutish
      await Future.delayed(const Duration(seconds: 3));

      // GetStorage dan qiymatni o'qish
      final isFirstLaunch = _storage.read<bool>('isFirstLaunch') ?? true;

      if (isFirstLaunch) {
        // Birinchi marta ochilganda
        await _storage.write('isFirstLaunch', false);
        Get.offAllNamed(AppRoutes.ONBOARDING);
      } else {
        // Keyingi ochilishlarda
        Get.offAllNamed(AppRoutes.BOTTOM_NAV);
      }
    } catch (e) {
      print('Error in _checkFirstLaunch: $e');
      // Xatolik yuz berganda ham asosiy sahifaga o'tish
      Get.offAllNamed(AppRoutes.BOTTOM_NAV);
    }
  }
}
