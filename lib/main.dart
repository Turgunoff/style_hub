import 'package:flutter/material.dart';
import 'package:style_hub/presentation/screens/splash/splash_screen.dart';

import 'presentation/screens/bottom_navbar/bottom_nav_bar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
        ),
        scaffoldBackgroundColor:
            Colors.white, // Fon rangini oq rangga o'rnatish
      ),
      debugShowCheckedModeBanner: false, // Debug modeni yopish
      home:
          const SplashScreen(), // Splash screenni boshlang'ich ekran sifatida belgilash
      routes: {
        '/bottomNavBar': (context) =>
            const BottomNavBar(), // Botom Nav Bar sifatida belgilash
        // '/home': (context) => const HomeScreen(),
      },
    );
  }
}
