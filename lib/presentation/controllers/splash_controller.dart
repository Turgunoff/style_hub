import 'package:get/get.dart';
import '../../core/utils/logger.dart';
import '../routes/app_routes.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    AppLogger.info('SplashController initialized');
    _navigateToNextScreen();
  }

  Future<void> _navigateToNextScreen() async {
    try {
      // Splash ekranida 3 sekund kutish
      await Future.delayed(const Duration(seconds: 3));

      // Keyingi ekranga o'tish
      if (await _isFirstLaunch()) {
        AppLogger.info('Navigating to onboarding screen');
        Get.offAllNamed(AppRoutes.ONBOARDING);
      } else {
        AppLogger.info('Navigating to bottom nav screen');
        Get.offAllNamed(AppRoutes.BOTTOM_NAV);
      }
    } catch (e) {
      AppLogger.error('Error during navigation: $e');
      // Xatolik yuz berganda ham asosiy ekranga o'tish
      Get.offAllNamed(AppRoutes.BOTTOM_NAV);
    }
  }

  // Ilova birinchi marta ishga tushirilganligini tekshirish
  // Bu yerda SharedPreferences yoki boshqa storage ishlatilishi kerak
  Future<bool> _isFirstLaunch() async {
    // Hozircha har doim false qaytarish (ya'ni onboarding ko'rsatilmaydi)
    return false;
  }
}
