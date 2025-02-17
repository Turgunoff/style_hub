import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:style_hub/presentation/controllers/home_controller.dart';

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
            icon: Icon(
              IconsaxPlusLinear.notification,
              size: 24,
            ),
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
                    .surfaceVariant, // Light & Dark mode uchun
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
                  fillColor: Theme.of(context).colorScheme.surfaceVariant,
                  hintStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: Theme.of(context).hintColor, // Hint matni rangi
                      ),
                ),
                readOnly: true, // Klaviatura chiqmasligi uchun
              ),
            ),
            SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Services',
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            fontWeight: FontWeight.bold,
                          )),
                ],
              ),
            ),
            SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Color(0xFFFADBEC),
                          borderRadius: BorderRadius.circular(100),
                        ),
                        padding: EdgeInsets.all(20),
                        child: SvgPicture.asset(
                          'assets/image/qaychi.svg',
                          width: 20,
                          height: 20,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Home',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Color(0xFFEDDBFF),
                          borderRadius: BorderRadius.circular(100),
                        ),
                        padding: EdgeInsets.all(20),
                        child: SvgPicture.asset(
                          'assets/image/makeup.svg',
                          width: 20,
                          height: 20,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Home',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Color(0xFFCAE0FD),
                          borderRadius: BorderRadius.circular(100),
                        ),
                        padding: EdgeInsets.all(20),
                        child: SvgPicture.asset(
                          'assets/image/manikure.svg',
                          width: 20,
                          height: 20,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Home',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Color(0xFFCEFCDC),
                          borderRadius: BorderRadius.circular(100),
                        ),
                        padding: EdgeInsets.all(20),
                        child: SvgPicture.asset(
                          'assets/image/massage.svg',
                          width: 20,
                          height: 20,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Home',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Nearby Your Location',
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
                child: Obx(() => ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: controller.categories.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () =>
                              controller.setSelectedCategoryIndex(index),
                          child: Container(
                            margin: const EdgeInsets.only(right: 8),
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            decoration: BoxDecoration(
                              color: controller.selectedCategoryIndex.value ==
                                      index
                                  ? Theme.of(context).colorScheme.primary
                                  : Theme.of(context).colorScheme.tertiary,
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: Center(
                              child: Text(
                                controller.categories[index],
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .copyWith(
                                      color: controller.selectedCategoryIndex
                                                  .value ==
                                              index
                                          ? Colors.white
                                          : Theme.of(context).primaryColor,
                                    ),
                              ),
                            ),
                          ),
                        );
                      },
                    )),
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
}
