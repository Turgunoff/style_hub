import 'package:get/get.dart';
import 'package:looksy/presentation/pages/bottom_nav/controller/bottom_nav_controller.dart';

class BottomNavBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(BottomNavController());
  }
}
