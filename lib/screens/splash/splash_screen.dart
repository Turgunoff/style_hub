import 'dart:async';

import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      // 3 sekunddan keyin home screenga o'tish
      Navigator.pushReplacementNamed(context, '/bottomNavBar');
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(
          color: Colors.blue, // Progress barning rengi
          strokeWidth: 5, // Progress barningni bo'lishi
          backgroundColor: Colors.white, // Progress barningni background rengi
        ), // Splash screen uchun logotip
      ),
    );
  }
}
