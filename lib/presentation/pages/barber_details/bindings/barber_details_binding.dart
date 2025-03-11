import 'package:get/get.dart';
import '../controller/barber_details_controller.dart';

class BarberDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => BarberDetailsController());
  }
}
