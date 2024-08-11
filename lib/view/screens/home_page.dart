import 'package:flutter/material.dart';
import '../widgets/category_list.dart';
import '../widgets/image_banner.dart';
import '../widgets/search_bar.dart';


class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        leading: const Padding(
          padding: EdgeInsets.all(16.0),
          child: Icon(Icons.person, color: Colors.white),
        ),
        centerTitle: true,
        title: const Text('Shoppido',
          style: TextStyle(
            fontSize: 16,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Icon(Icons.logout, color: Colors.white),
          ),
        ],
      ),
      body:  Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search Bar
            searchBar(),
            const SizedBox(height: 16),
            // Image Banners
            const ImageBannerList(),
            const SizedBox(height: 16),
            // Category List
            const CategoryList(),
            const SizedBox(height: 16),
            // // Horizontal Products List

          ],
        ),
      ),
    );
  }
}
