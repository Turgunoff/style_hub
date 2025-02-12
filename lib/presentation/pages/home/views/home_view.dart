import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:style_hub/presentation/controllers/home_controller.dart';

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
              color: Colors.black,
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
                color: Color(0xFFF0F0F0),
              ),
              child: TextField(
                onChanged: (value) {},
                decoration: InputDecoration(
                  hintText: 'Search',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide.none,
                  ),
                  prefixIcon: Icon(IconsaxPlusLinear.search_normal),
                  suffixIcon: Icon(IconsaxPlusLinear.setting_4,
                      color: Theme.of(context).primaryColor),
                  filled: true,
                  fillColor: Color(0xFFF0F0F0),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFFF0F0F0)),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  hintStyle: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(color: Theme.of(context).hintColor),
                  enabled: false,
                ),
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
                          color: Theme.of(context).colorScheme.secondary,
                          borderRadius: BorderRadius.circular(100),
                        ),
                        padding: EdgeInsets.all(20),
                        child: Icon(
                          IconsaxPlusLinear.home,
                          size: 30,
                          color: Theme.of(context).colorScheme.primary,
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
                          color: Theme.of(context).colorScheme.secondary,
                          borderRadius: BorderRadius.circular(100),
                        ),
                        padding: EdgeInsets.all(20),
                        child: Icon(
                          IconsaxPlusLinear.home,
                          size: 30,
                          color: Theme.of(context).colorScheme.primary,
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
                          color: Theme.of(context).colorScheme.secondary,
                          borderRadius: BorderRadius.circular(100),
                        ),
                        padding: EdgeInsets.all(20),
                        child: Icon(
                          IconsaxPlusLinear.home,
                          size: 30,
                          color: Theme.of(context).colorScheme.primary,
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
                          color: Theme.of(context).colorScheme.secondary,
                          borderRadius: BorderRadius.circular(100),
                        ),
                        padding: EdgeInsets.all(20),
                        child: Icon(
                          IconsaxPlusLinear.home,
                          size: 30,
                          color: Theme.of(context).colorScheme.primary,
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
                height: 40, // Set a fixed height for the ListView
                child: GetBuilder<HomeController>(
                  init: HomeController(),
                  initState: (_) {},
                  builder: (_) {
                    return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 22, // Replace with the actual number of items
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
                                  : Theme.of(context).colorScheme.secondary,
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
                itemCount: 3,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {},
                    child: Container(
                      margin: EdgeInsets.only(bottom: 12),
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(24),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.shade100,
                            spreadRadius: 3,
                            blurRadius: 6,
                            offset: Offset(0, 0), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: Image.asset(
                              'assets/image/photo.jpg',
                              width: 80,
                              height: 80,
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
                                      .copyWith(
                                        fontWeight: FontWeight.bold,
                                      ),
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
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(
                                IconsaxPlusLinear.heart,
                                color: Theme.of(context).primaryColor,
                                size: 24,
                              ),
                            ],
                          ),
                        ],
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
                height: 40, // Set a fixed height for the ListView
                child: GetBuilder<HomeController>(
                  init: HomeController(),
                  initState: (_) {},
                  builder: (_) {
                    return ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemCount: 22, // Replace with the actual number of items
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
                                  : Theme.of(context).colorScheme.secondary,
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
                    onTap: () {},
                    child: Container(
                      margin: EdgeInsets.only(bottom: 12),
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(24),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.shade100,
                            spreadRadius: 3,
                            blurRadius: 6,
                            offset: Offset(0, 0), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: Image.asset(
                              'assets/image/photo.jpg',
                              width: 80,
                              height: 80,
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
                                      .copyWith(
                                        fontWeight: FontWeight.bold,
                                      ),
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
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(
                                IconsaxPlusLinear.heart,
                                color: Theme.of(context).primaryColor,
                                size: 24,
                              ),
                            ],
                          ),
                        ],
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
