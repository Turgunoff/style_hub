import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:looksy/presentation/pages/explore/views/explore_view.dart';

import '../../booking/views/booking_view.dart';
import '../../inbox/views/inbox_view.dart';
import '../../home/views/home_view.dart';
import '../../profile/views/profile_view.dart';
import '../../../../core/utils/logger.dart';

class BottomNavController extends GetxController {
  final currentIndex = 0.obs;

  final List<Widget> pages = [
    const HomeView(),
    const ExploreView(),
    const BookingView(),
    const InboxView(),
    const ProfileView(),
  ];

  @override
  void onInit() {
    super.onInit();
    AppLogger.debug('Initializing BottomNavController');
  }

  void changePage(int index) {
    AppLogger.debug('Changing page to index: $index');
    currentIndex.value = index;
  }
}
