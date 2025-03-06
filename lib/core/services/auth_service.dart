import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';

class AuthService extends GetxService {
  final _storage = const FlutterSecureStorage();
  static const String _tokenKey = 'auth_token';
  static const String _userNameKey = 'user_name';
  static const String _userEmailKey = 'user_email';
  static const String _userIdKey = 'user_id';

  static const String _baseUrl = 'http://159.223.43.76:7777/api/v1';

  // Auth holatini saqlash uchun
  final isAuthenticated = false.obs;
  final isLoading = true.obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    // Splash screen'da checkAuthStatus chaqiriladi
    isAuthenticated.value = false;
    isLoading.value = false;
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

      // API dan foydalanuvchi ma'lumotlarini olish
      final response = await http.get(
        Uri.parse('$_baseUrl/auth/me'),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final userData = json.decode(response.body);
        // Foydalanuvchi ma'lumotlarini saqlash
        await saveUserData(
          token: token,
          name: userData['full_name'] ?? '',
          email: userData['email'] ?? '',
          id: userData['id']?.toString() ?? '',
        );
        isAuthenticated.value = true;
      } else {
        // Token yaroqsiz bo'lsa, tozalash
        await logout();
      }
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
    await _storage.write(key: _tokenKey, value: token);
    await _storage.write(key: _userNameKey, value: name);
    await _storage.write(key: _userEmailKey, value: email);
    await _storage.write(key: _userIdKey, value: id);
    isAuthenticated.value = true;
  }

  // Foydalanuvchi ma'lumotlarini olish
  Future<Map<String, String?>> getUserData() async {
    return {
      'token': await _storage.read(key: _tokenKey),
      'name': await _storage.read(key: _userNameKey),
      'email': await _storage.read(key: _userEmailKey),
      'id': await _storage.read(key: _userIdKey),
    };
  }

  // Tizimdan chiqish
  Future<void> logout() async {
    await _storage.deleteAll();
    isAuthenticated.value = false;
  }

  // Login
  Future<bool> login(String email, String password) async {
    isLoading.value = true;
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/clients'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'email': email,
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        await saveUserData(
          token: data['token'] ?? '', // API javobida token kelishi kerak
          name: data['full_name'] ?? '',
          email: data['email'] ?? '',
          id: data['id']?.toString() ?? '',
        );
        return true;
      } else {
        return false;
      }
    } catch (e) {
      debugPrint('Login error: $e');
      return false;
    } finally {
      isLoading.value = false;
    }
  }
}
