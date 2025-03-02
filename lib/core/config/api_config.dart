class ApiConfig {
  static const String baseUrl = String.fromEnvironment(
    'API_BASE_URL',
    defaultValue: 'http://159.223.43.76:7777/api/v1',
  );

  // API endpointlari
  static const String categoriesEndpoint = '/categories/';
  static const String barbersEndpoint = '/barbers/';
  static const String bannersEndpoint = '/banners/';
}
