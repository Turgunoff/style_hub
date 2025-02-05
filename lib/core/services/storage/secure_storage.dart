import 'package:get/get.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage extends GetxService {
  late final FlutterSecureStorage _storage;

  Future<SecureStorage> init() async {
    _storage = const FlutterSecureStorage();
    return this;
  }
}
