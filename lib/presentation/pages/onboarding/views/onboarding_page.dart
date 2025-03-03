import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:looksy/presentation/controllers/onboarding_controller.dart';
import 'package:looksy/presentation/routes/app_routes.dart';
import 'package:lottie/lottie.dart';

class OnboardingPage extends GetView<OnboardingController> {
  OnboardingPage({super.key});

  final List<OnboardingContent> pages = [
    OnboardingContent(
      title: 'Looksy\'ga Xush Kelibsiz',
      description:
          'Eng yaxshi sartaroshlarni qidirib toping va o\'zingizga ma\'qul bo\'lgan uslubni tanlang.',
      image: 'assets/animations/barber_animation.json',
      color: const Color(0xFF4A80F0),
    ),
    OnboardingContent(
      title: 'Vaqtni tejang',
      description: 'Qulay vaqt va joyni tanlang. Navbatda kutib turmang.',
      image: 'assets/animations/time_animation.json',
      color: const Color(0xFF7960F9),
    ),
    OnboardingContent(
      title: 'Yuqori sifat',
      description:
          'Faqat eng yaxshi sartaroshlar. Sifat bizning ustuvorligimiz.',
      image: 'assets/animations/quality_animation.json',
      color: const Color(0xFF5CC596),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: Stack(
        children: [
          // Background gradient
          Obx(() {
            final index = controller.currentPageIndex.value;
            final color = pages[index % pages.length].color;

            return AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [
                    color.withOpacity(0.8),
                    color.withOpacity(0.2),
                  ],
                ),
              ),
            );
          }),

          // Page content
          PageView.builder(
            controller: controller.pageController,
            itemCount: pages.length,
            onPageChanged: controller.currentPageIndex.call,
            itemBuilder: (context, index) {
              return _buildPage(context, pages[index]);
            },
          ),

          // Bottom navigation
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.only(
                  left: 24, right: 24, bottom: 50, top: 24),
              decoration: BoxDecoration(
                color: theme.scaffoldBackgroundColor,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, -5),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Page indicator
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      pages.length,
                      (index) => Obx(() => AnimatedContainer(
                            duration: const Duration(milliseconds: 250),
                            margin: const EdgeInsets.symmetric(horizontal: 4),
                            width: controller.currentPageIndex.value == index
                                ? 24
                                : 10,
                            height: 10,
                            decoration: BoxDecoration(
                              color: controller.currentPageIndex.value == index
                                  ? pages[controller.currentPageIndex.value]
                                      .color
                                  : Colors.grey.withOpacity(0.3),
                              borderRadius: BorderRadius.circular(5),
                            ),
                          )),
                    ),
                  ),

                  const SizedBox(height: 32),

                  // Action buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Skip button
                      Obx(() => TextButton(
                            onPressed: () {
                              if (controller.currentPageIndex.value <
                                  pages.length - 1) {
                                controller.pageController.animateToPage(
                                  pages.length - 1,
                                  duration: const Duration(milliseconds: 600),
                                  curve: Curves.easeInOutCubic,
                                );
                              }
                            },
                            style: TextButton.styleFrom(
                              foregroundColor: Colors.grey[600],
                            ),
                            child: Text(
                              controller.currentPageIndex.value <
                                      pages.length - 1
                                  ? 'O\'tkazib yuborish'
                                  : '',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          )),

                      // Next/Get Started button
                      Obx(() {
                        final isLastPage = controller.currentPageIndex.value ==
                            pages.length - 1;
                        return ElevatedButton(
                          onPressed: () {
                            if (controller.currentPageIndex.value <
                                pages.length - 1) {
                              controller.pageController.nextPage(
                                duration: const Duration(milliseconds: 500),
                                curve: Curves.easeInOut,
                              );
                            } else {
                              // Onboarding tugallanganini saqlash
                              controller.completeOnboarding();
                              // Asosiy ekranga o'tish
                              Get.offAllNamed(AppRoutes.BOTTOM_NAV);
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                pages[controller.currentPageIndex.value].color,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 32, vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            elevation: 2,
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                isLastPage ? 'Boshlash' : 'Keyingisi',
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              if (!isLastPage) ...[
                                const SizedBox(width: 8),
                                const Icon(Icons.arrow_forward, size: 20),
                              ],
                            ],
                          ),
                        );
                      }),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPage(BuildContext context, OnboardingContent content) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 60, 24, 200),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Lottie.asset(
              content.image,
              fit: BoxFit.contain,
            ),
          ),
          const SizedBox(height: 40),
          Text(
            content.title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              height: 1.2,
              shadows: [
                Shadow(
                  color: Colors.black26,
                  offset: Offset(0, 2),
                  blurRadius: 4,
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Text(
            content.description,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18,
              color: Colors.white.withOpacity(0.9),
              height: 1.5,
              shadows: [
                Shadow(
                  color: Colors.black12,
                  offset: Offset(0, 1),
                  blurRadius: 2,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class OnboardingContent {
  final String title;
  final String description;
  final String image;
  final Color color;

  const OnboardingContent({
    required this.title,
    required this.description,
    required this.image,
    required this.color,
  });
}
