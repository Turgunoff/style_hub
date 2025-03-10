import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../utils/logger.dart';
import '../config/env_config.dart';

class AuthService extends GetxService {
  final _storage = const FlutterSecureStorage();
  static const String _tokenKey = 'auth_token';
  static const String _userNameKey = 'user_name';
  static const String _userEmailKey = 'user_email';
  static const String _userIdKey = 'user_id';
  static const String _onboardingKey = 'onboarding_completed';

  // Auth holatini saqlash uchun
  final isAuthenticated = false.obs;
  final isLoading = true.obs;
  final isOnboardingCompleted = false.obs;

  // late Dio _dio;

  @override
  Future<void> onInit() async {
    super.onInit();
    // Onboarding holatini tekshirish
    final onboardingCompleted = await _storage.read(key: _onboardingKey);
    isOnboardingCompleted.value = onboardingCompleted == 'true';

    isAuthenticated.value = false;
    isLoading.value = false;

    // _dio = Dio();
  }

  // Auth holatini tekshirish
  Future<void> checkAuthStatus() async {
    isLoading.value = true;
    try {
      final token = await _storage.read(key: _tokenKey);
      AppLogger.debug('Stored token: $token');

      if (token == null) {
        isAuthenticated.value = false;
        AppLogger.info('User is not authenticated');
        return;
      }

      await getUserInfo();
      isAuthenticated.value = true;
    } catch (e) {
      AppLogger.error('Error checking auth status: $e');
      await logout();
    } finally {
      isLoading.value = false;
    }
  }

  // Foydalanuvchi ma'lumotlarini saqlash
  Future<void> saveUserData({
    required String token,
    required String name,
    required String email,
    required String id,
  }) async {
    AppLogger.debug('Saving token: $token');
    AppLogger.debug('Saving user data: name=$name, email=$email, id=$id');
    await _storage.write(key: _tokenKey, value: token);
    await _storage.write(key: _userNameKey, value: name);
    await _storage.write(key: _userEmailKey, value: email);
    await _storage.write(key: _userIdKey, value: id);
    isAuthenticated.value = true;
    AppLogger.info('User data saved successfully');
  }

  // Foydalanuvchi ma'lumotlarini olish
  Future<Map<String, dynamic>?> getUserInfo() async {
    try {
      final token = await _storage.read(key: _tokenKey);
      if (token == null) {
        return null;
      }

      final response = await http.get(
        Uri.parse('${EnvConfig.apiBaseUrl}/auth/me'),
        headers: {
          'Authorization': token,
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
      );

      AppLogger.debug('GET /auth/me Response status: ${response.statusCode}');

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final clientData = data['client'];

        if (clientData == null) {
          AppLogger.warning('Client data not found in response');
          return null;
        }

        AppLogger.info('User info retrieved successfully');
        AppLogger.debug('User data: ${json.encode(clientData)}');

        await saveUserData(
          token: token,
          name: clientData['full_name'] ?? '',
          email: clientData['email'] ?? '',
          id: clientData['id']?.toString() ?? '',
        );
        return clientData;
      }

      if (response.statusCode == 401) {
        AppLogger.info('Token expired or invalid');
        await logout();
        return null;
      }

      AppLogger.error('Failed to get user info: ${response.statusCode}');
      return null;
    } catch (e) {
      AppLogger.error('Error in getUserInfo: $e');
      return null;
    }
  }

  // Onboarding tugaganini saqlash
  Future<void> completeOnboarding() async {
    await _storage.write(key: _onboardingKey, value: 'true');
    isOnboardingCompleted.value = true;
  }

  // Tizimdan chiqish
  Future<void> logout() async {
    AppLogger.info('Logging out user');
    await _storage.deleteAll();
    // Onboarding holatini saqlab qolish
    if (isOnboardingCompleted.value) {
      await _storage.write(key: _onboardingKey, value: 'true');
      AppLogger.debug('Preserved onboarding status after logout');
    }
    isAuthenticated.value = false;
    AppLogger.info('User logged out successfully');
  }

  // Login
  Future<(bool, String)> login(String email, String password) async {
    isLoading.value = true;
    final url = Uri.parse('${EnvConfig.apiBaseUrl}/auth/token');
    try {
      AppLogger.debug('Attempting login for user: $email');

      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: {
          'username': email,
          'password': password,
        },
      );

      AppLogger.debug('Login response status: ${response.statusCode}');

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final token = data['access_token'];
        final clientData = data['client'];
        final tokenType = data['token_type'];

        AppLogger.debug('Received token type: $tokenType');
        AppLogger.debug('Received access token: $token');

        if (token == null || clientData == null) {
          AppLogger.error('Token or client data missing in response');
          return (false, 'Token yoki foydalanuvchi ma\'lumotlari topilmadi');
        }

        final fullToken = '$tokenType $token';
        AppLogger.debug('Created full token: $fullToken');

        await saveUserData(
          token: fullToken,
          name: clientData['full_name'] ?? '',
          email: clientData['email'] ?? '',
          id: clientData['id']?.toString() ?? '',
        );

        isAuthenticated.value = true;
        AppLogger.info('User logged in successfully');
        return (true, 'Muvaffaqiyatli tizimga kirdingiz!');
      }

      if (response.statusCode == 400 || response.statusCode == 401) {
        final data = json.decode(response.body);
        AppLogger.warning('Login failed: Invalid credentials');
        return (
          false,
          (data['detail'] ?? 'Email yoki parol noto\'g\'ri').toString()
        );
      }

      AppLogger.error('Server error during login: ${response.statusCode}');
      return (false, 'Server error: ${response.statusCode}');
    } catch (e, stackTrace) {
      AppLogger.error('Login error: $e\n$stackTrace');
      return (false, e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  // Register
  Future<(bool, String)> register({
    required String email,
    required String password,
    required String fullName,
  }) async {
    isLoading.value = true;
    final url = Uri.parse('${EnvConfig.apiBaseUrl}/clients/');
    try {
      AppLogger.debug('Attempting registration for user: $email');

      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: json.encode({
          'email': email,
          'password': password,
          'full_name': fullName,
        }),
      );

      AppLogger.debug('Registration response status: ${response.statusCode}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        AppLogger.info('User registered successfully');
        return (
          true,
          'Muvaffaqiyatli ro\'yxatdan o\'tdingiz! Iltimos, tizimga kiring.'
        );
      }

      if (response.statusCode == 400) {
        final data = json.decode(response.body);
        AppLogger.warning('Registration failed: ${data['message']}');
        return (false, (data['message'] ?? 'Bad request').toString());
      }

      AppLogger.error(
          'Server error during registration: ${response.statusCode}');
      return (false, 'Server error: ${response.statusCode}');
    } catch (e, stackTrace) {
      AppLogger.error('Registration error: $e\n$stackTrace');
      return (false, e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
