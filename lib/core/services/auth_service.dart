import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../utils/logger.dart';
import '../config/env_config.dart';
import '../repositories/auth_repository.dart';
import '../data/models/user_model.dart';
import 'package:dio/dio.dart';

/// Autentifikatsiya xizmati
///
/// Bu xizmat foydalanuvchi autentifikatsiyasi bilan bog'liq
/// barcha operatsiyalarni boshqaradi va xavfsiz saqlashni ta'minlaydi.
class AuthService extends GetxService {
  final _storage = const FlutterSecureStorage();
  final _authRepository = AuthRepository();

  static const String _tokenKey = 'auth_token';
  static const String _userNameKey = 'user_name';
  static const String _userEmailKey = 'user_email';
  static const String _userIdKey = 'user_id';
  static const String _onboardingKey = 'onboarding_completed';

  // Auth holatini saqlash uchun
  final isAuthenticated = false.obs;
  final isLoading = true.obs;
  final isOnboardingCompleted = false.obs;
  final currentUser = Rxn<UserModel>();

  late Dio dioClient;

  @override
  Future<void> onInit() async {
    super.onInit();
    // Onboarding holatini tekshirish
    final onboardingCompleted = await _storage.read(key: _onboardingKey);
    isOnboardingCompleted.value = onboardingCompleted == 'true';

    isAuthenticated.value = false;
    isLoading.value = false;

    dioClient = Dio();
  }

  /// Auth holatini tekshirish
  Future<void> checkAuthStatus() async {
    isLoading.value = true;
    try {
      final token = await _storage.read(key: _tokenKey);
      AppLogger.debug('Stored token: $token');

      if (token == null) {
        isAuthenticated.value = false;
        currentUser.value = null;
        AppLogger.info('User is not authenticated');
        return;
      }

      final userInfo = await _authRepository.getUserInfo();
      if (userInfo != null) {
        currentUser.value = userInfo;
        isAuthenticated.value = true;
      } else {
        await logout();
      }
    } catch (e) {
      AppLogger.error('Error checking auth status: $e');
      await logout();
    } finally {
      isLoading.value = false;
    }
  }

  /// Foydalanuvchi ma'lumotlarini saqlash
  Future<void> saveUserData({
    required String token,
    required UserModel user,
  }) async {
    AppLogger.debug('Saving token: $token');
    AppLogger.debug('Saving user data: ${user.toJson()}');

    await _storage.write(key: _tokenKey, value: token);
    await _storage.write(key: _userNameKey, value: user.fullName);
    await _storage.write(key: _userEmailKey, value: user.email);
    await _storage.write(key: _userIdKey, value: user.id);

    currentUser.value = user;
    isAuthenticated.value = true;
    AppLogger.info('User data saved successfully');
  }

  /// Foydalanuvchi ma'lumotlarini olish
  Future<UserModel?> getUserInfo() async {
    try {
      final userInfo = await _authRepository.getUserInfo();
      if (userInfo != null) {
        currentUser.value = userInfo;
        return userInfo;
      }
      return null;
    } catch (e) {
      AppLogger.error('Error in getUserInfo: $e');
      return null;
    }
  }

  /// Onboarding tugaganini saqlash
  Future<void> completeOnboarding() async {
    await _storage.write(key: _onboardingKey, value: 'true');
    isOnboardingCompleted.value = true;
  }

  /// Tizimdan chiqish
  Future<void> logout() async {
    AppLogger.info('Logging out user');
    try {
      await _authRepository.logout();
    } catch (e) {
      AppLogger.error('Error during logout: $e');
    } finally {
      await _storage.deleteAll();
      // Onboarding holatini saqlab qolish
      if (isOnboardingCompleted.value) {
        await _storage.write(key: _onboardingKey, value: 'true');
        AppLogger.debug('Preserved onboarding status after logout');
      }
      isAuthenticated.value = false;
      currentUser.value = null;
      AppLogger.info('User logged out successfully');
    }
  }

  /// Tizimga kirish
  Future<(bool, String)> login(String email, String password) async {
    isLoading.value = true;
    try {
      AppLogger.debug('Attempting login for user: $email');

      final (user, token) = await _authRepository.login(email, password);
      await saveUserData(token: token, user: user);
      AppLogger.info('User logged in successfully');
      return (true, 'Muvaffaqiyatli tizimga kirdingiz!');
    } catch (e) {
      AppLogger.error('Login error: $e');
      return (false, e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  /// Ro'yxatdan o'tish
  Future<(bool, String)> register({
    required String email,
    required String password,
    required String fullName,
  }) async {
    isLoading.value = true;
    try {
      AppLogger.debug('Attempting registration for user: $email');

      await _authRepository.register(
        email: email,
        password: password,
        fullName: fullName,
      );

      AppLogger.info('User registered successfully');
      return (
        true,
        'Muvaffaqiyatli ro\'yxatdan o\'tdingiz! Iltimos, tizimga kiring.'
      );
    } catch (e) {
      AppLogger.error('Registration error: $e');
      return (false, e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
