import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import '../../../../core/services/auth_service.dart';
import '../controllers/profile_controller.dart';
import 'register_bottom_sheet.dart';

class LoginBottomSheet extends StatelessWidget {
  const LoginBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox.shrink();
  }

  void show(BuildContext context) {
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    final formKey = GlobalKey<FormState>();
    final authService = Get.find<AuthService>();
    final controller = Get.find<ProfileController>();

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
              _buildHeader(context),
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
                        _buildIcon(context),
                        const SizedBox(height: 32),
                        // Title
                        _buildTitle(context),
                        const SizedBox(height: 32),
                        // Form fields
                        _buildEmailField(emailController),
                        const SizedBox(height: 16),
                        _buildPasswordField(passwordController),
                        const SizedBox(height: 24),
                        _buildLoginButton(
                          context,
                          formKey,
                          emailController,
                          passwordController,
                          authService,
                          controller,
                        ),
                        const SizedBox(height: 16),
                        _buildRegisterLink(context),
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

  Widget _buildHeader(BuildContext context) {
    return Padding(
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
    );
  }

  Widget _buildIcon(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
        shape: BoxShape.circle,
      ),
      child: Icon(
        IconsaxPlusLinear.user,
        size: 64,
        color: Theme.of(context).colorScheme.primary,
      ),
    );
  }

  Widget _buildTitle(BuildContext context) {
    return Column(
      children: [
        Text(
          'Xush kelibsiz!',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 8),
        Text(
          'Davom etish uchun tizimga kiring',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: Colors.grey,
              ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildEmailField(TextEditingController controller) {
    return TextFormField(
      controller: controller,
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
    );
  }

  Widget _buildPasswordField(TextEditingController controller) {
    return TextFormField(
      controller: controller,
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
    );
  }

  Widget _buildLoginButton(
    BuildContext context,
    GlobalKey<FormState> formKey,
    TextEditingController emailController,
    TextEditingController passwordController,
    AuthService authService,
    ProfileController controller,
  ) {
    return SizedBox(
      width: double.infinity,
      child: Obx(() => FilledButton(
            onPressed: authService.isLoading.value
                ? null
                : () async {
                    if (formKey.currentState!.validate()) {
                      final result = await authService.login(
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
                          snackPosition: SnackPosition.BOTTOM,
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
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  )
                : const Text(
                    'Kirish',
                    style: TextStyle(fontSize: 16),
                  ),
          )),
    );
  }

  Widget _buildRegisterLink(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Hisobingiz yo\'qmi? ',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        TextButton(
          onPressed: () {
            Get.back();
            RegisterBottomSheet().show(context);
          },
          child: const Text('Ro\'yxatdan o\'tish'),
        ),
      ],
    );
  }
}
