import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../routes/app_routes.dart';

class SplashController extends GetxController {
  final _storage = GetStorage(); // GetStorage instance

  @override
  void onInit() {
    print('SplashController onInit called'); // Konsolda chiqishi kerak
    super.onInit();
    _checkFirstLaunch();
  }

  Future<void> _checkFirstLaunch() async {
    try {
      await Future.delayed(const Duration(seconds: 2));

      final isFirstLaunch = _storage.read<bool>('isFirstLaunch') ?? true;
      print('isFirstLaunch: $isFirstLaunch'); // Qo‘shilgan print

      if (isFirstLaunch) {
        await _storage.write('isFirstLaunch', false);
        print('Navigating to ONBOARDING...');
        Get.offAllNamed(AppRoutes.ONBOARDING);
      } else {
        print('Navigating to BOTTOM_NAV...');
        Get.offAllNamed(AppRoutes.BOTTOM_NAV);
      }
    } catch (e) {
      print('Error in _checkFirstLaunch: $e');
      Get.offAllNamed(AppRoutes.BOTTOM_NAV);
    }
  }
}
