import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import '../controllers/profile_controller.dart';
import '../../../../core/services/auth_service.dart';
import '../../../widgets/custom_app_bar.dart';
import '../widgets/login_view.dart';
import '../widgets/profile_info.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Profile',
        actions: [
          IconButton(
            onPressed: null,
            icon: Icon(
              IconsaxPlusLinear.setting_2,
              color: Colors.white,
            ),
          ),
        ],
        automaticallyImplyLeading: false,
      ),
      body: Obx(() {
        final authService = Get.find<AuthService>();

        // Loading holatini tekshirish
        if (authService.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        // Autentifikatsiya holatini tekshirish
        if (!authService.isAuthenticated.value) {
          return const LoginView();
        }

        // Profil ma'lumotlarini ko'rsatish
        return const SingleChildScrollView(
          child: ProfileInfo(),
        );
      }),
    );
  }
}
