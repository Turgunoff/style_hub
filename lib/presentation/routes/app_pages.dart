import 'package:get/get.dart';
import 'package:looksy/presentation/pages/explore/bindings/explore_binding.dart';
import 'package:looksy/presentation/pages/explore/views/explore_view.dart';
import '../pages/booking/bindings/booking_binding.dart';
import '../pages/booking/views/booking_view.dart';
import '../pages/onboarding/bindings/onboarding_binding.dart';
import '../pages/bottom_nav/bindings/bottom_nav_binding.dart';
import '../pages/bottom_nav/views/bottom_nav_view.dart';
import '../pages/onboarding/views/onboarding_page.dart';
import 'app_routes.dart';
import '../pages/splash/views/splash_page.dart';
import '../pages/home/views/home_view.dart';
import '../pages/splash/bindings/splash_binding.dart';
import '../pages/home/bindings/home_binding.dart';
import '../pages/profile_details/view/profile_details_view.dart';
import '../pages/profile_details/binding/profile_details_binding.dart';

class AppPages {
  static final routes = [
    GetPage(
      name: AppRoutes.BOTTOM_NAV,
      page: () => BottomNavView(),
      binding: BottomNavBinding(),
    ),
    GetPage(
      name: AppRoutes.SPLASH,
      page: () => const SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: AppRoutes.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: AppRoutes.EXPLORE,
      page: () => const ExploreView(),
      binding: ExploreBinding(),
    ),
    GetPage(
      name: AppRoutes.ONBOARDING,
      page: () => OnboardingPage(),
      binding: OnboardingBinding(),
    ),
    GetPage(
      name: AppRoutes.BOOKING,
      page: () => const BookingView(),
      binding: BookingBinding(),
    ),
    GetPage(
      name: AppRoutes.PROFILE_DETAILS,
      page: () => const ProfileDetailsView(),
      binding: ProfileDetailsBinding(),
    ),
  ];
}
