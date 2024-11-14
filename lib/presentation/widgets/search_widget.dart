import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';

class SearchWidget extends StatelessWidget {
  const SearchWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      decoration: BoxDecoration(
        color: const Color(0xffF5F5F5),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: const Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            Iconsax.search_normal_outline,
            size: 16,
            color: Colors.grey,
          ),
          SizedBox(width: 8),
          Text(
            'Search',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
          )
        ],
      ),
    );
  }
}
