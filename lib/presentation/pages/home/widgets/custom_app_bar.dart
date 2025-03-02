import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        'Style Hub',
      ),
      actions: [
        IconButton(
          icon: Icon(IconsaxPlusLinear.message),
          onPressed: () {
            // Navigate to messages screen
          },
        ),
        IconButton(
          icon: Icon(IconsaxPlusLinear.notification),
          onPressed: () {
            // Get.to(SearchView());
          },
          tooltip: 'Notification',
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
