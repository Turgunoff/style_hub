import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
// import 'package:get_storage/get_storage.dart';
// import 'package:looksy/presentation/routes/app_routes.dart';

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:looksy/presentation/pages/splash/controllers/splash_controller.dart';

import '../controller/splash_controller.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Theme.of(context).primaryColor,
              Theme.of(context).primaryColor.withOpacity(0.5),
            ],
          ),
        ),
        child: SafeArea(
          child: Stack(
            children: [
              // Orqa fon animatsiyasi
              Positioned.fill(
                child: SpinKitPulse(
                  color: Colors.white.withOpacity(0.1),
                  size: 300.0,
                ),
              ),

              // Asosiy kontent
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Logo animatsiyasi
                  Expanded(
                    flex: 3,
                    child: Center(
                      child: SpinKitFadingCircle(
                        color: Colors.white,
                        size: 100.0,
                      ),
                    ),
                  ),

                  // Logo va nom
                  Expanded(
                    flex: 2,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ShaderMask(
                          shaderCallback: (bounds) => LinearGradient(
                            colors: [
                              Colors.white,
                              Colors.white.withOpacity(0.8),
                            ],
                          ).createShader(bounds),
                          child: DefaultTextStyle(
                            style: Theme.of(context)
                                .textTheme
                                .displayLarge!
                                .copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 2,
                                ),
                            child: AnimatedTextKit(
                              animatedTexts: [
                                WavyAnimatedText(
                                  'Looksy',
                                  speed: const Duration(milliseconds: 200),
                                ),
                              ],
                              isRepeatingAnimation: false,
                              onFinished: () {
                                // Birinchi animatsiya tugagandan so'ng ikkinchi animatsiyani boshlash
                                controller.startSecondAnimation();
                              },
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Obx(() => controller.showSecondAnimation.value
                            ? DefaultTextStyle(
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .copyWith(
                                      color: Colors.white.withOpacity(0.8),
                                      letterSpacing: 1,
                                    ),
                                child: AnimatedTextKit(
                                  animatedTexts: [
                                    TypewriterAnimatedText(
                                      'Professional sartaroshlar',
                                      speed: const Duration(milliseconds: 100),
                                    ),
                                  ],
                                  totalRepeatCount: 1,
                                  onFinished: () {
                                    // Barcha animatsiyalar tugagandan so'ng keyingi ekranga o'tish
                                    controller.onAnimationsComplete();
                                  },
                                ),
                              )
                            : const SizedBox.shrink()),
                      ],
                    ),
                  ),

                  // Loading animatsiyasi
                  Expanded(
                    child: Center(
                      child: SpinKitWave(
                        color: Colors.white,
                        size: 40.0,
                        itemCount: 6,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
