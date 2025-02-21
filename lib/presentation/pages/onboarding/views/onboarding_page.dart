import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:style_hub/presentation/controllers/onboarding_controller.dart';
import 'package:style_hub/presentation/routes/app_routes.dart';

class OnboardingPage extends GetView<OnboardingController> {
  OnboardingPage({super.key});

  final List<Widget> pages = [
    _buildPage(
      title: 'Welcome to Style Hub',
      description: 'Discover the latest fashion trends and styles.',
      icon: Icons.home,
    ),
    _buildPage(
      title: 'Shop with Ease',
      description: 'Find your favorite brands and shop with ease.',
      icon: Icons.person,
    ),
    _buildPage(
      title: 'Get Inspired',
      description: 'Get inspired by our curated collections and looks.',
      icon: Icons.online_prediction_rounded,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            PageView.builder(
              controller: controller.pageController,
              itemCount: pages.length,
              onPageChanged: controller.currentPageIndex.call,
              itemBuilder: (context, index) {
                return pages[index];
              },
            ),
            Positioned(
              bottom: 20,
              left: 20,
              right: 20,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Obx(() => TextButton(
                        onPressed: () {
                          if (controller.currentPageIndex.value <
                              pages.length - 1) {
                            controller.pageController.animateToPage(
                              pages.length - 1,
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.ease,
                            );
                          }
                        },
                        child: Text(
                          controller.currentPageIndex.value < pages.length - 1
                              ? 'Skip'
                              : '',
                          style: const TextStyle(fontSize: 16),
                        ),
                      )),
                  Obx(() => ElevatedButton(
                        onPressed: () {
                          if (controller.currentPageIndex.value <
                              pages.length - 1) {
                            controller.pageController.nextPage(
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.ease,
                            );
                          } else {
                            Get.offAllNamed(AppRoutes.BOTTOM_NAV);
                          }
                        },
                        child: Text(
                          controller.currentPageIndex.value < pages.length - 1
                              ? 'Next'
                              : 'Get Started',
                          style: const TextStyle(fontSize: 16),
                        ),
                      )),
                ],
              ),
            ),
            Positioned(
              bottom: 80,
              left: 0,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  pages.length,
                  (index) => Obx(() => Container(
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        width:
                            controller.currentPageIndex.value == index ? 12 : 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: controller.currentPageIndex.value == index
                              ? Colors.blue
                              : Colors.grey,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      )),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  static Widget _buildPage({
    required String title,
    required String description,
    required IconData icon,
  }) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Image.asset(image),
          Icon(icon, size: 128),
          const SizedBox(height: 40),
          Text(
            title,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            description,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}
