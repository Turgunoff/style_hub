import 'package:flutter/material.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text(
        'Style Hub',
      ),
      actions: [
        IconButton(
          icon: const Icon(IconsaxPlusLinear.message),
          onPressed: () {
            // Navigate to messages screen
          },
        ),
        IconButton(
          icon: const Icon(IconsaxPlusLinear.notification),
          onPressed: () {
            // Get.to(SearchView());
          },
          tooltip: 'Notification',
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
