import 'package:flutter/foundation.dart';

/// Muhit konfiguratsiyasi
///
/// Bu klass turli muhitlar (development, staging, production) uchun
/// konfiguratsiya ma'lumotlarini saqlaydi.
class EnvConfig {
  /// Joriy muhit
  static const Environment environment = Environment.development;

  /// API bazaviy URL manzili
  static String get apiBaseUrl {
    switch (environment) {
      case Environment.development:
        return 'http://159.223.43.76:7777/api/v1';
      case Environment.staging:
        return 'https://staging-api.stylehub.com/api/v1';
      case Environment.production:
        return 'https://api.stylehub.com/api/v1';
    }
  }

  /// API kaliti
  static String get apiKey {
    switch (environment) {
      case Environment.development:
        return 'dev_api_key_12345';
      case Environment.staging:
        return 'staging_api_key_67890';
      case Environment.production:
        return const String.fromEnvironment('API_KEY', defaultValue: '');
    }
  }

  /// Timeout vaqti (millisekundlarda)
  static int get connectionTimeout {
    switch (environment) {
      case Environment.development:
        return 30000; // 30 sekund
      case Environment.staging:
        return 20000; // 20 sekund
      case Environment.production:
        return 15000; // 15 sekund
    }
  }

  /// Debug rejimi
  static bool get enableLogging {
    return environment != Environment.production || kDebugMode;
  }
}

/// Muhit turlari
enum Environment {
  development,
  staging,
  production,
}
