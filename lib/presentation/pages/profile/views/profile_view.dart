import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import '../../../../core/services/auth_service.dart';
import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({super.key});

  void _showLoginBottomSheet(BuildContext context) {
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    final formKey = GlobalKey<FormState>();
    final authService = Get.find<AuthService>();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              // Header
              Padding(
                padding: EdgeInsets.fromLTRB(
                    20, MediaQuery.of(context).padding.top + 20, 20, 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Tizimga kirish',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    IconButton(
                      onPressed: () => Get.back(),
                      icon: const Icon(Icons.close),
                    ),
                  ],
                ),
              ),
              const Divider(height: 1),
              // Content
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(height: 40),
                        // Icon
                        Container(
                          padding: const EdgeInsets.all(24),
                          decoration: BoxDecoration(
                            color: Theme.of(context)
                                .colorScheme
                                .primary
                                .withOpacity(0.1),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            IconsaxPlusLinear.user,
                            size: 64,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                        const SizedBox(height: 32),
                        // Title
                        Text(
                          'Xush kelibsiz!',
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall
                              ?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Davom etish uchun tizimga kiring',
                          style:
                              Theme.of(context).textTheme.bodyLarge?.copyWith(
                                    color: Colors.grey,
                                  ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 32),
                        // Form fields
                        TextFormField(
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            labelText: 'Email',
                            hintText: 'example@gmail.com',
                            prefixIcon: const Icon(IconsaxPlusLinear.sms),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Email kiritish majburiy';
                            }
                            if (!GetUtils.isEmail(value)) {
                              return 'Noto\'g\'ri email formati';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: passwordController,
                          obscureText: true,
                          decoration: InputDecoration(
                            labelText: 'Parol',
                            prefixIcon: const Icon(IconsaxPlusLinear.lock),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Parol kiritish majburiy';
                            }
                            if (value.length < 6) {
                              return 'Parol kamida 6 ta belgidan iborat bo\'lishi kerak';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 24),
                        SizedBox(
                          width: double.infinity,
                          child: Obx(() => FilledButton(
                                onPressed: authService.isLoading.value
                                    ? null
                                    : () async {
                                        if (formKey.currentState!.validate()) {
                                          final result =
                                              await authService.login(
                                            emailController.text.trim(),
                                            passwordController.text,
                                          );
                                          if (result.$1) {
                                            Get.back();
                                            controller.loadUserData();
                                          } else {
                                            Get.snackbar(
                                              'Xatolik',
                                              result.$2,
                                              snackPosition:
                                                  SnackPosition.BOTTOM,
                                              backgroundColor: Colors.red,
                                              colorText: Colors.white,
                                            );
                                          }
                                        }
                                      },
                                style: FilledButton.styleFrom(
                                  padding: const EdgeInsets.all(16),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                child: authService.isLoading.value
                                    ? const SizedBox(
                                        height: 20,
                                        width: 20,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2,
                                          valueColor:
                                              AlwaysStoppedAnimation<Color>(
                                                  Colors.white),
                                        ),
                                      )
                                    : const Text(
                                        'Kirish',
                                        style: TextStyle(fontSize: 16),
                                      ),
                              )),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Hisobingiz yo\'qmi? ',
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                            TextButton(
                              onPressed: () {
                                Get.back();
                                _showRegisterBottomSheet(context);
                              },
                              child: const Text('Ro\'yxatdan o\'tish'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showRegisterBottomSheet(BuildContext context) {
    final fullNameController = TextEditingController();
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    final retryPasswordController = TextEditingController();
    final formKey = GlobalKey<FormState>();
    final authService = Get.find<AuthService>();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              // Header
              Padding(
                padding: EdgeInsets.fromLTRB(
                    20, MediaQuery.of(context).padding.top + 20, 20, 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Ro\'yxatdan o\'tish',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    IconButton(
                      onPressed: () => Get.back(),
                      icon: const Icon(Icons.close),
                    ),
                  ],
                ),
              ),
              const Divider(height: 1),
              // Content
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(height: 40),
                        // Icon
                        Container(
                          padding: const EdgeInsets.all(24),
                          decoration: BoxDecoration(
                            color: Theme.of(context)
                                .colorScheme
                                .primary
                                .withOpacity(0.1),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            IconsaxPlusLinear.user_add,
                            size: 64,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                        const SizedBox(height: 32),
                        // Title
                        Text(
                          'Yangi hisob yaratish',
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall
                              ?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Ma\'lumotlaringizni kiriting',
                          style:
                              Theme.of(context).textTheme.bodyLarge?.copyWith(
                                    color: Colors.grey,
                                  ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 32),
                        // Form fields
                        TextFormField(
                          controller: fullNameController,
                          keyboardType: TextInputType.name,
                          textCapitalization: TextCapitalization.words,
                          decoration: InputDecoration(
                            labelText: 'Ism Familiya',
                            hintText: 'Ism Familiya',
                            prefixIcon: const Icon(IconsaxPlusLinear.user),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Ism va familiyani kiriting';
                            }
                            if (value.trim().split(' ').length < 2) {
                              return 'Ism va familiyani to\'liq kiriting';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            labelText: 'Email',
                            hintText: 'example@gmail.com',
                            prefixIcon: const Icon(IconsaxPlusLinear.sms),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Email kiritish majburiy';
                            }
                            if (!GetUtils.isEmail(value)) {
                              return 'Noto\'g\'ri email formati';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: passwordController,
                          obscureText: true,
                          decoration: InputDecoration(
                            labelText: 'Parol',
                            prefixIcon: const Icon(IconsaxPlusLinear.lock),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Parol kiritish majburiy';
                            }
                            if (value.length < 6) {
                              return 'Parol kamida 6 ta belgidan iborat bo\'lishi kerak';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: retryPasswordController,
                          obscureText: true,
                          decoration: InputDecoration(
                            labelText: 'Parolni tasdiqlang',
                            prefixIcon: const Icon(IconsaxPlusLinear.lock),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Parolni tasdiqlash majburiy';
                            }
                            if (value != passwordController.text) {
                              return 'Parollar mos kelmadi';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 24),
                        SizedBox(
                          width: double.infinity,
                          child: Obx(() => FilledButton(
                                onPressed: authService.isLoading.value
                                    ? null
                                    : () async {
                                        if (formKey.currentState!.validate()) {
                                          final (success, message) =
                                              await authService.register(
                                            email: emailController.text.trim(),
                                            password: passwordController.text,
                                            fullName:
                                                fullNameController.text.trim(),
                                          );
                                          if (success) {
                                            Get.back();
                                            Get.snackbar(
                                              'Muvaffaqiyatli',
                                              message,
                                              snackPosition:
                                                  SnackPosition.BOTTOM,
                                              backgroundColor: Colors.green,
                                              colorText: Colors.white,
                                              duration:
                                                  const Duration(seconds: 3),
                                            );
                                            // Ro'yxatdan o'tish muvaffaqiyatli bo'lgandan so'ng login oynasini ochish
                                            Future.delayed(
                                              const Duration(seconds: 1),
                                              () => _showLoginBottomSheet(
                                                  context),
                                            );
                                          } else {
                                            Get.snackbar(
                                              'Xatolik',
                                              message,
                                              snackPosition:
                                                  SnackPosition.BOTTOM,
                                              backgroundColor: Colors.red,
                                              colorText: Colors.white,
                                              duration:
                                                  const Duration(seconds: 5),
                                            );
                                          }
                                        }
                                      },
                                style: FilledButton.styleFrom(
                                  padding: const EdgeInsets.all(16),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                child: authService.isLoading.value
                                    ? const SizedBox(
                                        height: 20,
                                        width: 20,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2,
                                          valueColor:
                                              AlwaysStoppedAnimation<Color>(
                                                  Colors.white),
                                        ),
                                      )
                                    : const Text(
                                        'Ro\'yxatdan o\'tish',
                                        style: TextStyle(fontSize: 16),
                                      ),
                              )),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Hisobingiz bormi? ',
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                            TextButton(
                              onPressed: () {
                                Get.back();
                                _showLoginBottomSheet(context);
                              },
                              child: const Text('Kirish'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLoginView(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          // AppBar
          Container(
            padding: const EdgeInsets.all(20),
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
            child: Row(
              children: [
                Text(
                  'Profil',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ],
            ),
          ),
          // Login content
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: Theme.of(context)
                          .colorScheme
                          .primary
                          .withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      IconsaxPlusLinear.user,
                      size: 64,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  const SizedBox(height: 32),
                  Text(
                    'Kirish yoki ro\'yxatdan o\'tish',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Barcha funksiyalardan foydalanish uchun tizimga kiring yoki ro\'yxatdan o\'ting',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: Colors.grey,
                        ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 32),
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton.icon(
                      onPressed: () => _showLoginBottomSheet(context),
                      style: FilledButton.styleFrom(
                        padding: const EdgeInsets.all(16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      icon: const Icon(IconsaxPlusLinear.login),
                      label: const Text(
                        'Kirish / Ro\'yxatdan o\'tish',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          return _buildLoginView(context);
        }

        // Profil ma'lumotlarini ko'rsatish
        return SingleChildScrollView(
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
                        if (controller.isLoading.value)
                          const CircularProgressIndicator(color: Colors.white)
                        else ...[
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
                                      color:
                                          Theme.of(context).colorScheme.primary,
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
        );
      }),
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
