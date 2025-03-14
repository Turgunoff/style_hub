import 'package:flutter/foundation.dart';

/// Muhit turlari
enum Environment {
  development,
  staging,
  production,
}

/// API konfiguratsiyasi
class ApiConfig {
  final String baseUrl;
  final String apiKey;
  final int connectionTimeout;
  final bool enableLogging;

  const ApiConfig({
    required this.baseUrl,
    required this.apiKey,
    required this.connectionTimeout,
    required this.enableLogging,
  });

  static ApiConfig getConfig(Environment env) {
    switch (env) {
      case Environment.development:
        return const ApiConfig(
          baseUrl: 'http://159.223.43.76:7777/api/v1',
          apiKey: 'dev_api_key_12345',
          connectionTimeout: 30000,
          enableLogging: true,
        );
      case Environment.staging:
        return const ApiConfig(
          baseUrl: 'https://staging-api.looksy.com/api/v1',
          apiKey: 'staging_api_key_67890',
          connectionTimeout: 20000,
          enableLogging: true,
        );
      case Environment.production:
        return const ApiConfig(
          baseUrl: 'https://api.looksy.com/api/v1',
          apiKey: String.fromEnvironment('API_KEY', defaultValue: ''),
          connectionTimeout: 15000,
          enableLogging: kDebugMode,
        );
    }
  }
}

/// Muhit konfiguratsiyasi
///
/// Bu klass turli muhitlar (development, staging, production) uchun
/// konfiguratsiya ma'lumotlarini saqlaydi va boshqaradi.
class EnvConfig {
  /// Joriy muhit
  static const Environment environment = Environment.development;

  /// API konfiguratsiyasi
  static final ApiConfig _apiConfig = ApiConfig.getConfig(environment);

  /// API bazaviy URL manzili
  static String get apiBaseUrl => _apiConfig.baseUrl;

  /// API kaliti
  static String get apiKey => _apiConfig.apiKey;

  /// Timeout vaqti (millisekundlarda)
  static int get connectionTimeout => _apiConfig.connectionTimeout;

  /// Debug rejimi
  static bool get enableLogging => _apiConfig.enableLogging;

  /// Muhit nomi
  static String get environmentName => environment.name.toUpperCase();

  /// Muhitni tekshirish
  static bool isDevelopment() => environment == Environment.development;
  static bool isStaging() => environment == Environment.staging;
  static bool isProduction() => environment == Environment.production;

  /// Xavfsizlik tekshiruvi
  static bool get isSecure => !isDevelopment();

  /// API URL manzilini tekshirish
  static bool get isApiUrlValid {
    try {
      final uri = Uri.parse(apiBaseUrl);
      return uri.isAbsolute && uri.hasScheme;
    } catch (e) {
      return false;
    }
  }

  /// API kalitini tekshirish
  static bool get isApiKeyValid => apiKey.isNotEmpty;

  /// Konfiguratsiya holatini tekshirish
  static bool get isValid => isApiUrlValid && isApiKeyValid;

  /// Muhit ma'lumotlarini olish
  static Map<String, dynamic> get environmentInfo => {
        'environment': environmentName,
        'apiUrl': apiBaseUrl,
        'timeout': connectionTimeout,
        'logging': enableLogging,
        'secure': isSecure,
        'valid': isValid,
      };
}
