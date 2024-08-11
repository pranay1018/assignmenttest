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

class ProductModel {
  final String imageUrl;
  final String name;
  final String weight;
  final String price;

  ProductModel({
    required this.imageUrl,
    required this.name,
    required this.weight,
    required this.price,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      imageUrl: json['image_url'],
      name: json['name'],
      weight: json['weight'],
      price: json['price'],
    );
  }
}


class VerticalProductModel {
  final String imageUrl;
  final String name;
  final String weight;
  final String price;

  VerticalProductModel({
    required this.imageUrl,
    required this.name,
    required this.weight,
    required this.price,
  });

  factory VerticalProductModel.fromJson(Map<String, dynamic> json) {
    return VerticalProductModel(
      imageUrl: json['image_url'],
      name: json['name'],
      weight: json['weight'],
      price: json['price'],
    );
  }
}



