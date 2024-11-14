import 'package:flutter/material.dart';
import 'package:style_hub/screens/home_screen/home_screen.dart';
import 'package:style_hub/screens/splash/splash_screen.dart';

import 'screens/bottom_nav_bar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Debug modeni yopish
      title: 'Flutter Demo',
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
