import 'package:get/get.dart';
import '../controller/explore_controller.dart';

class ExploreBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ExploreController());
  }
}
