import 'dart:convert';

class ProductModel {
  int id;
  String name;
  String imageUrl;
  String brandName;
  String packageName;
  int price;
  double rating;

  ProductModel({
    this.id,
    this.name,
    this.imageUrl,
    this.brandName,
    this.packageName,
    this.price,
    this.rating
  });

factory ProductModel.fromJson(Map<String, dynamic> map) {
    return ProductModel(
      id: map["id"],
      name: map["name"],
      imageUrl: map["image_url"],
      brandName: map["brand_name"],
      packageName: map["package_name"],
      price: map["price"],
      rating: map["rating"]
    );
  }

  @override
  String toString() {
    return '{id: $id, name:$name, imageUrl:$imageUrl, brandName:$brandName, packageName:$packageName, price:$price, rating:$rating}';
  }
}

List<ProductModel> productFromJson(String jsonData) {
  final data = json.decode(jsonData);
  return List<ProductModel>.from(data.map((item) => ProductModel.fromJson(item)));
}
