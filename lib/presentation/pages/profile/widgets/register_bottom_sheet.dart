import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import '../../../../core/services/auth_service.dart';
import 'login_bottom_sheet.dart';

class RegisterBottomSheet extends StatelessWidget {
  const RegisterBottomSheet({super.key});

  void show(BuildContext context) {
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
                        _buildFullNameField(fullNameController),
                        const SizedBox(height: 16),
                        _buildEmailField(emailController),
                        const SizedBox(height: 16),
                        _buildPasswordField(passwordController),
                        const SizedBox(height: 16),
                        _buildRetryPasswordField(
                            retryPasswordController, passwordController),
                        const SizedBox(height: 24),
                        _buildRegisterButton(
                          context,
                          formKey,
                          fullNameController,
                          emailController,
                          passwordController,
                          authService,
                        ),
                        const SizedBox(height: 16),
                        _buildLoginLink(context),
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
        IconsaxPlusLinear.user_add,
        size: 64,
        color: Theme.of(context).colorScheme.primary,
      ),
    );
  }

  Widget _buildTitle(BuildContext context) {
    return Column(
      children: [
        Text(
          'Yangi hisob yaratish',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 8),
        Text(
          'Ma\'lumotlaringizni kiriting',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: Colors.grey,
              ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildFullNameField(TextEditingController controller) {
    return TextFormField(
      controller: controller,
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

  Widget _buildRetryPasswordField(
    TextEditingController controller,
    TextEditingController passwordController,
  ) {
    return TextFormField(
      controller: controller,
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
    );
  }

  Widget _buildRegisterButton(
    BuildContext context,
    GlobalKey<FormState> formKey,
    TextEditingController fullNameController,
    TextEditingController emailController,
    TextEditingController passwordController,
    AuthService authService,
  ) {
    return SizedBox(
      width: double.infinity,
      child: Obx(() => FilledButton(
            onPressed: authService.isLoading.value
                ? null
                : () async {
                    if (formKey.currentState!.validate()) {
                      final (success, message) = await authService.register(
                        email: emailController.text.trim(),
                        password: passwordController.text,
                        fullName: fullNameController.text.trim(),
                      );
                      if (success) {
                        Get.back();
                        Get.snackbar(
                          'Muvaffaqiyatli',
                          message,
                          snackPosition: SnackPosition.BOTTOM,
                          backgroundColor: Colors.green,
                          colorText: Colors.white,
                          duration: const Duration(seconds: 3),
                        );
                        // Ro'yxatdan o'tish muvaffaqiyatli bo'lgandan so'ng login oynasini ochish
                        Future.delayed(
                          const Duration(seconds: 1),
                          () => LoginBottomSheet().show(context),
                        );
                      } else {
                        Get.snackbar(
                          'Xatolik',
                          message,
                          snackPosition: SnackPosition.BOTTOM,
                          backgroundColor: Colors.red,
                          colorText: Colors.white,
                          duration: const Duration(seconds: 5),
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
                    'Ro\'yxatdan o\'tish',
                    style: TextStyle(fontSize: 16),
                  ),
          )),
    );
  }

  Widget _buildLoginLink(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Hisobingiz bormi? ',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        TextButton(
          onPressed: () {
            Get.back();
            LoginBottomSheet().show(context);
          },
          child: const Text('Kirish'),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return const SizedBox.shrink();
  }
}
