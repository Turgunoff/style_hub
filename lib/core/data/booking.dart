class Booking {
  final String salonName;
  final String salonAddress;
  final String date; // String o'rniga DateTime ishlatsangiz ham bo'ladi
  final String time;
  final List<String> services;
  final String status; // "Upcoming", "Completed", "Cancelled"
  final String imageUrl; // Salon rasmi URL

  Booking({
    required this.salonName,
    required this.salonAddress,
    required this.date,
    required this.time,
    required this.services,
    required this.status,
    required this.imageUrl,
  });
}