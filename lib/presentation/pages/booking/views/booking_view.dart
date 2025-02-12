import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import '../../../controllers/booking_controller.dart';

class BookingView extends GetView<BookingController> {
  const BookingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'my_bookings'.tr,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        // actions: [
        //   IconButton(
        //     onPressed: () {},
        //     icon: const Icon(IconsaxPlusLinear.calendar_add),
        //   ),
        // ],
      ),
      body: Column(
        // Column o'rniga ListView
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildTabButton(context, "Upcoming", 0),
                _buildTabButton(context, "Completed", 1),
                _buildTabButton(context, "Cancelled", 2),
              ],
            ),
          ),
          Expanded(
            child: Obx(() => ListView.builder(
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
                )),
          )
        ],
      ),
    );
  }

  Widget _buildTabButton(BuildContext context, String text, int index) {
    return Obx(() {
      final isSelected = controller.selectedTabIndex.value == index;

      return InkWell(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        onTap: () => controller.changeTabIndex(index),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          decoration: BoxDecoration(
            color: isSelected
                ? Theme.of(context).colorScheme.primary
                : Colors.white,
            borderRadius: BorderRadius.circular(100),
            border: Border.all(
              width: 2,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          child: Text(
            text,
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                color: isSelected
                    ? Colors.white
                    : Theme.of(context).colorScheme.primary),
          ),
        ),
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
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: status == "Cancelled"
                        ? Colors.red
                        : (status == 'Completed'
                            ? Colors.green
                            : Theme.of(context)
                                .colorScheme
                                .primary), // Statusga qarab rang, completed va upcoming
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    status,
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: status == "Cancelled"
                              ? Colors.white
                              : (status == 'Completed'
                                  ? Colors.white
                                  : Colors.white),
                        ),
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Divider(
                color: Colors.grey.shade100,
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.network(
                    // Internetdan rasm yuklash
                    imageUrl,
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        width: 100,
                        height: 100,
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
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge!
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        salonAddress,
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                              color: Colors.grey.shade700,
                            ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Services:',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        services
                            .join(', '), // Servislarni vergul bilan ajratish
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            color: Theme.of(context).colorScheme.primary),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: Divider(
                    color: Colors.grey.shade100,
                  ),
                ),
                // Conditional rendering based on status
                if (status == "Completed")
                  ElevatedButton(
                    onPressed: () {
                      // Add your view details action here
                    },
                    child: Text('View Details'),
                  )
                else if (status == "Upcoming")
                  ElevatedButton(
                    onPressed: () {
                      // Add your cancel action here
                    },
                    child: Text('Cancel'),
                  )
                else if (status == "Cancelled")
                  ElevatedButton(
                    onPressed: () {
                      // Add your view details action here
                    },
                    child: Text('View Details'),
                  ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
