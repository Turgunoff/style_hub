import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:style_hub/presentation/controllers/bottom_nav_controller.dart';
import 'package:style_hub/presentation/pages/profile/views/profile_view.dart'; // Example
import 'package:style_hub/presentation/pages/cart/views/cart_view.dart';

import '../home/views/home_view.dart';


class BottomNavView extends StatelessWidget {
  BottomNavView({Key? key}) : super(key: key);

  final BottomNavController _controller = Get.put(BottomNavController());

  final List<Widget> _pages = [
    HomeView(),
    CartView(), // Replace with your actual page
    ProfileView(), // Replace with your actual page
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => _pages[_controller.selectedIndex.value]),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          currentIndex: _controller.selectedIndex.value,
          onTap: _controller.changeIndex,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.home,
                ),
                label: 'Home'),
            BottomNavigationBarItem(
                icon: Icon(Icons.shopping_cart), label: 'Cart'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
          ],
        ),
      ),
    );
  } 
}
