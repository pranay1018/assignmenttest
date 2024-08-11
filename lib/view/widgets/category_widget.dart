import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../utils/string_constants.dart';
import '../../view_model/home_view_model.dart';

class CategoryWidget extends ConsumerWidget {
  const CategoryWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categoriesAsyncValue = ref.watch(homeViewModelProvider.select((state) => state.categories));

    return categoriesAsyncValue.when(
      data: (categories) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Categories',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black),
            ),
            const SizedBox(height: 8),
            SizedBox(
              height: 80,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: categories.map((category) => buildCategory(category.imageUrl, category.name)).toList(),
              ),
            ),
          ],
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => Center(child: Text('Error: $error')),
    );
  }

  Widget buildCategory(String imageUrl, String title) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(imageUrl),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.circular(24.0),
              ),
            ),
            const SizedBox(height: 4),
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 150),
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
//
// Category List
// 1. Category List should contain a title called Categories
// 2. It should be 16px from the above card and 16px from left & right
// 3. Title should be of 14px, black color, bold
// 4. Below the title, we will have a list of horizontal scroll categories and will be 8px from top.
// 5. Each category will have a circular image of 48*48px and below that title of the category
// 6. Categories - Vegetables, Fruits, Fresh Juice Items, Combos, Pure Produced Items
// 7. Category Name should be centrally aligned with category image and should be 2 lines max with
// 12px, bold, black color