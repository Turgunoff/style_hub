import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';

import '../../widgets/search_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Style Hub'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Iconsax.notification_outline,
              size: 24,
              color: Colors.black,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            GestureDetector(
              onTap: null,
              child: const SearchWidget(),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 8),
              child: Row(
                children: [
                  Text(
                    'Categories',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 110,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 0.0),
                      child: SizedBox(
                        width: 80,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: 70,
                              width: 70,
                              decoration: const BoxDecoration(
                                color: Color(0xffFDF1DF),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                size: 36,
                                Iconsax.bag_happy_bold,
                                color: Color(0xffFB9400),
                              ),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Text(
                              'Product $index',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  itemCount: 10),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Divider(
                color: Colors.grey.shade300,
                height: 1,
                endIndent: 8,
                indent: 8,
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 8),
              child: Row(
                children: [
                  Text(
                    'Most Popular',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.black,
                    ),
                  ),
                  Spacer(),
                  Text(
                    'See All',
                    style: TextStyle(
                      color: Color(0xffFB9400),
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.only(bottom: 8),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: Colors.white,
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black12,
                        spreadRadius: 1.0,
                        blurRadius: 2.0,
                        offset: Offset(0, 1.0),
                      ),
                      // BoxShadow(
                      //   color: Colors.black12,
                      //   spreadRadius: 2.0,
                      //   blurRadius: 4.0,
                      //   offset: Offset(0, -1.0),
                      // ),
                    ],
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.asset(
                          height: 70,
                          width: 70,
                          fit: BoxFit.cover,
                          'assets/images/photo.png',
                        ),
                      ),
                      const SizedBox(width: 12),
                      const SizedBox(
                        height: 70,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              'Eldor Turgunov',
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              'Haircuts',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey,
                              ),
                            ),
                            Row(
                              children: [
                                Icon(Iconsax.location_bold,
                                    size: 16, color: Color(0xffFB9400)),
                                SizedBox(width: 4),
                                Text(
                                  '1.5 km',
                                  style: TextStyle(
                                    color: Colors.black,
                                  ),
                                ),
                                SizedBox(width: 8),
                                Icon(Iconsax.star_bold,
                                    size: 16, color: Colors.yellow),
                                SizedBox(width: 4),
                                Text('4.8'),
                              ],
                            )
                          ],
                        ),
                      ),
                      const Spacer(),
                      const Icon(Iconsax.favorite_chart_bold,
                          size: 24, color: Colors.black),
                    ],
                  ),
                );
              },
              itemCount: 5,
            ),
            Container(
              height: 100,
              child: const Text('Footer'),
              alignment: Alignment.bottomCenter,
              padding: const EdgeInsets.only(bottom: 16),
              color: Colors.red,
            ),
          ],
        ),
      ),
    );
  }
}
