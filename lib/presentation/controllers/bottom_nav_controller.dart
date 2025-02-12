import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:style_hub/presentation/pages/explore/views/explore_view.dart';

import '../pages/booking/views/booking_view.dart';
import '../pages/cart/views/cart_view.dart';
import '../pages/home/views/home_view.dart';
import '../pages/profile/views/profile_view.dart';

class BottomNavController extends GetxController {
  final currentIndex = 0.obs;

  final List<Widget> pages = [
    const HomeView(),
    const ExploreView(),
    const BookingView(),
    const CartView(),
    const ProfileView(),
  ];

  void changePage(int index) {
    currentIndex.value = index;
  }
}
