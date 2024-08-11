import 'package:flutter/material.dart';
import '../../utils/string_constants.dart';
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
        title: appTitle,
        onLogoutPressed: () {
          print('Logout pressed');
        },
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.red.withOpacity(0.2),
          padding: const EdgeInsets.all(defaultPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              searchBarWidget(),
              const SizedBox(height: spacing),
              const ImageBannerList(),
              const SizedBox(height: spacing),
              const CategoryWidget(),
              const SizedBox(height: spacing),
              const RecentlyOrderedWidget(),
              const SizedBox(height: spacing),
              const VerticalProductList(), // Remove Expanded here
            ],
          ),
        ),
      ),
      bottomNavigationBar: const MiniCartNudge(), // Add MiniCartNudge to HomePage
    );
  }
}
