import 'dart:convert';
import 'package:flutter/services.dart';

import '../models/models.dart';

class HomeRepository {
  Future<List<ProductModel>> fetchRecentlyOrderedProducts() async {
    await Future.delayed(const Duration(seconds: 5)); // Simulate a 5-second delay
    final String response = await rootBundle.loadString('assets/dummyData.json');
    final data = json.decode(response);
    final productsJson = data['recently_ordered'] as List<dynamic>;

    return productsJson.map((json) => ProductModel.fromJson(json)).toList();
  }

  Future<List<CategoryModel>> fetchCategories() async {
    await Future.delayed(const Duration(seconds: 5)); // Simulate a 5-second delay
    final String response = await rootBundle.loadString('assets/dummyData.json');
    final data = json.decode(response);
    final categoriesJson = data['categories'] as List<dynamic>;

    return categoriesJson.map((json) => CategoryModel.fromJson(json)).toList();
  }

  Future<List<ProductModel>> fetchProducts() async {
    await Future.delayed(const Duration(seconds: 5)); // Simulate a 5-second delay
    final String response = await rootBundle.loadString('assets/dummyData.json');
    final data = json.decode(response);
    final productsJson = data['products'] as List<dynamic>;

    return productsJson.map((json) => ProductModel.fromJson(json)).toList();
  }

  Future<List<BannerModel>> fetchBanners() async {
    await Future.delayed(const Duration(seconds: 5)); // Simulate a 5-second delay
    final String response = await rootBundle.loadString('assets/dummyData.json');
    final data = json.decode(response);
    final bannersJson = data['banners'] as List<dynamic>;

    return bannersJson.map((json) => BannerModel.fromJson(json)).toList();
  }
  Future<ProductModel> fetchProductDetails(int productId) async {
    await Future.delayed(const Duration(seconds: 5)); // Simulate a 5-second delay
    final String response = await rootBundle.loadString('assets/dummyData.json');
    final data = json.decode(response);
    final List<dynamic> productList = data['product_detail'];
    final productJson = productList.firstWhere(
            (product) => product['id'] == productId,
        orElse: () => throw Exception('Product not found')
    );

    return ProductModel.fromJson(productJson);
  }
}
