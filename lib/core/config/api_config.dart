import 'env_config.dart';

class ApiConfig {
  static String get baseUrl => EnvConfig.apiBaseUrl;

  // API endpointlari
  static const String categoriesEndpoint = '/categories/';
  static const String barbersEndpoint = '/barbers/';
  static const String bannersEndpoint = '/banners/';
  static const String servicesEndpoint = '/services/';
  static const String ordersEndpoint = '/orders/';
  static const String reviewsEndpoint = '/reviews/';
  static const String settingsEndpoint = '/settings/';
  static const String notificationsEndpoint = '/notifications/';
  static const String faqsEndpoint = '/faqs/';
  static const String authEndpoint = '/auth/';
  static const String usersEndpoint = '/users/';
  static const String paymentsEndpoint = '/payments/';
  static const String appointmentsEndpoint = '/appointments/';
}
