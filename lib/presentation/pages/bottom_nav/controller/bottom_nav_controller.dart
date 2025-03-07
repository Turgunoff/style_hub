import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:looksy/presentation/pages/explore/views/explore_view.dart';

import '../../booking/views/booking_view.dart';
import '../../inbox/views/inbox_view.dart';
import '../../home/views/home_view.dart';
import '../../profile/views/profile_view.dart';

class BottomNavController extends GetxController {
  final currentIndex = 0.obs;

  final List<Widget> pages = [
    const HomeView(),
    const ExploreView(),
    const BookingView(),
    const InboxView(),
    const ProfileView(),
  ];

  void changePage(int index) {
    currentIndex.value = index;
  }
}
