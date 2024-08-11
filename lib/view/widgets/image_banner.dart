import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../models/porduct.dart';

class ImageBannerList extends StatefulWidget {
  const ImageBannerList({super.key});

  @override
  _ImageBannerListState createState() => _ImageBannerListState();
}

class _ImageBannerListState extends State<ImageBannerList> {
  late Future<List<BannerModel>> _bannersFuture;

  @override
  void initState() {
    super.initState();
    _bannersFuture = _fetchBanners();
  }

  Future<List<BannerModel>> _fetchBanners() async {
    await Future.delayed(const Duration(seconds: 5)); // Simulate a 5-second delay

    // Load the JSON from the local asset
    final String response = await rootBundle.loadString('assets/dummyData.json');
    final data = json.decode(response);
    final bannersJson = data['banners'] as List<dynamic>;

    return bannersJson.map((json) => BannerModel.fromJson(json)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<BannerModel>>(
      future: _bannersFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No banners available'));
        } else {
          final banners = snapshot.data!;

          return SizedBox(
            height: 200,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: banners.map((banner) => buildBanner(banner.imageUrl)).toList(),
            ),
          );
        }
      },
    );
  }

  Widget buildBanner(String imageUrl) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: Container(
        width: 300,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(imageUrl),
            fit: BoxFit.cover,
          ),
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
    );
  }
}
