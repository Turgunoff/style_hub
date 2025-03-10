import 'package:get/get.dart';
import '../../../../core/services/auth_service.dart';
import '../../../../core/utils/logger.dart';
import '../../../routes/app_routes.dart';

class SplashController extends GetxController {
  final AuthService _authService;
  final showSecondAnimation = false.obs;

  SplashController(this._authService);

  @override
  void onInit() {
    super.onInit();
    AppLogger.debug('Initializing SplashController');
    checkAuthStatus();
  }

  void startSecondAnimation() {
    AppLogger.debug('Starting second splash animation');
    showSecondAnimation.value = true;
  }

  Future<void> onAnimationsComplete() async {
    AppLogger.debug('Splash animations completed');

    if (!_authService.isOnboardingCompleted.value) {
      AppLogger.info('Navigating to onboarding screen');
      Get.offAllNamed(AppRoutes.ONBOARDING);
      return;
    }

    if (_authService.isAuthenticated.value) {
      AppLogger.info('User is authenticated, navigating to main screen');
      Get.offAllNamed(AppRoutes.BOTTOM_NAV);
    } else {
      AppLogger.info('User is not authenticated, navigating to login screen');
      Get.offAllNamed(AppRoutes.BOTTOM_NAV);
    }
  }

  Future<void> checkAuthStatus() async {
    AppLogger.debug('Checking authentication status');
    try {
      await _authService.checkAuthStatus();
      AppLogger.info('Auth status check completed');
    } catch (e) {
      AppLogger.error('Error checking auth status: $e');
    }
  }
}
