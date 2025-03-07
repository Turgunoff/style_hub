import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import '../controller/profile_details_controller.dart';

class ProfileDetailsView extends GetView<ProfileDetailsController> {
  const ProfileDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // Custom AppBar with Image Slider
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => Get.back(),
            ),
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                children: [
                  // Image Slider
                  PageView.builder(
                    itemCount: 5,
                    onPageChanged: controller.onPageChanged,
                    itemBuilder: (context, index) {
                      return Image.network(
                        'https://example.com/salon_image_$index.jpg',
                        fit: BoxFit.cover,
                      );
                    },
                  ),
                  // Slider Indicators
                  Positioned(
                    bottom: 20,
                    left: 0,
                    right: 0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        5,
                        (index) => Obx(
                          () => Container(
                            width: 8,
                            height: 8,
                            margin: const EdgeInsets.symmetric(horizontal: 4),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: controller.currentPage.value == index
                                  ? Theme.of(context).colorScheme.primary
                                  : Colors.grey,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Content
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Salon Name and Status
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Barbarella Inova',
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primary,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          'Open',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  // Address
                  Row(
                    children: [
                      Icon(IconsaxPlusLinear.location,
                          color: Colors.grey, size: 20),
                      const SizedBox(width: 8),
                      Text(
                        '6993 Meadow Valley Terrace, New York',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  // Rating
                  Row(
                    children: [
                      Icon(IconsaxPlusLinear.star,
                          color: Colors.amber, size: 20),
                      const SizedBox(width: 8),
                      Text(
                        '4.8',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      Text(
                        ' (3,279 reviews)',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  // Action Buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildActionButton(
                        context,
                        icon: IconsaxPlusLinear.global,
                        label: 'Website',
                        onTap: () {},
                      ),
                      _buildActionButton(
                        context,
                        icon: IconsaxPlusLinear.message,
                        label: 'Message',
                        onTap: () {},
                      ),
                      _buildActionButton(
                        context,
                        icon: IconsaxPlusLinear.call,
                        label: 'Call',
                        onTap: () {},
                      ),
                      _buildActionButton(
                        context,
                        icon: IconsaxPlusLinear.location,
                        label: 'Direction',
                        onTap: () {},
                      ),
                      _buildActionButton(
                        context,
                        icon: IconsaxPlusLinear.share,
                        label: 'Share',
                        onTap: () {},
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  // Our Specialist Section
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Our Specialist',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      TextButton(
                        onPressed: () {},
                        child: Text('See All'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  // Specialist List
                  SizedBox(
                    height: 100,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 4,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(right: 16),
                          child: Column(
                            children: [
                              CircleAvatar(
                                radius: 30,
                                backgroundImage: NetworkImage(
                                    'https://example.com/specialist_$index.jpg'),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                ['Nathan', 'Jenny', 'Sarah', 'Mike'][index],
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                              Text(
                                [
                                  'Sr. Barber',
                                  'Hair Stylist',
                                  'Makeup Artist',
                                  'Sr. Barber'
                                ][index],
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 24),
                  // Navigation Buttons
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                Theme.of(context).colorScheme.primary,
                            foregroundColor: Colors.white,
                          ),
                          child: Text('About us'),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {},
                          style: OutlinedButton.styleFrom(
                            foregroundColor:
                                Theme.of(context).colorScheme.primary,
                          ),
                          child: Text('Services'),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {},
                          style: OutlinedButton.styleFrom(
                            foregroundColor:
                                Theme.of(context).colorScheme.primary,
                          ),
                          child: Text('Package'),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  // About Section
                  Text(
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip.',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text('Read more...'),
                  ),
                  const SizedBox(height: 24),
                  // Working Hours
                  Text(
                    'Working Hours',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 16),
                  _buildWorkingHours(
                    context,
                    days: 'Monday - Friday',
                    hours: '08:00 AM - 21:00 PM',
                  ),
                  const SizedBox(height: 8),
                  _buildWorkingHours(
                    context,
                    days: 'Saturday - Sunday',
                    hours: '10:00 AM - 20:00 PM',
                  ),
                  const SizedBox(height: 24),
                  // Contact Section
                  Text(
                    'Contact us',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    '(406) 555-0120',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                  ),
                  const SizedBox(height: 24),
                  // Address Section
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Our Address',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      TextButton(
                        onPressed: () {},
                        child: Text('See on Maps'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    '6993 Meadow Valley Terrace, New York',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 16),
                  // Map Container
                  Container(
                    height: 200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: Colors.grey[200],
                    ),
                    // Here you would integrate actual map
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
        child: ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: Theme.of(context).colorScheme.primary,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 16),
          ),
          child: Text('Book Now'),
        ),
      ),
    );
  }

  Widget _buildActionButton(
    BuildContext context, {
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.secondary.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: Theme.of(context).colorScheme.primary),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
      ),
    );
  }

  Widget _buildWorkingHours(
    BuildContext context, {
    required String days,
    required String hours,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          days,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        Text(
          hours,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
      ],
    );
  }
}
