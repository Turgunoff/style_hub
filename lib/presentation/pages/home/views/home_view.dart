import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:style_hub/presentation/controllers/home_controller.dart';
import 'package:flutter_carousel_slider/carousel_slider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shimmer/shimmer.dart';

import '../../../routes/app_routes.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Style Hub',
        ),
        actions: [
          IconButton(
            icon: Icon(IconsaxPlusLinear.message),
            onPressed: () {
              // Navigate to messages screen
            },
          ),
          IconButton(
            icon: Icon(IconsaxPlusLinear.notification),
            onPressed: () {
              // Get.to(SearchView());
            },
            tooltip: 'Notification',
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text('Morning , Eldor!',
                  style: Theme.of(context).textTheme.headlineLarge),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Theme.of(context)
                    .colorScheme
                    .surfaceContainerHighest, // Light & Dark mode uchun
              ),
              child: TextField(
                onTap: () {
                  // Get.toNamed('/search'); // Search sahifasiga yo'naltirish
                },
                decoration: InputDecoration(
                  hintText: 'Search',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide.none,
                  ),
                  prefixIcon: Icon(IconsaxPlusLinear.search_normal,
                      color: Theme.of(context)
                          .colorScheme
                          .primary), // Ikonkalar rangi
                  suffixIcon: Icon(IconsaxPlusLinear.setting_4,
                      color: Theme.of(context).primaryColor),
                  filled: true,
                  fillColor:
                      Theme.of(context).colorScheme.surfaceContainerHighest,
                  hintStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: Theme.of(context).hintColor, // Hint matni rangi
                      ),
                ),
                readOnly: true, // Klaviatura chiqmasligi uchun
              ),
            ),
            SizedBox(height: 16),
            SizedBox(
              height: 200,
              child: Obx(() {
                if (controller.isLoading.value) {
                  return Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                  );
                }

                if (controller.error.value.isNotEmpty) {
                  return Center(
                    child: Text(
                      controller.error.value,
                      style: TextStyle(color: Colors.red),
                    ),
                  );
                }

                if (controller.banners.isEmpty) {
                  return Center(
                    child: Text('No banners available'),
                  );
                }

                return CarouselSlider(
                  slideTransform: DefaultTransform(),
                  enableAutoSlider: true,
                  unlimitedMode: true,
                  slideIndicator: CircularSlideIndicator(
                    currentIndicatorColor:
                        Theme.of(context).colorScheme.primary,
                    indicatorBackgroundColor: Colors.grey.withOpacity(0.3),
                    indicatorRadius: 5,
                    itemSpacing: 12,
                    indicatorBorderWidth: 0,
                    indicatorBorderColor: Colors.transparent,
                    padding: EdgeInsets.only(bottom: 16),
                  ),
                  autoSliderDelay: Duration(seconds: 5),
                  children: controller.banners
                      .where((banner) => banner.isActive)
                      .map((banner) => _buildCarouselItem(
                            context,
                            banner,
                            () {
                              if (banner.linkUrl != null) {
                                // Handle banner tap
                                Get.toNamed(banner.linkUrl!);
                              }
                            },
                          ))
                      .toList(),
                );
              }),
            ),
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 16.0),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //     children: [
            //       Text('Services',
            //           style: Theme.of(context).textTheme.titleLarge!.copyWith(
            //                 fontWeight: FontWeight.bold,
            //               )),
            //     ],
            //   ),
            // ),
            SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Obx(() {
                if (controller.isCategoriesLoading.value) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: List.generate(4, (index) {
                      return Column(
                        children: [
                          Shimmer.fromColors(
                            baseColor: Colors.grey[300]!,
                            highlightColor: Colors.grey[100]!,
                            child: Container(
                              height: 64,
                              width: 64,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(100),
                              ),
                            ),
                          ),
                          SizedBox(height: 8),
                          Shimmer.fromColors(
                            baseColor: Colors.grey[300]!,
                            highlightColor: Colors.grey[100]!,
                            child: Container(
                              height: 12,
                              width: 60,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                          ),
                        ],
                      );
                    }),
                  );
                }

                if (controller.categoriesError.value.isNotEmpty) {
                  return Center(
                    child: Text(
                      controller.categoriesError.value,
                      style: TextStyle(color: Colors.red),
                    ),
                  );
                }

                if (controller.topCategories.isEmpty) {
                  return Center(
                    child: Text('Kategoriyalar mavjud emas'),
                  );
                }

                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: controller.topCategories.map((category) {
                    // Har bir kategoriya uchun unikal rang tanlash
                    Color categoryColor;
                    switch (controller.topCategories.indexOf(category) % 4) {
                      case 0:
                        categoryColor = Color(0xFFFADBEC); // Pushti
                        break;
                      case 1:
                        categoryColor = Color(0xFFEDDBFF); // Och binafsha
                        break;
                      case 2:
                        categoryColor = Color(0xFFCAE0FD); // Och ko'k
                        break;
                      case 3:
                        categoryColor = Color(0xFFCEFCDC); // Och yashil
                        break;
                      default:
                        categoryColor = Color(0xFFFADBEC);
                    }

                    return Column(
                      children: [
                        Container(
                          height: 64,
                          width: 64,
                          padding: EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: categoryColor,
                            borderRadius: BorderRadius.circular(100),
                          ),
                          child: category.imageUrl.startsWith('http')
                              ? CachedNetworkImage(
                                  imageUrl: category.imageUrl,
                                  width: 32,
                                  height: 32,
                                  fit: BoxFit.contain,
                                  placeholder: (context, url) => Icon(
                                    IconsaxPlusLinear.scissor,
                                    size: 24,
                                    color: Colors.grey,
                                  ),
                                  errorWidget: (context, url, error) => Icon(
                                    IconsaxPlusLinear.scissor,
                                    size: 24,
                                  ),
                                )
                              : SvgPicture.asset(
                                  'assets/image/qaychi.svg',
                                  width: 32,
                                  height: 32,
                                ),
                        ),
                        SizedBox(height: 8),
                        SizedBox(
                          width: 70,
                          child: Builder(builder: (context) {
                            final words = category.name.split(' ');
                            return Text(
                              category.name,
                              style: Theme.of(context).textTheme.bodyMedium,
                              textAlign: TextAlign.center,
                              maxLines: words.length > 1 ? 2 : 1,
                              overflow: TextOverflow.ellipsis,
                            );
                          }),
                        ),
                      ],
                    );
                  }).toList(),
                );
              }),
            ),
            SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Just for You',
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            fontWeight: FontWeight.bold,
                          )),
                  Text(
                    'See All',
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: Theme.of(context).primaryColor,
                        ),
                  )
                ],
              ),
            ),
            SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: SizedBox(
                height: 40,
                child: GetBuilder<HomeController>(
                  init: HomeController(),
                  initState: (_) {},
                  builder: (_) {
                    return ListView.builder(
                      // physics: NeverScrollableScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemCount: 22,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            controller.setSelectedCategoryIndex(index);
                          },
                          child: Container(
                            margin: EdgeInsets.only(right: 8),
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            decoration: BoxDecoration(
                              color: controller.selectedCategoryIndex == index
                                  ? Theme.of(context).colorScheme.primary
                                  : Theme.of(context).colorScheme.tertiary,
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: Center(
                              child: Text(
                                'Item ${index * 999}',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .copyWith(
                                      color: controller.selectedCategoryIndex ==
                                              index
                                          ? Colors.white
                                          : Theme.of(context).primaryColor,
                                    ),
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ),
            SizedBox(
              child: ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                shrinkWrap: true, // shrinkWrap ni false qildik
                physics:
                    NeverScrollableScrollPhysics(), // Skroll fizikasi yaxshilandi
                scrollDirection: Axis.vertical,
                itemCount: 3,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Get.toNamed(AppRoutes.PROFILE_DETAILS);
                    },
                    child: Card(
                      margin: EdgeInsets.only(bottom: 12),
                      child: Padding(
                        padding: EdgeInsets.all(8),
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(16),
                              child: Image.asset(
                                'assets/image/photo.jpg',
                                width: 80,
                                height: 80,
                                fit: BoxFit
                                    .cover, // Rasmlar moslashuvchan bo'lishi uchun
                                errorBuilder: (context, error, stackTrace) {
                                  return Container(
                                    width: 80,
                                    height: 80,
                                    color: Colors.grey[300],
                                    child: Icon(Icons.error),
                                  );
                                },
                              ),
                            ),
                            SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Bella Curls',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .copyWith(fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    '35 London Road',
                                    style:
                                        Theme.of(context).textTheme.bodyMedium!,
                                  ),
                                  SizedBox(height: 8),
                                  Row(
                                    children: [
                                      Icon(IconsaxPlusBold.location,
                                          color: Theme.of(context).primaryColor,
                                          size: 16),
                                      SizedBox(width: 4),
                                      Text(
                                        '1.2 km',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium!,
                                      ),
                                      SizedBox(width: 8),
                                      Icon(IconsaxPlusLinear.star_1,
                                          color: Theme.of(context).primaryColor,
                                          size: 16),
                                      SizedBox(width: 4),
                                      Text(
                                        '4.5',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium!,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Align(
                              alignment: Alignment.topRight,
                              child: Icon(
                                IconsaxPlusLinear.heart,
                                color: Theme.of(context).primaryColor,
                                size: 24,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Most Popular',
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            fontWeight: FontWeight.bold,
                          )),
                  Text(
                    'See All',
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: Theme.of(context).primaryColor,
                        ),
                  )
                ],
              ),
            ),
            SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: SizedBox(
                height: 40,
                child: GetBuilder<HomeController>(
                  init: HomeController(),
                  initState: (_) {},
                  builder: (_) {
                    return ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemCount: 22,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            controller.setSelectedCategoryIndex(index);
                          },
                          child: Container(
                            margin: EdgeInsets.only(right: 8),
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            decoration: BoxDecoration(
                              color: controller.selectedCategoryIndex == index
                                  ? Theme.of(context).colorScheme.primary
                                  : Theme.of(context).colorScheme.tertiary,
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: Center(
                              child: Text(
                                'Item ${index * 999}',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .copyWith(
                                      color: controller.selectedCategoryIndex ==
                                              index
                                          ? Colors.white
                                          : Theme.of(context).primaryColor,
                                    ),
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ),
            SizedBox(
              child: ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                scrollDirection: Axis.vertical,
                itemCount: 10,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Get.toNamed(AppRoutes.PROFILE_DETAILS);
                    },
                    child: Card(
                      margin: EdgeInsets.only(bottom: 12),
                      child: Padding(
                        padding: EdgeInsets.all(8),
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(16),
                              child: Image.asset(
                                'assets/image/photo.jpg',
                                width: 80,
                                height: 80,
                                fit: BoxFit
                                    .cover, // Rasmlar moslashuvchan bo'lishi uchun
                                errorBuilder: (context, error, stackTrace) {
                                  return Container(
                                    width: 80,
                                    height: 80,
                                    color: Colors.grey[300],
                                    child: Icon(Icons.error),
                                  );
                                },
                              ),
                            ),
                            SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Bella Curls',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .copyWith(fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    '35 London Road',
                                    style:
                                        Theme.of(context).textTheme.bodyMedium!,
                                  ),
                                  SizedBox(height: 8),
                                  Row(
                                    children: [
                                      Icon(IconsaxPlusBold.location,
                                          color: Theme.of(context).primaryColor,
                                          size: 16),
                                      SizedBox(width: 4),
                                      Text(
                                        '1.2 km',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium!,
                                      ),
                                      SizedBox(width: 8),
                                      Icon(IconsaxPlusLinear.star_1,
                                          color: Theme.of(context).primaryColor,
                                          size: 16),
                                      SizedBox(width: 4),
                                      Text(
                                        '4.5',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium!,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Align(
                              alignment: Alignment.topRight,
                              child: Icon(
                                IconsaxPlusLinear.heart,
                                color: Theme.of(context).primaryColor,
                                size: 24,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
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
        margin: EdgeInsets.all(8),
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
                placeholder: (context, url) => Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: Container(
                    color: Colors.white,
                  ),
                ),
                errorWidget: (context, url, error) => Container(
                  color: Colors.grey[300],
                  child: Icon(Icons.error),
                ),
              ),
            ),
            // Container(
            //   decoration: BoxDecoration(
            //     borderRadius: BorderRadius.circular(16),
            //     gradient: LinearGradient(
            //       begin: Alignment.topCenter,
            //       end: Alignment.bottomCenter,
            //       colors: [
            //         Colors.transparent,
            //         Colors.black.withOpacity(0.7),
            //       ],
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
