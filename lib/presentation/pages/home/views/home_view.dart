import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:style_hub/presentation/controllers/home_controller.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeController());
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Style Hub',
          style: Theme.of(context).textTheme.bodyLarge,
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
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Morning , Eldor!',
                  style: Theme.of(context).textTheme.headlineLarge),
              SizedBox(height: 16),
              Container(
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
              Row(
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
                          size: 40,
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
                          size: 40,
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
                          size: 40,
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
                          size: 40,
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
              SizedBox(height: 16),
              Row(
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
              SizedBox(height: 16),
              SizedBox(
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
                            margin: EdgeInsets.only(right: 12),
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
              SizedBox(height: 16),
              SizedBox(
                  height: 300,
                  child: ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      itemCount: 3,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {},
                          child: Container(
                            margin: EdgeInsets.only(top: 8),
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.shade300,
                                  spreadRadius: 5,
                                  blurRadius: 1,
                                  offset: Offset(
                                      0, 0), // changes position of shadow
                                ),
                              ],
                            ),
                            child: Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.asset(
                                    'assets/image/photo.jpg',
                                    width: 80,
                                    height: 80,
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium!,
                                      ),
                                      SizedBox(height: 8),
                                      Row(
                                        children: [
                                          Icon(IconsaxPlusLinear.location,
                                              size: 16),
                                          SizedBox(width: 4),
                                          Text(
                                            '1.2 km',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium!,
                                          ),
                                          SizedBox(width: 8),
                                          Icon(IconsaxPlusLinear.star,
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
                              ],
                            ),
                          ),
                        );
                      })),
              Container(
                height: 1500,
                color: Colors.blue,
                margin: EdgeInsets.only(top: 16),
                child: Text('Morning , Eldor!'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
