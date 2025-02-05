import 'package:get/get.dart';
import '../bindings/onboarding_binding.dart';
import '../pages/onboarding/onboarding_page.dart';
import 'app_routes.dart';
import '../pages/splash/splash_page.dart';
import '../pages/home/home_page.dart';
import '../bindings/splash_binding.dart';
import '../bindings/home_binding.dart';

class AppPages {
  static final routes = [
    GetPage(
      name: AppRoutes.SPLASH,
      page: () => const SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: AppRoutes.HOME,
      page: () => const HomePage(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: AppRoutes.ONBOARDING,
      page: () => OnboardingPage(),
      binding: OnboardingBinding(),
    ),
  ];
}
