import 'package:get/get.dart';
import '../../../../core/utils/logger.dart';

class ProfileDetailsController extends GetxController {
  final currentPage = 0.obs;

  @override
  void onInit() {
    super.onInit();
    AppLogger.debug('Initializing ProfileDetailsController');
    loadProfileDetails();
  }

  void onPageChanged(int page) {
    currentPage.value = page;
  }

  Future<void> loadProfileDetails() async {
    try {
      AppLogger.debug('Loading profile details');
      // API call to load profile details
      AppLogger.info('Profile details loaded successfully');
    } catch (e) {
      AppLogger.error('Error loading profile details: $e');
    }
  }

  Future<void> updateProfile() async {
    try {
      AppLogger.debug('Updating profile');
      // API call to update profile
      AppLogger.info('Profile updated successfully');
    } catch (e) {
      AppLogger.error('Error updating profile: $e');
    }
  }
}
