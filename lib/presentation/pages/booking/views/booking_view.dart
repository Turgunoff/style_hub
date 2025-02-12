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
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(IconsaxPlusLinear.calendar_add),
          ),
        ],
      ),
      body: Obx(
        () => controller.bookings.isEmpty
            ? _buildEmptyState()
            : _buildBookingsList(context),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            IconsaxPlusLinear.calendar_1,
            size: 64,
            color: Get.theme.colorScheme.primary,
          ),
          const SizedBox(height: 16),
          Text(
            'no_bookings'.tr,
            style: Get.textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          Text(
            'no_bookings_desc'.tr,
            textAlign: TextAlign.center,
            style: Get.textTheme.bodyMedium,
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () {
              Get.toNamed('/salons');
            },
            child: Text('book_now'.tr),
          ),
        ],
      ),
    );
  }

  Widget _buildBookingsList(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: controller.bookings.length,
      itemBuilder: (context, index) {
        final booking = controller.bookings[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        booking.salonImage,
                        width: 60,
                        height: 60,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            width: 60,
                            height: 60,
                            color: Colors.grey[300],
                            child: const Icon(Icons.error),
                          );
                        },
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            booking.salonName,
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            booking.serviceName,
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ],
                      ),
                    ),
                    _buildStatusChip(booking.status),
                  ],
                ),
                const Divider(height: 24),
                Row(
                  children: [
                    const Icon(IconsaxPlusLinear.calendar, size: 16),
                    const SizedBox(width: 8),
                    Text(
                      booking.date,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const SizedBox(width: 16),
                    const Icon(IconsaxPlusLinear.clock, size: 16),
                    const SizedBox(width: 8),
                    Text(
                      booking.time,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => controller.cancelBooking(booking.id),
                        child: Text('cancel'.tr),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () =>
                            controller.rescheduleBooking(booking.id),
                        child: Text('reschedule'.tr),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildStatusChip(String status) {
    Color chipColor;
    Color textColor;

    switch (status.toLowerCase()) {
      case 'upcoming':
        chipColor = Colors.blue[50]!;
        textColor = Colors.blue;
        break;
      case 'completed':
        chipColor = Colors.green[50]!;
        textColor = Colors.green;
        break;
      case 'cancelled':
        chipColor = Colors.red[50]!;
        textColor = Colors.red;
        break;
      default:
        chipColor = Colors.grey[50]!;
        textColor = Colors.grey;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: chipColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(
        status.tr,
        style: TextStyle(
          color: textColor,
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
