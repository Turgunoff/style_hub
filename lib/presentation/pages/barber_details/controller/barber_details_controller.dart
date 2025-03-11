import 'package:get/get.dart';
import 'package:dio/dio.dart';
import '../../../../core/utils/logger.dart';
import '../../../../core/config/env_config.dart';

class BarberDetailsController extends GetxController {
  final Dio _dio = Dio();

  // Barber data
  final id = 0.obs;
  final barberName = ''.obs;
  final barberImage = ''.obs;
  final phone = ''.obs;
  final email = ''.obs;
  final bio = ''.obs;
  final experience = 0.obs;
  final rating = 0.0.obs;
  final reviewCount = 0.obs;
  final location = ''.obs;
  final categoryId = 0.obs;

  final services = <Map<String, dynamic>>[].obs;
  final gallery = <String>[].obs;
  final reviews = <Map<String, dynamic>>[].obs;

  // Loading states
  final isLoading = true.obs;
  final isServicesLoading = true.obs;
  final isReviewsLoading = true.obs;
  final error = ''.obs;

  // Selected tab index
  final selectedTabIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();
    AppLogger.debug('Initializing BarberDetailsController');

    // Get barber ID from parameters
    final barberId = Get.arguments?['barber_id'] ?? '';

    loadBarberDetails(barberId);
  }

  void changeTabIndex(int index) {
    selectedTabIndex.value = index;
  }

  Future<void> loadBarberDetails(dynamic barberId) async {
    try {
      AppLogger.debug('Loading barber details for ID: $barberId');
      isLoading.value = true;
      error.value = '';

      // API call
      final response =
          await _dio.get('${EnvConfig.apiBaseUrl}/barbers/$barberId');
      AppLogger.debug('Barber API response: ${response.statusCode}');

      if (response.statusCode == 200) {
        final data = response.data;

        // Set barber data
        id.value = data['id'] ?? 0;
        barberName.value = data['full_name'] ?? '';
        barberImage.value = data['image_url'] ?? '';
        phone.value = data['phone'] ?? '';
        email.value = data['email'] ?? '';
        bio.value = data['bio'] ?? '';
        experience.value = data['experience'] ?? 0;
        rating.value =
            data['rating'] != null ? (data['rating'] as num).toDouble() : 0.0;
        categoryId.value = data['category_id'] ?? 0;

        // For now, use static values for these
        reviewCount.value = 128;
        location.value = 'Tashkent, Uzbekistan';

        AppLogger.info(
            'Barber details loaded successfully: ${barberName.value}');
      } else {
        throw Exception(
            'Failed to load barber details: ${response.statusCode}');
      }
    } catch (e) {
      error.value = 'Error loading barber details: $e';
      AppLogger.error('Error loading barber details: $e');
    } finally {
      isLoading.value = false;
    }

    // Load other data after main details
    loadBarberServices();
    loadBarberGallery();
    loadBarberReviews();
  }

  Future<void> loadBarberServices() async {
    try {
      AppLogger.debug('Loading barber services');
      isServicesLoading.value = true;

      // Simulate API call with demo data
      await Future.delayed(const Duration(milliseconds: 800));

      // Set dummy services data
      services.value = [
        {
          'name': 'Classic Haircut',
          'price': '25.00',
          'duration': '30 min',
          'description': 'Traditional haircut with scissors and clipper'
        },
        {
          'name': 'Beard Trim',
          'price': '15.00',
          'duration': '15 min',
          'description': 'Shape and trim beard with razor finish'
        },
        {
          'name': 'Haircut & Beard Combo',
          'price': '35.00',
          'duration': '45 min',
          'description': 'Full haircut and beard trim service'
        },
        {
          'name': 'Hair Wash & Styling',
          'price': '20.00',
          'duration': '20 min',
          'description': 'Premium shampoo and professional styling'
        },
        {
          'name': 'Skin Fade',
          'price': '30.00',
          'duration': '35 min',
          'description': 'Gradual fade from skin to desired length'
        },
      ];

      isServicesLoading.value = false;
      AppLogger.info('Barber services loaded successfully');
    } catch (e) {
      isServicesLoading.value = false;
      AppLogger.error('Error loading barber services: $e');
    }
  }

  Future<void> loadBarberGallery() async {
    try {
      AppLogger.debug('Loading barber gallery');

      // Simulate API call with demo data
      await Future.delayed(const Duration(milliseconds: 600));

      // Set dummy gallery data
      gallery.value = [
        'https://images.unsplash.com/photo-1605497788044-5a32c7078486?q=80&w=1974&auto=format&fit=crop',
        'https://images.unsplash.com/photo-1599351431202-1e0f0137899a?q=80&w=1972&auto=format&fit=crop',
        'https://images.unsplash.com/photo-1503951914875-452162b0f3f1?q=80&w=2070&auto=format&fit=crop',
        'https://images.unsplash.com/photo-1596728325488-58c87691e9af?q=80&w=2076&auto=format&fit=crop',
        'https://images.unsplash.com/photo-1621605815971-fbc98d665033?q=80&w=2070&auto=format&fit=crop',
        'https://images.unsplash.com/photo-1622296089863-53e3c86f5906?q=80&w=2070&auto=format&fit=crop',
      ];

      AppLogger.info('Barber gallery loaded successfully');
    } catch (e) {
      AppLogger.error('Error loading barber gallery: $e');
    }
  }

  Future<void> loadBarberReviews() async {
    try {
      AppLogger.debug('Loading barber reviews');
      isReviewsLoading.value = true;

      // Simulate API call with demo data
      await Future.delayed(const Duration(seconds: 1));

      // Set dummy reviews data
      reviews.value = [
        {
          'user_name': 'John Smith',
          'avatar': 'https://i.pravatar.cc/150?img=1',
          'rating': 5.0,
          'date': '2 days ago',
          'comment':
              'Great service and very professional. Will definitely come back!'
        },
        {
          'user_name': 'Michael Johnson',
          'avatar': 'https://i.pravatar.cc/150?img=3',
          'rating': 4.5,
          'date': '1 week ago',
          'comment':
              '${barberName.value} is a skilled barber. My haircut looks great!'
        },
        {
          'user_name': 'Robert Williams',
          'avatar': 'https://i.pravatar.cc/150?img=4',
          'rating': 5.0,
          'date': '2 weeks ago',
          'comment':
              'Excellent attention to detail and really listens to what you want.'
        },
        {
          'user_name': 'James Brown',
          'avatar': 'https://i.pravatar.cc/150?img=5',
          'rating': 4.0,
          'date': '1 month ago',
          'comment': 'Good haircut, but had to wait a bit longer than expected.'
        },
      ];

      isReviewsLoading.value = false;
      AppLogger.info('Barber reviews loaded successfully');
    } catch (e) {
      isReviewsLoading.value = false;
      AppLogger.error('Error loading barber reviews: $e');
    }
  }
}
