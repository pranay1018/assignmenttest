import 'package:assignmenttest/utils/constants/colors.dart';
import 'package:assignmenttest/utils/constants/sizes.dart';
import 'package:assignmenttest/utils/constants/text_strings.dart';
import 'package:flutter/material.dart';
import '../widgets/category_widget.dart';
import '../widgets/custom_appbar.dart';
import '../widgets/recently_ordered_widget.dart';
import '../widgets/image_banner_widget.dart';
import '../widgets/miniCartNudge.dart';
import '../widgets/search_bar.dart';
import '../widgets/vertical_product_list.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: MyTexts.appName,
        onLogoutPressed: () {
          debugPrint('Logout pressed');
        },
      ),
      body: SingleChildScrollView(
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
              const ProductList(), // Remove Expanded here
            ],
          ),
        ),
      ),
      bottomNavigationBar: const MiniCartNudge(),
    );
  }
}
