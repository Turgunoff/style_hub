 import 'package:get/get.dart';

import '../../cart/bindings/cart_binding.dart';

class ProfileBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<ProfileController>(() => ProfileController());
  }
}