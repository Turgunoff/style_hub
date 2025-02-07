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
          'nearby_location': 'Nearby Your Location',
          'see_all': 'See All',
          'most_popular': 'Most Popular',
        },
        'uz_UZ': {
          'hello': 'Salom',
          'welcome': 'Xush kelibsiz',
          'next': 'Keyingisi',
          'skip': 'O\'tkazib yuborish',
          'get_started': 'Boshlash',
          'nearby_location': 'Yaqin manzildagilar',
          'see_all': 'Barchasi',
          'most_popular': 'Ommabop',
        },
      };
}
