import 'package:get/get.dart';
import 'package:looksy/presentation/controllers/bottom_nav_controller.dart';

class BottomNavBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(BottomNavController());
  }
}
