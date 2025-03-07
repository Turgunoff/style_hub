import 'package:get/get.dart';
import 'package:looksy/presentation/pages/onboarding/controller/onboarding_controller.dart';

class OnboardingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OnboardingController>(() => OnboardingController());
  }
}
