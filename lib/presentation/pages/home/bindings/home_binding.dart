import 'package:get/get.dart';
// import 'package:style_hub/presentation/controllers/booking_controller.dart';
import '../../../controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(HomeController());
    // Get.put(BookingController());

    // Add controllers if needed
  }
}
