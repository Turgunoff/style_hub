import 'package:dio/dio.dart';
import '../data/models/user_model.dart';
import '../utils/logger.dart';
import 'base_repository.dart';

/// Autentifikatsiya repositorysi
///
/// Bu repository foydalanuvchi autentifikatsiyasi bilan bog'liq
/// barcha so'rovlarni boshqaradi.
class AuthRepository extends BaseRepository {
  /// Tizimga kirish
  Future<(UserModel, String)> login(String email, String password) async {
    try {
      final response = await dioClient.post(
        '/auth/token',
        data: {
          'username': email,
          'password': password,
        },
        options: Options(
          validateStatus: (status) => status! < 500,
          headers: {
            'Content-Type': 'application/x-www-form-urlencoded',
          },
        ),
      );

      if (response.statusCode == 422) {
        throw Exception('Email yoki parol noto\'g\'ri');
      }

      final user =
          parseResponse(response, (data) => UserModel.fromJson(data['client']));
      final token = response.data['access_token'] as String;

      if (token == null) {
        throw Exception('Token not found in response');
      }

      return (user, token);
    } on DioException catch (e) {
      handleError(e);
      rethrow;
    }
  }

  /// Foydalanuvchi ma'lumotlarini olish
  Future<UserModel?> getUserInfo() async {
    try {
      final response = await dioClient.get('/auth/me');
      return parseResponse(
          response, (data) => UserModel.fromJson(data['client']));
    } on DioException catch (e) {
      handleError(e);
      return null;
    }
  }

  /// Ro'yxatdan o'tish
  Future<UserModel> register({
    required String email,
    required String password,
    required String fullName,
  }) async {
    try {
      final response = await dioClient.post(
        '/clients/',
        data: {
          'email': email,
          'password': password,
          'full_name': fullName,
        },
      );

      return parseResponse(response, (data) => UserModel.fromJson(data));
    } on DioException catch (e) {
      handleError(e);
      rethrow;
    }
  }

  /// Tizimdan chiqish
  Future<void> logout() async {
    try {
      await dioClient.post('/auth/logout');
    } on DioException catch (e) {
      handleError(e);
      rethrow;
    }
  }
}
