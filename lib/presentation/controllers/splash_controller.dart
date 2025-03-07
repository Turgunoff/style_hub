import 'package:get/get.dart';
import '../../core/utils/logger.dart';
import '../routes/app_routes.dart';
import '../../core/services/storage/secure_storage.dart';
import '../../core/services/auth_service.dart';

class SplashController extends GetxController {
  final SecureStorage _secureStorage = Get.find<SecureStorage>();
  final AuthService _authService = Get.find<AuthService>();
  static const String _firstLaunchKey = 'first_launch_completed';
  final showSecondAnimation = false.obs;
  final isAnimationComplete = false.obs;

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

      // Auth holatini tekshirish
      await _authService.checkAuthStatus();

      // Keyingi ekranga o'tish
      if (await _isFirstLaunch()) {
        AppLogger.info('Navigating to onboarding screen');
        startSecondAnimation();
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
  Future<bool> _isFirstLaunch() async {
    try {
      final String? isCompleted =
          await _secureStorage.readData(key: _firstLaunchKey);

      // Agar _firstLaunchKey kalit mavjud bo'lmasa yoki "false" bo'lsa, demak birinchi marta
      if (isCompleted == null || isCompleted == "false") {
        // Birinchi ishga tushirilgandan so'ng true ga o'zgartirish
        await _secureStorage.writeData(key: _firstLaunchKey, value: "true");
        return true;
      }

      return false;
    } catch (e) {
      AppLogger.error('Error checking first launch: $e');
      return false; // Xatolik yuz berganda default qiymat
    }
  }

  void startSecondAnimation() {
    showSecondAnimation.value = true;
  }

  void onAnimationsComplete() {
    isAnimationComplete.value = true;
    // Animatsiyalar tugagandan so'ng 1 soniya kutib, keyingi ekranga o'tish
    Future.delayed(const Duration(seconds: 3), () {
      Get.offAllNamed(AppRoutes.ONBOARDING);
    });
  }
}
