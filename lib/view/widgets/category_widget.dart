import 'package:assignmenttest/models/models.dart';
import 'package:assignmenttest/theme/custom_theme/text_theme.dart';
import 'package:assignmenttest/utils/constants/sizes.dart';
import 'package:assignmenttest/utils/constants/text_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/providers.dart';

class CategoryWidget extends ConsumerWidget {
  const CategoryWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categoriesAsyncValue = ref.watch(homeViewModelProvider.select((state) => state.categories));

    return categoriesAsyncValue.when(
      data: (categories) {
        return _buildCategory(categories,context);
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => Center(child: Text('Error: $error')),
    );
  }

  Widget _buildCategory(List<CategoryModel> categories, BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
         Text(
          MyTexts.categories,
           style: Theme.of(context).textTheme.titleSmall, // Uses the titleLarge style
        ),
        const SizedBox(height: MySizes.sm),
        SizedBox(
          height: 80,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: categories.map((category) => buildCategoryCard(category.imageUrl, category.name,context)).toList(),
          ),
        ),
      ],
    );
  }

  Widget buildCategoryCard(String imageUrl, String title,BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: MySizes.sm),
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
                borderRadius: BorderRadius.circular(MySizes.borderRadiusXLg),
              ),
            ),
            const SizedBox(height: MySizes.xs),
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 150),
              child: Text(
                title,
                style: Theme.of(context).textTheme.headlineSmall, // Uses the titleLarge style
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
