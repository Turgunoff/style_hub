import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../core/services/auth_service.dart';
import '../pages/home/bindings/home_binding.dart';
import '../pages/booking/bindings/booking_binding.dart';
import '../pages/explore/bindings/explore_binding.dart';
import '../pages/profile/bindings/profile_binding.dart';
import '../pages/inbox/bindings/inbox_binding.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    // 1. Core Services (permanent)
    Get.put(GetStorage(), permanent: true);

    // 2. Main Services (permanent)
    Get.put(AuthService(), permanent: true);

    // 3. Main Controllers through their bindings
    HomeBinding().dependencies();
    BookingBinding().dependencies();
    ExploreBinding().dependencies();
    ProfileBinding().dependencies();
    InboxBinding().dependencies();
    // OnboardingBinding().dependencies();

    // 4. Other Controllers will be lazy loaded when needed through their own bindings
    // This ensures controllers are only created when their views are accessed
  }
}
