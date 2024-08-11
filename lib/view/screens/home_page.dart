import 'package:assignmenttest/utils/constants/colors.dart';
import 'package:assignmenttest/utils/constants/sizes.dart';
import 'package:assignmenttest/utils/constants/text_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/providers.dart';
import '../widgets/category_widget.dart';
import '../widgets/custom_appbar.dart';
import '../widgets/recently_ordered_widget.dart';
import '../widgets/image_banner_widget.dart';
import '../widgets/miniCartNudge.dart';
import '../widgets/search_bar.dart';
import '../widgets/vertical_product_list.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final overallState = ref.watch(
        homeViewModelProvider.select((state) => state.overallState));

    return Scaffold(
      appBar: CustomAppBar(
        title: MyTexts.appName,
        onLogoutPressed: () {
          debugPrint('Logout pressed');
        },
      ),
      body: overallState.when(
        data: (data) => _buildHomeWidget(),
        error: (error, stackTrace) => Center(child: Text("Error: $error")),
        loading: () => const Center(child: CircularProgressIndicator()),
      ),
      bottomNavigationBar: const MiniCartNudge(),
    );
  }

  Widget _buildHomeWidget() {
    return SingleChildScrollView(
      child: Container(
        color: MyColors.primary.withOpacity(0.2),
        padding: const EdgeInsets.all(MySizes.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            searchBarWidget(),
            const SizedBox(height: MySizes.md),
            const ImageBannerList(),
            const SizedBox(height: MySizes.md),
            const CategoryWidget(),
            const SizedBox(height: MySizes.md),
            const RecentlyOrderedWidget(),
            const SizedBox(height: MySizes.md),
            const ProductList(), // Ensure this list is scrollable if needed
          ],
        ),
      ),
    );
  }
}
