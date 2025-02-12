import 'package:get/get.dart';
import '../../core/data/booking.dart';

class BookingController extends GetxController {
  final selectedTabIndex = 0.obs; // Boshlang'ich qiymat 0 (Upcoming)

  // Dummy data (siz o'zingizning haqiqiy ma'lumotlaringiz bilan almashtirasiz)
  final List<Booking> _allBookings = [
    Booking(
      salonName: 'Lighthouse Barbers',
      salonAddress: '5010 Hudson Plaza',
      date: 'Dec 22, 2024',
      time: '10:00 AM',
      services: ['Quiff Haircut', 'Thin Shaving', 'Aloe Vera Shampoo Hair Wash'],
      status: 'Upcoming', // Upcoming ga o'zgartirildi
      imageUrl:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQAGYI5_tBpHqczmd8x-wG98j7d8u9jQ1T9-X94zN6zXg&s',
    ),
    Booking(
      salonName: 'Quinaatura Salon',
      salonAddress: '7892 Prairieview Avenue',
      date: 'Nov 20, 2024',
      time: '13:00 PM',
      services: ['Undercut Haircut', 'Regular Shaving', 'Natural Hair Wash'],
      status: 'Completed',
      imageUrl:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRsNGg-6oQxa7vV4eJv8-n-vXM_wI8W6OyO-l8L9wz7XQ&s',
    ),
    Booking(
      salonName: 'Luxuriate Barber',
      salonAddress: '0496 8th Street',
      date: 'Oct 19, 2024',
      time: '16:00 PM',
      services: ['Test Service1', 'Test Service2', 'Test Service3'],
      status: 'Cancelled',
      imageUrl:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR_JOqTzB_hhuAJv_w_G-s9-H09N9gO-hGhm_16o8Vl8A&s',
    ),
        Booking(
      salonName: 'Test Upcoming',
      salonAddress: '0496 8th Street',
      date: 'Oct 19, 2024',
      time: '16:00 PM',
      services: ['Test Service1', 'Test Service2', 'Test Service3'],
      status: 'Upcoming',
      imageUrl:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR_JOqTzB_hhuAJv_w_G-s9-H09N9gO-hGhm_16o8Vl8A&s',
    ),
            Booking(
      salonName: 'Test Completed',
      salonAddress: '0496 8th Street',
      date: 'Oct 19, 2024',
      time: '16:00 PM',
      services: ['Test Service1', 'Test Service2', 'Test Service3'],
      status: 'Completed',
      imageUrl:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR_JOqTzB_hhuAJv_w_G-s9-H09N9gO-hGhm_16o8Vl8A&s',
    ),
  ];

  // Barcha bookinglarni statusiga qarab filtrlaydigan getterlar
  List<Booking> get upcomingBookings =>
      _allBookings.where((booking) => booking.status == 'Upcoming').toList();

  List<Booking> get completedBookings =>
      _allBookings.where((booking) => booking.status == 'Completed').toList();

  List<Booking> get cancelledBookings =>
      _allBookings.where((booking) => booking.status == 'Cancelled').toList();

  // Hozirgi tanlangan tabga qarab qaysi bookinglar ko'rsatilishini aniqlaydigan getter
  List<Booking> get displayedBookings {
    switch (selectedTabIndex.value) {
      case 0: // Upcoming
        return upcomingBookings;
      case 1: // Completed
        return completedBookings;
      case 2: // Cancelled
        return cancelledBookings;
      default:
        return [];
    }
  }

  // Tab o'zgarganda chaqiriladigan metod
  void changeTabIndex(int index) {
    selectedTabIndex.value = index;
  }
}