import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../routes/app_routes.dart';

class SplashController extends GetxController {
  final _storage = Get.find<GetStorage>(); // GetStorage instance

  @override
  void onInit() {
    super.onInit();
    _checkFirstLaunch();
    print('onInit');
  }

  Future<void> _checkFirstLaunch() async {
    await Future.delayed(Duration(seconds: 3)); // Kuting 3 sekund

    // Read the value from GetStorage
    final isFirstLaunch = _storage.read<bool>('isFirstLaunch');

    if (isFirstLaunch == null) {
      // Birinchi marta ochilganda
      _storage.write('isFirstLaunch', false);
      Get.offAllNamed(
          AppRoutes.ONBOARDING); // offNamed o'rniga offAllNamed ishlating
      print('First launch');
    } else {
      // Keyingi ochilishlar
      Get.offAllNamed(AppRoutes.HOME); // offNamed o'rniga offAllNamed ishlating
      print('Not first launch');
    }
  }
}
