import 'env_config.dart';

class ApiConfig {
  static String get baseUrl => EnvConfig.apiBaseUrl;

  // API endpointlari
  static const String categoriesEndpoint = '/categories/';
  static const String barbersEndpoint = '/barbers/';
  static const String bannersEndpoint = '/banners/';
}
