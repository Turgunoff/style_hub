import 'package:get/get.dart';
import 'package:looksy/presentation/pages/inbox/controller/inbox_controller.dart';

class InboxBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<InboxController>(
      () => InboxController(),
    );
  }
}
