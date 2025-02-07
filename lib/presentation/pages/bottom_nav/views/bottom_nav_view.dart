import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:style_hub/presentation/controllers/bottom_nav_controller.dart';
import 'package:style_hub/presentation/pages/booking/views/booking_view.dart';
import 'package:style_hub/presentation/pages/profile/views/profile_view.dart'; // Example
import 'package:style_hub/presentation/pages/cart/views/cart_view.dart';

import '../../home/views/home_view.dart'; // Example

class BottomNavView extends GetView<BottomNavController> {
  BottomNavView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // body: Obx(() => _pages[_controller.selectedIndex.value]),
      body: Obx(() => IndexedStack(
            index: controller.selectedIndex.value, //boshqa BottomNavController
            children: [
              HomeView(),
              BookingView(),
              CartView(),
              ProfileView(),
            ],
          )),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          currentIndex: controller.selectedIndex.value,
          onTap: controller.changeIndex,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.home,
                ),
                label: 'Home'),
            BottomNavigationBarItem(
                icon: Icon(Icons.calendar_today), label: 'Booking'),
            BottomNavigationBarItem(
                icon: Icon(Icons.shopping_cart), label: 'Cart'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
          ],
        ),
      ),
    );
  }
}
