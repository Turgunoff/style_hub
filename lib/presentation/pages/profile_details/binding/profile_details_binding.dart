import 'package:get/get.dart';
import '../../../controllers/profile_details_controller.dart';

class ProfileDetailsBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProfileDetailsController>(() => ProfileDetailsController());
  }
}
