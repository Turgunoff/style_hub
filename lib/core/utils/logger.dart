import 'package:flutter/foundation.dart';
import '../config/env_config.dart';

/// Ilovada log yozish uchun yordamchi klass
class AppLogger {
  /// Loglarni yozish kerakmi
  static bool get _shouldLog => EnvConfig.enableLogging;

  /// Debug xabarlarini yozish
  static void debug(String message) {
    if (_shouldLog) {
      debugPrint('💙 DEBUG: $message');
    }
  }

  /// Info xabarlarini yozish
  static void info(String message) {
    if (_shouldLog) {
      debugPrint('💚 INFO: $message');
    }
  }

  /// Ogohlantirish xabarlarini yozish
  static void warning(String message) {
    if (_shouldLog) {
      debugPrint('💛 WARNING: $message');
    }
  }

  /// Xatolik xabarlarini yozish
  static void error(String message) {
    if (_shouldLog) {
      debugPrint('❤️ ERROR: $message');
    }
  }
}
