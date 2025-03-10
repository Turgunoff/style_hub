import 'package:flutter/material.dart';
import 'package:flutter_carousel_slider/carousel_slider.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shimmer/shimmer.dart';
import 'package:looksy/presentation/pages/home/controller/home_controller.dart';
import 'package:looksy/core/data/models.dart';

class BannerCarousel extends StatelessWidget {
  final HomeController controller;

  const BannerCarousel({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: Obx(() {
        if (controller.isLoading.value) {
          return const SizedBox.shrink();
        }

        if (controller.error.value.isNotEmpty) {
          return Center(
            child: Text(
              controller.error.value,
              style: const TextStyle(color: Colors.red),
            ),
          );
        }

        if (controller.banners.isEmpty) {
          return const Center(
            child: Text('No banners available'),
          );
        }

        return CarouselSlider(
          slideTransform: const DefaultTransform(),
          enableAutoSlider: true,
          unlimitedMode: true,
          slideIndicator: CircularSlideIndicator(
            currentIndicatorColor: Theme.of(context).colorScheme.primary,
            indicatorBackgroundColor: Colors.grey.withAlpha(76),
            indicatorRadius: 5,
            itemSpacing: 12,
            indicatorBorderWidth: 0,
            indicatorBorderColor: Colors.transparent,
            padding: const EdgeInsets.only(bottom: 16),
          ),
          autoSliderDelay: const Duration(seconds: 5),
          children: controller.banners
              .where((banner) => banner.isActive)
              .map((banner) => _buildCarouselItem(
                    context,
                    banner,
                    () {
                      // if (banner.linkUrl != null) {
                      //   // Handle banner tap
                      //   Get.toNamed(banner.linkUrl!);
                      // }
                    },
                  ))
              .toList(),
        );
      }),
    );
  }

  Widget _buildCarouselItem(
    BuildContext context,
    BannerModel banner,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Stack(
          fit: StackFit.expand,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: CachedNetworkImage(
                imageUrl: banner.imageUrl ?? '',
                fit: BoxFit.cover,
                cacheKey: 'banner_${banner.id}',
                memCacheWidth: 800,
                memCacheHeight: 400,
                maxWidthDiskCache: 800,
                maxHeightDiskCache: 400,
                placeholder: (context, url) => Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: Container(
                    color: Colors.white,
                  ),
                ),
                errorWidget: (context, url, error) => Container(
                  color: Colors.grey[300],
                  child: const Icon(Icons.error),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
