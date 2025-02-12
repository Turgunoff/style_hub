import 'package:get/get.dart';
import '../../../controllers/booking_controller.dart';

class BookingBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BookingController>(
      () => BookingController(),
    );
  }
}
