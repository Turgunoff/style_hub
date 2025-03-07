import 'package:get/get.dart';
import '../controller/profile_details_controller.dart';

class ProfileDetailsBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProfileDetailsController>(() => ProfileDetailsController());
  }
}
