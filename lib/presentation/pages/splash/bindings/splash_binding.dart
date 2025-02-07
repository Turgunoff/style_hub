import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../controllers/splash_controller.dart';

class SplashBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GetStorage>(() => GetStorage()); // Lazy initialization
    Get.put(SplashController());
  }
}
