class BannerModel {
  final String imageUrl;

  BannerModel({required this.imageUrl});

  factory BannerModel.fromJson(Map<String, dynamic> json) {
    return BannerModel(
      imageUrl: json['image_url'],
    );
  }
}

class CategoryModel {
  final String imageUrl;
  final String name;

  CategoryModel({required this.imageUrl, required this.name});

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      imageUrl: json['image_url'],
      name: json['name'],
    );
  }
}

