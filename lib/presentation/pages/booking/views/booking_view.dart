//create booking view

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/booking_controller.dart';

class BookingView extends GetView<BookingController> {
  const BookingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'My Booking',
          style: TextStyle(color: Colors.black),
        ),
        iconTheme: const IconThemeData(color: Colors.black), // Orqa tugma rangi
        actions: [
          // Ikkilamchi actionlar
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // Qidiruv funksiyasi
            },
          ),
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {
              // Boshqa optionlar
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildTabButton("Upcoming", 0),
                _buildTabButton("Completed", 1),
                _buildTabButton("Cancelled", 2),
              ],
            ),
          ),
          Expanded(
            child: Obx(
              () => ListView.builder(
                itemCount: controller.displayedBookings.length,
                itemBuilder: (context, index) {
                  final booking = controller.displayedBookings[index];
                  return BookingCard(
                    salonName: booking.salonName,
                    salonAddress: booking.salonAddress,
                    date: booking.date,
                    time: booking.time,
                    services: booking.services,
                    status: booking.status,
                    imageUrl: booking.imageUrl,
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildTabButton(String text, int index) {
    return Obx(() {
      final isSelected = controller.selectedTabIndex.value == index;
      return InkWell(
        // Bosiladigan effekt
        onTap: () => controller.changeTabIndex(index),

        child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
                color: isSelected ? Colors.orange : Colors.orange.shade100,
                borderRadius: BorderRadius.circular(20)),
            child: Text(
              text,
              style: const TextStyle(
                  fontWeight: FontWeight.bold, color: Colors.white),
            )),
      );
    });
  }
}

class BookingCard extends StatelessWidget {
  final String salonName;
  final String salonAddress;
  final String date;
  final String time;
  final List<String> services;
  final String status;
  final String imageUrl;

  const BookingCard({
    Key? key,
    required this.salonName,
    required this.salonAddress,
    required this.date,
    required this.time,
    required this.services,
    required this.status,
    required this.imageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      elevation: 2, // Kichik soya
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12)), // Burchaklarni yumaloqlash
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '$date - $time',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: status == "Cancelled"
                        ? Colors.red.shade100
                        : Colors.green.shade100, // Statusga qarab rang
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    status,
                    style: TextStyle(
                        color:
                            status == "Cancelled" ? Colors.red : Colors.green,
                        fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
            const SizedBox(height: 16),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    // Internetdan rasm yuklash
                    imageUrl,
                    width: 80,
                    height: 80,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        width: 80,
                        height: 80,
                        color: Colors.grey.shade300,
                        child: const Icon(
                          Icons.image_not_supported,
                          color: Colors.grey,
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        salonName,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        salonAddress,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey.shade600,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Services:',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        services
                            .join(', '), // Servislarni vergul bilan ajratish
                        style: TextStyle(color: Colors.grey.shade700),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
