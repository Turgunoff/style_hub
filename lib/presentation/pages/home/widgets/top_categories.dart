import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:style_hub/presentation/controllers/home_controller.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

class TopCategories extends StatelessWidget {
  final HomeController controller;

  const TopCategories({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'Top Categories',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 110,
          child: Obx(() {
            if (controller.isCategoriesLoading.value) {
              return const SizedBox.shrink();
            }

            if (controller.categoriesError.value.isNotEmpty) {
              return Center(
                child: Text(
                  controller.categoriesError.value,
                  style: const TextStyle(color: Colors.red),
                ),
              );
            }

            if (controller.topCategories.isEmpty) {
              return const Center(
                child: Text('No top categories available'),
              );
            }

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: controller.topCategories.map((category) {
                  // Har bir kategoriya uchun unikal rang tanlash
                  Color categoryColor;
                  switch (
                      controller.barberSortedCategories.indexOf(category) % 4) {
                    case 0:
                      categoryColor = Color(0xFFFADBEC); // Pushti
                      break;
                    case 1:
                      categoryColor = Color(0xFFEDDBFF); // Och binafsha
                      break;
                    case 2:
                      categoryColor = Color(0xFFCAE0FD); // Och ko'k
                      break;
                    case 3:
                      categoryColor = Color(0xFFCEFCDC); // Och yashil
                      break;
                    default:
                      categoryColor = Color(0xFFFADBEC);
                  }

                  return Column(
                    children: [
                      Container(
                        height: 64,
                        width: 64,
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: categoryColor,
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: category.imageUrl.startsWith('http')
                            ? CachedNetworkImage(
                                imageUrl: category.imageUrl,
                                width: 32,
                                height: 32,
                                fit: BoxFit.contain,
                                cacheKey: 'category_${category.id}',
                                memCacheWidth:
                                    64, // 2x resolution for better quality
                                memCacheHeight: 64,
                                maxWidthDiskCache: 64,
                                maxHeightDiskCache: 64,
                                placeholder: (context, url) => Icon(
                                  IconsaxPlusLinear.scissor,
                                  size: 24,
                                  color: Colors.grey,
                                ),
                                errorWidget: (context, url, error) => Icon(
                                  IconsaxPlusLinear.scissor,
                                  size: 24,
                                ),
                              )
                            : SvgPicture.asset(
                                'assets/image/qaychi.svg',
                                width: 32,
                                height: 32,
                              ),
                      ),
                      SizedBox(height: 8),
                      SizedBox(
                        width: 70,
                        child: Builder(builder: (context) {
                          final words = category.name.split(' ');
                          return Text(
                            category.name,
                            style: Theme.of(context).textTheme.bodyMedium,
                            textAlign: TextAlign.center,
                            maxLines: words.length > 1 ? 2 : 1,
                            overflow: TextOverflow.ellipsis,
                          );
                        }),
                      ),
                    ],
                  );
                }).toList(),
              ),
            );
          }),
        ),
      ],
    );
  }
}
