import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:dio/dio.dart';

class AuthService extends GetxService {
  final _storage = const FlutterSecureStorage();
  static const String _tokenKey = 'auth_token';
  static const String _userNameKey = 'user_name';
  static const String _userEmailKey = 'user_email';
  static const String _userIdKey = 'user_id';
  static const String _onboardingKey = 'onboarding_completed';

  static const String _baseUrl = 'http://159.223.43.76:7777/api/v1';

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
      if (token == null) {
        isAuthenticated.value = false;
        return;
      }

      final userData = await getUserInfo();
      await saveUserData(
        token: token,
        name: userData['full_name'] ?? '',
        email: userData['email'] ?? '',
        id: userData['id']?.toString() ?? '',
      );
      isAuthenticated.value = true;
    } catch (e) {
      debugPrint('Error checking auth status: $e');
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
    debugPrint('Saving token: $token');
    await _storage.write(key: _tokenKey, value: token);
    await _storage.write(key: _userNameKey, value: name);
    await _storage.write(key: _userEmailKey, value: email);
    await _storage.write(key: _userIdKey, value: id);
    isAuthenticated.value = true;
  }

  // Foydalanuvchi ma'lumotlarini olish
  Future<Map<String, dynamic>> getUserInfo() async {
    try {
      final token = await _storage.read(key: _tokenKey);
      debugPrint('Retrieved token for /auth/me: $token');

      if (token == null) {
        debugPrint('Token not found in storage');
        throw Exception('Token not found');
      }

      final response = await http.get(
        Uri.parse('$_baseUrl/auth/me'),
        headers: {
          'Authorization': token,
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
      );

      debugPrint('GET /auth/me Request headers: ${response.request?.headers}');
      debugPrint('GET /auth/me Response status: ${response.statusCode}');
      debugPrint('GET /auth/me Response body: ${response.body}');

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        debugPrint('Parsed user data: $data');

        final clientData = data['client'];
        debugPrint('Client data: $clientData');

        if (clientData == null) {
          throw Exception('Client data not found in response');
        }

        debugPrint('User full_name: ${clientData['full_name']}');
        debugPrint('User email: ${clientData['email']}');

        // Ma'lumotlarni saqlash
        await saveUserData(
          token: token,
          name: clientData['full_name'] ?? '',
          email: clientData['email'] ?? '',
          id: clientData['id']?.toString() ?? '',
        );
        return clientData;
      }

      if (response.statusCode == 401) {
        debugPrint('Token expired or invalid');
        // Token eskirgan yoki yaroqsiz
        await logout();
        throw Exception('Unauthorized');
      }

      debugPrint('Unexpected status code: ${response.statusCode}');
      throw Exception('Failed to get user info: ${response.statusCode}');
    } catch (e) {
      debugPrint('Error in getUserInfo: $e');
      rethrow;
    }
  }

  // Onboarding tugaganini saqlash
  Future<void> completeOnboarding() async {
    await _storage.write(key: _onboardingKey, value: 'true');
    isOnboardingCompleted.value = true;
  }

  // Tizimdan chiqish
  Future<void> logout() async {
    await _storage.deleteAll();
    // Onboarding holatini saqlab qolish
    if (isOnboardingCompleted.value) {
      await _storage.write(key: _onboardingKey, value: 'true');
    }
    isAuthenticated.value = false;
  }

  // Login
  Future<(bool, String)> login(String email, String password) async {
    isLoading.value = true;
    final url = Uri.parse('$_baseUrl/auth/token');
    try {
      debugPrint('Making POST request to: $url');
      debugPrint('Request body: username=$email&password=$password');

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

      debugPrint('Response status: ${response.statusCode}');
      debugPrint('Response headers: ${response.headers}');
      debugPrint('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final token = data['access_token'];
        final clientData = data['client'];
        final tokenType = data['token_type'];

        debugPrint('Received token: $tokenType $token');

        if (token == null || clientData == null) {
          return (false, 'Token yoki foydalanuvchi ma\'lumotlari topilmadi');
        }

        final fullToken = '$tokenType $token';
        await saveUserData(
          token: fullToken,
          name: clientData['full_name'] ?? '',
          email: clientData['email'] ?? '',
          id: clientData['id']?.toString() ?? '',
        );

        isAuthenticated.value = true;
        return (true, 'Muvaffaqiyatli tizimga kirdingiz!');
      }

      if (response.statusCode == 400 || response.statusCode == 401) {
        final data = json.decode(response.body);
        return (
          false,
          (data['detail'] ?? 'Email yoki parol noto\'g\'ri').toString()
        );
      }

      return (false, 'Server error: ${response.statusCode}');
    } catch (e, stackTrace) {
      debugPrint('Login error: $e');
      debugPrint('Stack trace: $stackTrace');
      return (false, e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<(bool, String)> register({
    required String email,
    required String password,
    required String fullName,
  }) async {
    isLoading.value = true;
    final url = Uri.parse('$_baseUrl/clients/');
    try {
      final requestBody = {
        'email': email,
        'password': password,
        'full_name': fullName,
      };
      debugPrint('Making POST request to: $url');
      debugPrint(
          'Request body: ${JsonEncoder.withIndent('  ').convert(requestBody)}');

      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: json.encode(requestBody),
      );

      debugPrint('Response status: ${response.statusCode}');
      debugPrint('Response headers: ${response.headers}');
      debugPrint(
          'Response body: ${response.body.isNotEmpty ? JsonEncoder.withIndent('  ').convert(json.decode(response.body)) : 'Empty response'}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = json.decode(response.body);
        // Ro'yxatdan o'tish muvaffaqiyatli
        debugPrint('Registration successful: $data');
        return (
          true,
          'Muvaffaqiyatli ro\'yxatdan o\'tdingiz! Iltimos, tizimga kiring.'
        );
      }

      if (response.statusCode == 400) {
        final data = json.decode(response.body);
        return (false, (data['message'] ?? 'Bad request').toString());
      }

      return (false, 'Server error: ${response.statusCode}');
    } catch (e, stackTrace) {
      debugPrint('Registration error: $e');
      debugPrint('Stack trace: $stackTrace');
      return (false, e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
