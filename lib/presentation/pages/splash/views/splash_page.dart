import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:get_storage/get_storage.dart';
// import 'package:looksy/presentation/routes/app_routes.dart';

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:looksy/presentation/pages/splash/controllers/splash_controller.dart';

import '../../../controllers/splash_controller.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Splash Screen'),
      ),
    );
  }
}
