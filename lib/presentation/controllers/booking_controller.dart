import 'package:get/get.dart';
import '../../core/data/booking.dart';

class BookingController extends GetxController {
  final bookings = <Booking>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchBookings();
  }

  Future<void> fetchBookings() async {
    try {
      // API call or local data fetch
      // For now, using dummy data
      bookings.value = [
        Booking(
          id: '1',
          salonName: 'Bella Curls',
          salonImage: 'https://example.com/image.jpg',
          serviceName: 'Haircut & Styling',
          date: '2024-03-20',
          time: '14:00',
          status: 'upcoming',
        ),
        // Add more dummy bookings
      ];
    } catch (e) {
      print('Error fetching bookings: $e');
      Get.snackbar(
        'error'.tr,
        'error_fetching_bookings'.tr,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  Future<void> cancelBooking(String bookingId) async {
    try {
      // API call to cancel booking
      Get.snackbar(
        'success'.tr,
        'booking_cancelled'.tr,
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      print('Error cancelling booking: $e');
      Get.snackbar(
        'error'.tr,
        'error_cancelling_booking'.tr,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  Future<void> rescheduleBooking(String bookingId) async {
    try {
      // Navigate to reschedule screen
      Get.toNamed('/reschedule', arguments: bookingId);
    } catch (e) {
      print('Error navigating to reschedule: $e');
    }
  }
}