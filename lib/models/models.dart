//HomeScreen Models class

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
  final int id;
  final String imageUrl;
  final String name;
  final String weight;
  final String price;
  final String description;

  ProductModel({
    required this.id,
    required this.imageUrl,
    required this.name,
    required this.weight,
    required this.price,
    required this.description,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      imageUrl: json['image_url'],
      name: json['name'],
      weight: json['weight'],
      price: json['price'],
      description: json['description'],
    );
  }


}



