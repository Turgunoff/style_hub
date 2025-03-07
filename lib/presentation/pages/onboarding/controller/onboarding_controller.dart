import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/services/storage/secure_storage.dart';
import '../../../../core/utils/logger.dart';

class OnboardingController extends GetxController {
  final pageController = PageController();
  final currentPageIndex = 0.obs;
  final SecureStorage _secureStorage = Get.find<SecureStorage>();
  static const String _firstLaunchKey = 'first_launch_completed';

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }

  // Onboarding tugagandan so'ng storage'ga birinchi marta ishga tushirilganini saqlash
  Future<void> completeOnboarding() async {
    try {
      await _secureStorage.writeData(key: _firstLaunchKey, value: "true");
      AppLogger.info('Onboarding completed and saved to storage');
    } catch (e) {
      AppLogger.error('Error saving onboarding completion: $e');
    }
  }
}
