import 'package:get/get.dart';
import '../../../../core/services/auth_service.dart';
import '../controller/onboarding_controller.dart';

class OnboardingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => OnboardingController(Get.find<AuthService>()));
  }
}
