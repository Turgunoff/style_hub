import 'package:get/get.dart';
// import 'package:looksy/presentation/controllers/booking_controller.dart';
import '../controller/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    //home lazy put
    Get.lazyPut<HomeController>(
      () => HomeController(),
    );

    // Get.put(HomeController());
    // Get.put(BookingController());

    // Add controllers if needed
  }
}
