import 'package:get/get.dart';
import '../pages/booking/bindings/booking_binding.dart';
import '../pages/explore/bindings/explore_binding.dart';
import '../pages/home/bindings/home_binding.dart';
import '../pages/inbox/bindings/inbox_binding.dart';
import '../pages/onboarding/bindings/onboarding_binding.dart';
import '../pages/profile/bindings/profile_binding.dart';
import '../pages/splash/bindings/splash_binding.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    // Controllers va servicelarga dependency injection
    // Bindinglarni e'lon qilish
    SplashBinding().dependencies();
    HomeBinding().dependencies();
    BookingBinding().dependencies();
    ExploreBinding().dependencies();
    ProfileBinding().dependencies();
    InboxBinding().dependencies();
    OnboardingBinding().dependencies();
  }
}
