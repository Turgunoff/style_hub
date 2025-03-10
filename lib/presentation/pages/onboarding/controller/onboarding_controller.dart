import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/services/auth_service.dart';
import '../../../../core/utils/logger.dart';

class OnboardingController extends GetxController {
  final AuthService _authService;
  final currentPageIndex = 0.obs;
  final PageController pageController = PageController();

  OnboardingController(this._authService);

  @override
  void onInit() {
    super.onInit();
    AppLogger.debug('Initializing OnboardingController');
  }

  @override
  void onClose() {
    AppLogger.debug('Disposing OnboardingController');
    pageController.dispose();
    super.onClose();
  }

  Future<void> completeOnboarding() async {
    AppLogger.debug('Completing onboarding process');
    try {
      await _authService.completeOnboarding();
      AppLogger.info('Onboarding completed and saved to storage');
    } catch (e) {
      AppLogger.error('Error saving onboarding status: $e');
    }
  }
}
