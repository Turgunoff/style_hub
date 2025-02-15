import 'package:get/get.dart';
import 'package:style_hub/presentation/controllers/booking_controller.dart';
import 'package:style_hub/presentation/controllers/profile_controller.dart';
import 'package:style_hub/presentation/pages/explore/bindings/explore_binding.dart';

import '../controllers/bottom_nav_controller.dart';
import '../controllers/home_controller.dart';
import '../controllers/splash_controller.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    // Controllers va servicelarga dependency injection
    Get.put(SplashController());
    Get.put(HomeController());
    Get.put(BottomNavController());
    Get.put(BookingController());
    Get.put(ExploreBinding());
    Get.put(ProfileController());
  }
}
