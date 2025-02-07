import 'package:get/get.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage extends GetxService {
  late final FlutterSecureStorage _storage;

  Future<SecureStorage> init() async {
    _storage = const FlutterSecureStorage();
    return this;
  }

  Future<void> writeData({required String key, required String value}) async {
    await _storage.write(key: key, value: value);
  }

  Future<String?> readData({required String key}) async {
    return await _storage.read(key: key);
  }

  Future<void> deleteData({required String key}) async {
    await _storage.delete(key: key);
  }
}
