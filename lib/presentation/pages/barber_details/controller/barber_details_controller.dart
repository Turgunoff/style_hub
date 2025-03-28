import 'package:get/get.dart';
import '../../../../core/utils/logger.dart';
import '../../../../core/repositories/api_repository.dart';
import '../../../../core/data/models/barber_model.dart';

/// Barber tafsilotlari sahifasi uchun controller
///
/// Bu controller barber haqidagi barcha ma'lumotlarni yuklaydi va
/// ko'rsatish uchun boshqaradi.
class BarberDetailsController extends GetxController {
  final ApiRepository _apiRepository = ApiRepository();

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

  // UI states
  final isScrolled = false.obs; // Track if the AppBar is scrolled

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

    // Get barber ID and pre-setup the ID immediately for Hero animation
    final barberId = Get.arguments?['barber_id'] ?? '';
    if (barberId != null && barberId != '') {
      id.value = int.tryParse(barberId.toString()) ?? 0;
    }

    loadBarberDetails(id.value);
  }

  void changeTabIndex(int index) {
    selectedTabIndex.value = index;
  }

  Future<void> loadBarberDetails(int barberId) async {
    try {
      AppLogger.debug('Loading barber details for ID: $barberId');
      isLoading.value = true;
      error.value = '';

      final barber = await _apiRepository.getBarberDetails(barberId);
      _updateBarberData(barber);

      AppLogger.info('Barber details loaded successfully');
    } catch (e) {
      AppLogger.error('Error loading barber details: $e');
      error.value = 'Barber ma\'lumotlarini yuklashda xatolik yuz berdi';
    } finally {
      isLoading.value = false;
    }
  }

  void _updateBarberData(BarberModel barber) {
    barberName.value = barber.fullName;
    barberImage.value = barber.imageUrl;
    phone.value = barber.phone;
    email.value = barber.email;
    bio.value = barber.bio;
    experience.value = barber.experience;
    rating.value = barber.rating;
    categoryId.value = barber.categoryId;
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
