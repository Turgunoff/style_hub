import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:style_hub/presentation/controllers/home_controller.dart';
import 'package:cached_network_image/cached_network_image.dart';

class CategoryTabs extends StatelessWidget {
  final HomeController controller;

  const CategoryTabs({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Just For You',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              InkWell(
                onTap: () {
                  // Navigate to all categories page
                },
                child: Text(
                  'See All',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 36,
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

              if (controller.categories.isEmpty) {
                return const Center(
                  child: Text('No categories available'),
                );
              }

              return ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: controller.idSortedCategories.length,
                itemBuilder: (context, index) {
                  final category = controller.idSortedCategories[index];
                  return Obx(() => GestureDetector(
                        onTap: () {
                          controller.setSelectedCategoryIndex(index);
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: 8,
                            horizontal: 16,
                          ),
                          margin: const EdgeInsets.only(right: 12),
                          decoration: BoxDecoration(
                            color:
                                controller.selectedCategoryIndex.value == index
                                    ? Theme.of(context).colorScheme.primary
                                    : Theme.of(context).colorScheme.surface,
                            borderRadius: BorderRadius.circular(18),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.1),
                                spreadRadius: 1,
                                blurRadius: 2,
                                offset: const Offset(0, 1),
                              ),
                            ],
                          ),
                          child: Center(
                            child: Text(
                              category.name ?? '',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
                                    color: controller
                                                .selectedCategoryIndex.value ==
                                            index
                                        ? Colors.white
                                        : Theme.of(context)
                                            .colorScheme
                                            .onSurface,
                                    fontWeight: FontWeight.w500,
                                  ),
                            ),
                          ),
                        ),
                      ));
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}
