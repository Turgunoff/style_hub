import 'package:get/get.dart';
import 'package:style_hub/presentation/controllers/inbox_controller.dart';

class InboxBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<InboxController>(
      () => InboxController(),
    );
  }
}
