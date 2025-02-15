import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import '../../../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('profile'.tr),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(IconsaxPlusLinear.setting_2),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            // Profile Image and Name
            Center(
              child: Column(
                children: [
                  Stack(
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundImage:
                            NetworkImage(controller.userImage.value),
                        onBackgroundImageError: (e, s) =>
                            const Icon(Icons.error),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.primary,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            IconsaxPlusLinear.edit,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    controller.userName.value,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    controller.userEmail.value,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            // Menu Items
            _buildMenuItem(
              context,
              icon: IconsaxPlusLinear.user_edit,
              title: 'edit_profile'.tr,
              onTap: () => Get.toNamed('/edit-profile'),
            ),
            _buildMenuItem(
              context,
              icon: IconsaxPlusLinear.notification,
              title: 'notification'.tr,
              onTap: () => Get.toNamed('/notifications'),
            ),
            _buildMenuItem(
              context,
              icon: IconsaxPlusLinear.wallet_3,
              title: 'payment'.tr,
              onTap: () => Get.toNamed('/payment'),
            ),
            _buildMenuItem(
              context,
              icon: IconsaxPlusLinear.security_safe,
              title: 'security'.tr,
              onTap: () => Get.toNamed('/security'),
            ),
            _buildMenuItem(
              context,
              icon: IconsaxPlusLinear.language_square,
              title: 'language'.tr,
              trailing: Text('English (US)'),
              onTap: () => controller.showLanguageDialog(),
            ),
            _buildMenuItem(
              context,
              icon: IconsaxPlusLinear.moon,
              title: 'dark_mode'.tr,
              trailing: Obx(
                () => Switch(
                  value: controller.isDarkMode.value,
                  onChanged: controller.toggleTheme,
                ),
              ),
              onTap: () {},
            ),
            _buildMenuItem(
              context,
              icon: IconsaxPlusLinear.shield,
              title: 'privacy_policy'.tr,
              onTap: () => Get.toNamed('/privacy-policy'),
            ),
            _buildMenuItem(
              context,
              icon: IconsaxPlusLinear.user_add,
              title: 'invite_friends'.tr,
              onTap: () => controller.shareApp(),
            ),
            _buildMenuItem(
              context,
              icon: IconsaxPlusLinear.logout,
              title: 'logout'.tr,
              titleColor: Colors.red,
              onTap: () => controller.showLogoutDialog(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    Widget? trailing,
    Color? titleColor,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(
        icon,
        color: titleColor ?? Theme.of(context).iconTheme.color,
      ),
      title: Text(
        title,
        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: titleColor,
            ),
      ),
      trailing: trailing ??
          Icon(
            IconsaxPlusLinear.arrow_right_3,
            color: Theme.of(context).iconTheme.color,
          ),
      onTap: onTap,
    );
  }
}
