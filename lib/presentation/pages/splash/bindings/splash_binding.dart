import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../controller/splash_controller.dart';

class SplashBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(GetStorage()); // Lazy bo‘lmagan versiyasi
    Get.put(SplashController()); // Lazy emas, to‘g‘ri ishlaydi
  }
}
