import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:style_hub/presentation/controllers/bottom_nav_controller.dart';

class BottomNavView extends GetView<BottomNavController> {
  const BottomNavView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => controller.pages[controller.currentIndex.value]),
      bottomNavigationBar: Obx(
        () => Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                blurRadius: 10,
                offset: const Offset(0, -5),
              ),
            ],
          ),
          child: BottomNavigationBar(
            currentIndex: controller.currentIndex.value,
            onTap: controller.changePage,
            type: BottomNavigationBarType.fixed,
            elevation: 0,
            backgroundColor: Theme.of(context).colorScheme.surface,
            selectedItemColor: Theme.of(context).colorScheme.primary,
            unselectedItemColor: Colors.grey,
            selectedLabelStyle: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 12,
            ),
            unselectedLabelStyle: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 12,
            ),
            items: [
              _bottomNavigationBarItem(
                icon: IconsaxPlusLinear.home,
                activeIcon: IconsaxPlusBold.home,
                label: 'home'.tr,
              ),
              _bottomNavigationBarItem(
                icon: IconsaxPlusLinear.location,
                activeIcon: IconsaxPlusBold.location,
                label: 'explore'.tr,
              ),
              _bottomNavigationBarItem(
                icon: IconsaxPlusLinear.calendar,
                activeIcon: IconsaxPlusBold.calendar,
                label: 'booking'.tr,
              ),
              _bottomNavigationBarItem(
                icon: IconsaxPlusLinear.heart,
                activeIcon: IconsaxPlusBold.heart,
                label: 'inbox'.tr,
              ),
              _bottomNavigationBarItem(
                icon: IconsaxPlusLinear.profile_circle,
                activeIcon: IconsaxPlusBold.profile_circle,
                label: 'profile'.tr,
              ),
            ],
          ),
        ),
      ),
    );
  }

  BottomNavigationBarItem _bottomNavigationBarItem({
    required IconData icon,
    required IconData activeIcon,
    required String label,
  }) {
    return BottomNavigationBarItem(
      icon: Icon(icon),
      activeIcon: Icon(activeIcon),
      label: label,
    );
  }
}
