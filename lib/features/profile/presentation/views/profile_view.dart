import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import '../../../../core/controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Profil header qismi
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Theme.of(context).colorScheme.primary,
                    Theme.of(context).colorScheme.primary.withOpacity(0.8),
                  ],
                ),
              ),
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Profil',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              IconsaxPlusLinear.setting_2,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      // Profil rasmi
                      Hero(
                        tag: 'profile_image',
                        child: Stack(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Colors.white,
                                  width: 2,
                                ),
                              ),
                              child: Obx(() => CircleAvatar(
                                    radius: 50,
                                    backgroundColor: Colors.white,
                                    backgroundImage: NetworkImage(
                                        controller.userImage.value),
                                    onBackgroundImageError: (e, s) =>
                                        const Icon(Icons.error),
                                  )),
                            ),
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: Container(
                                padding: const EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.1),
                                      blurRadius: 8,
                                      offset: const Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: Icon(
                                  IconsaxPlusLinear.edit,
                                  color: Theme.of(context).colorScheme.primary,
                                  size: 20,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                      // Ism va email
                      Obx(() => Text(
                            controller.userName.value,
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          )),
                      const SizedBox(height: 8),
                      Obx(() => Text(
                            controller.userEmail.value,
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white.withOpacity(0.8),
                            ),
                          )),
                    ],
                  ),
                ),
              ),
            ),
            // Menyu elementlari
            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    _buildMenuSection(
                      context,
                      title: 'Asosiy',
                      items: [
                        _MenuItem(
                          icon: IconsaxPlusLinear.user_edit,
                          title: 'Profilni tahrirlash',
                          onTap: () => Get.toNamed('/edit-profile'),
                        ),
                        _MenuItem(
                          icon: IconsaxPlusLinear.notification,
                          title: 'Bildirishnomalar',
                          onTap: () => Get.toNamed('/notifications'),
                        ),
                        _MenuItem(
                          icon: IconsaxPlusLinear.wallet_3,
                          title: 'To\'lov',
                          onTap: () => Get.toNamed('/payment'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    _buildMenuSection(
                      context,
                      title: 'Sozlamalar',
                      items: [
                        _MenuItem(
                          icon: IconsaxPlusLinear.security_safe,
                          title: 'Xavfsizlik',
                          onTap: () => Get.toNamed('/security'),
                        ),
                        _MenuItem(
                          icon: IconsaxPlusLinear.language_square,
                          title: 'Til',
                          trailing: const Text('O\'zbek'),
                          onTap: () => controller.showLanguageDialog(),
                        ),
                        _MenuItem(
                          icon: IconsaxPlusLinear.moon,
                          title: 'Qorong\'u rejim',
                          trailing: Obx(
                            () => Switch.adaptive(
                              value: controller.isDarkMode.value,
                              onChanged: controller.toggleTheme,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    _buildMenuSection(
                      context,
                      title: 'Boshqa',
                      items: [
                        _MenuItem(
                          icon: IconsaxPlusLinear.shield,
                          title: 'Maxfiylik siyosati',
                          onTap: () => Get.toNamed('/privacy-policy'),
                        ),
                        _MenuItem(
                          icon: IconsaxPlusLinear.user_add,
                          title: 'Do\'stlarni taklif qilish',
                          onTap: () => controller.shareApp(),
                        ),
                        _MenuItem(
                          icon: IconsaxPlusLinear.logout,
                          title: 'Chiqish',
                          titleColor: Colors.red,
                          onTap: () => controller.showLogoutDialog(),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuSection(
    BuildContext context, {
    required String title,
    required List<_MenuItem> items,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16, bottom: 12),
          child: Text(
            title,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.bold,
                ),
          ),
        ),
        Card(
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: BorderSide(
              color: Theme.of(context).dividerColor.withOpacity(0.1),
            ),
          ),
          child: Column(
            children: items.map((item) {
              final isLast = items.last == item;
              return Column(
                children: [
                  ListTile(
                    leading: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Theme.of(context)
                            .colorScheme
                            .primary
                            .withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(
                        item.icon,
                        color: item.titleColor ??
                            Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    title: Text(
                      item.title,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: item.titleColor,
                          ),
                    ),
                    trailing: item.trailing ??
                        Icon(
                          IconsaxPlusLinear.arrow_right_3,
                          color: Theme.of(context).iconTheme.color,
                        ),
                    onTap: item.onTap,
                  ),
                  if (!isLast)
                    Divider(
                      height: 1,
                      indent: 56,
                      endIndent: 16,
                    ),
                ],
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}

class _MenuItem {
  final IconData icon;
  final String title;
  final Widget? trailing;
  final Color? titleColor;
  final VoidCallback? onTap;

  const _MenuItem({
    required this.icon,
    required this.title,
    this.trailing,
    this.titleColor,
    this.onTap,
  });
}
