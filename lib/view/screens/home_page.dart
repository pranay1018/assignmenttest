import 'package:assignmenttest/view/widgets/category_widget.dart';
import 'package:assignmenttest/view/widgets/horizontal_product_list_widget.dart';
import 'package:flutter/material.dart';
import '../../utils/string_constants.dart';
import '../widgets/image_banner_widget.dart';
import '../widgets/search_bar.dart';
import '../widgets/vertical_product_list.dart';
import '../widgets/custom_appbar.dart';

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
              const HorizontalProductListWidget(),
              const SizedBox(height: spacing),
              const VerticalProductList(), // Remove Expanded here
            ],
          ),
        ),
      ),
    );
  }
}
