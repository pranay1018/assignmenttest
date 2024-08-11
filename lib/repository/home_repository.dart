import 'dart:convert';
import 'package:flutter/services.dart';

import '../models/porduct.dart';

class HomeRepository {
  Future<List<ProductModel>> fetchHorizontalProducts() async {
    await Future.delayed(const Duration(seconds: 5)); // Simulate a 5-second delay
    final String response = await rootBundle.loadString('assets/dummyData.json');
    final data = json.decode(response);
    final productsJson = data['horizontal_products'] as List<dynamic>;

    return productsJson.map((json) => ProductModel.fromJson(json)).toList();
  }

  Future<List<CategoryModel>> fetchCategories() async {
    await Future.delayed(const Duration(seconds: 5)); // Simulate a 5-second delay
    final String response = await rootBundle.loadString('assets/dummyData.json');
    final data = json.decode(response);
    final categoriesJson = data['categories'] as List<dynamic>;

    return categoriesJson.map((json) => CategoryModel.fromJson(json)).toList();
  }

  Future<List<VerticalProductModel>> fetchVerticalProducts() async {
    await Future.delayed(const Duration(seconds: 5)); // Simulate a 5-second delay
    final String response = await rootBundle.loadString('assets/dummyData.json');
    final data = json.decode(response);
    final productsJson = data['vertical_products'] as List<dynamic>;

    return productsJson.map((json) => VerticalProductModel.fromJson(json)).toList();
  }

  Future<List<BannerModel>> fetchBanners() async {
    await Future.delayed(const Duration(seconds: 5)); // Simulate a 5-second delay
    final String response = await rootBundle.loadString('assets/dummyData.json');
    final data = json.decode(response);
    final bannersJson = data['banners'] as List<dynamic>;

    return bannersJson.map((json) => BannerModel.fromJson(json)).toList();
  }
}
