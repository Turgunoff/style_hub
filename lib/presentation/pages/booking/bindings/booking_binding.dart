import 'package:get/get.dart';

import '../../../controllers/booking_controller.dart';

// import '../../../controllers/booking_controller.dart';

class BookingBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(BookingController());

    // Add controllers if needed
  }
}
