import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/services.dart';
import 'package:get_storage/get_storage.dart';

import 'core/theme/app_theme.dart';
// import 'core/theme/dark_theme.dart';
// import 'core/theme/light_theme.dart';
import 'core/constants/app_constants.dart';
import 'core/localization/app_localization.dart';
import 'core/utils/logger.dart';

// Routes
import 'presentation/routes/app_pages.dart';
import 'presentation/routes/app_routes.dart';

// Bindings
import 'presentation/bindings/initial_binding.dart';

// Services
import 'core/services/storage/secure_storage.dart';
import 'core/services/connectivity/connectivity_service.dart';
import 'core/services/auth_service.dart';
// import 'core/services/notification/notification_service.dart';

Future<void> main() async {
  // Ilovani ishga tushirish
  // Bu funksiya ilovaning asosiy funksiyasi
  try {
    WidgetsFlutterBinding.ensureInitialized();
    await GetStorage.init();

    // Orientatsiyani o'rnatish
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    // Status bar rangini sozlash
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
    );

    // Servislarni ishga tushirish
    await initServices();

    // AuthService'ni ishga tushirish
    await Get.putAsync(() async => AuthService());

    runApp(const MyApp());
  } catch (error) {
    AppLogger.error('Error in main: $error');
    runApp(const ErrorApp());
  }
}

Future<void> initServices() async {
  // Bu funksiya ilovaning asosiy servislarini ishga tushirish uchun ishlatiladi

  // Xavfsiz ma'lumotlarni saqlash xizmatini ishga tushirish
  // (masalan: tokenlar, kalitlar va boshqa maxfiy ma'lumotlarni saqlash uchun)
  await Get.putAsync(() => SecureStorage().init());

  // Internet aloqasini tekshirish xizmatini ishga tushirish
  // (internetga ulanish bor yoki yo'qligini kuzatib borish uchun)
  await Get.putAsync(() => ConnectivityService().init());

  // Push-bildirishnomalar xizmati (hozircha o'chirilgan)
  // await Get.putAsync(() => NotificationService().init());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      // Ilova nomi
      title: AppConstants.appName,

      debugShowCheckedModeBanner: false,

      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: ThemeMode.system,

      translations: AppLocalization(),
      locale: const Locale('uz', 'UZ'), // Boshlang'ich til
      fallbackLocale: const Locale('en', 'US'), // Zaxira til
      // Routing
      initialRoute: AppRoutes.splash, // Changed from SPLASH to splash
      getPages: AppPages.routes,

      // Initial binding
      initialBinding: InitialBinding(),

      // Default transition effect
      defaultTransition: Transition.fade,

      // Error handling
      onUnknownRoute: (settings) {
        return GetPageRoute(
          page: () => const NotFoundPage(),
        );
      },

      // Navigation observer
      navigatorObservers: [
        GetObserver(),
      ],
    );
  }
}

class ErrorApp extends StatelessWidget {
  const ErrorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: Center(
          child: Text(
            'Ilovani ishga tushirishda xatolik yuz berdi',
            style: TextStyle(fontSize: 16),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}

class NotFoundPage extends StatelessWidget {
  const NotFoundPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'Sahifa topilmadi',
          style: TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}
