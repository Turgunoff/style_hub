import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/services.dart';
import 'package:get_storage/get_storage.dart';

// Core
import 'core/theme/app_theme.dart';
// import 'core/theme/dark_theme.dart';
// import 'core/theme/light_theme.dart';
import 'core/constants/app_constants.dart';
import 'core/localization/app_localization.dart';

// Routes
import 'presentation/routes/app_pages.dart';
import 'presentation/routes/app_routes.dart';

// Bindings
import 'presentation/bindings/initial_binding.dart';

// Services
import 'core/services/storage/secure_storage.dart';
import 'core/services/connectivity/connectivity_service.dart';
// import 'core/services/notification/notification_service.dart';

Future<void> main() async {
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

    runApp(const MyApp());
  } catch (error) {
    print('Error in main: $error');
    runApp(const ErrorApp());
  }
}

Future<void> initServices() async {
  // Servislarni ishga tushirish
  await Get.putAsync(() => SecureStorage().init());
  await Get.putAsync(() => ConnectivityService().init());
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

      // Tema sozlamalari
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: ThemeMode.system,

      // Til sozlamalari
      translations: AppLocalization(),
      locale: const Locale('uz', 'UZ'), // Boshlang'ich til
      fallbackLocale: const Locale('en', 'US'), // Zaxira til

      // Routing
      initialRoute: AppRoutes.BOTTOM_NAV,
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
    return MaterialApp(
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
