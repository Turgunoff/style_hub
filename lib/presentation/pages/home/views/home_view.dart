import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:style_hub/presentation/controllers/home_controller.dart';
import 'package:style_hub/presentation/pages/home/widgets/banner_carousel.dart';
import 'package:style_hub/presentation/pages/home/widgets/barber_list.dart';
import 'package:style_hub/presentation/pages/home/widgets/category_tabs.dart';
import 'package:style_hub/presentation/pages/home/widgets/search_bar_widget.dart';
import 'package:style_hub/presentation/pages/home/widgets/shimmer_loading.dart';
import 'package:style_hub/presentation/pages/home/widgets/top_categories.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Style Hub',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        actions: [
          IconButton(
            icon: Icon(IconsaxPlusLinear.notification),
            onPressed: () {
              // Navigate to notifications screen
            },
            tooltip: 'Notification',
          ),
        ],
      ),
      body: Obx(() {
        // Loading holatini aniqlash
        bool isLoading = controller.isLoading.value ||
            controller.isCategoriesLoading.value ||
            controller.isBarbersLoading.value;

        return RefreshIndicator(
          onRefresh: () async {
            await controller.loadBanners();
            await controller.loadCategories();
            await controller.loadBarbers();
          },
          child: ShimmerLoading(
            isLoading: isLoading,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      'Morning, Eldor!',
                      style:
                          Theme.of(context).textTheme.headlineMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                    ),
                  ),
                  const SearchBarWidget(),
                  const SizedBox(height: 16),
                  BannerCarousel(controller: controller),
                  const SizedBox(height: 24),
                  TopCategories(controller: controller),
                  const SizedBox(height: 24),
                  CategoryTabs(controller: controller),
                  const SizedBox(height: 24),
                  BarberList(controller: controller),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
