import 'package:get/get.dart';
import '../bindings/onboarding_binding.dart';
import '../bindings/bottom_nav_binding.dart';
import '../pages/bottom_nav/bottom_nav_view.dart';
import '../pages/onboarding/onboarding_page.dart';
import 'app_routes.dart';
import '../pages/splash/splash_page.dart';
import '../pages/home/home_page.dart';
import '../bindings/splash_binding.dart';
import '../bindings/home_binding.dart';

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
      name: AppRoutes.ONBOARDING,
      page: () => OnboardingPage(),
      binding: OnboardingBinding(),
    ),
  ];
}
