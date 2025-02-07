import 'package:get/get.dart';

class AppLocalization extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': {
          'hello': 'Hello',
          'welcome': 'Welcome',
          'next': 'Next',
          'skip': 'Skip',
          'get_started': 'Get Started',
        },
        'uz_UZ': {
          'hello': 'Salom',
          'welcome': 'Xush kelibsiz',
          'next': 'Keyingisi',
          'skip': 'O\'tkazib yuborish',
          'get_started': 'Boshlash',
        },
      };
}
