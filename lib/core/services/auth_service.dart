import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';

class AuthService extends GetxService {
  final _storage = const FlutterSecureStorage();
  static const String _tokenKey = 'auth_token';
  static const String _userNameKey = 'user_name';
  static const String _userEmailKey = 'user_email';
  static const String _userImageKey = 'user_image';

  // Auth holatini saqlash uchun
  final isAuthenticated = false.obs;

  @override
  void onInit() {
    super.onInit();
    checkAuthStatus();
  }

  // Auth holatini tekshirish
  Future<void> checkAuthStatus() async {
    final token = await _storage.read(key: _tokenKey);
    isAuthenticated.value = token != null;
  }

  // Foydalanuvchi ma'lumotlarini saqlash
  Future<void> saveUserData({
    required String token,
    required String name,
    required String email,
    String? imageUrl,
  }) async {
    await _storage.write(key: _tokenKey, value: token);
    await _storage.write(key: _userNameKey, value: name);
    await _storage.write(key: _userEmailKey, value: email);
    if (imageUrl != null) {
      await _storage.write(key: _userImageKey, value: imageUrl);
    }
    isAuthenticated.value = true;
  }

  // Foydalanuvchi ma'lumotlarini olish
  Future<Map<String, String?>> getUserData() async {
    return {
      'token': await _storage.read(key: _tokenKey),
      'name': await _storage.read(key: _userNameKey),
      'email': await _storage.read(key: _userEmailKey),
      'imageUrl': await _storage.read(key: _userImageKey),
    };
  }

  // Tizimdan chiqish
  Future<void> logout() async {
    await _storage.deleteAll();
    isAuthenticated.value = false;
  }
}
