import 'dart:convert';

class ProductModel {
  int id;
  String name;
  String imageUrl;
  String brandName;
  String packageName;
  int price;
  double rating;
  int quantity;
  DateTime orderDate;

  ProductModel({
    this.id,
    this.name,
    this.imageUrl,
    this.brandName,
    this.packageName,
    this.price,
    this.rating,
    this.quantity,
    this.orderDate
  });

  factory ProductModel.fromJson(Map<String, dynamic> map) {
    return ProductModel(
      id: map["id"],
      name: map["name"],
      imageUrl: map["image_url"],
      brandName: map["brand_name"],
      packageName: map["package_name"],
      price: map["price"],
      rating: map["rating"],
      quantity: map["quantity"] == null ? 0 : map["quantity"],
      orderDate: map["order_date"] == null ? map["order_date"] : DateTime.parse(map["order_date"])
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name" : name,
      "image_url" : imageUrl,
      "brand_name": brandName,
      "package_name": packageName,
      "price": price,
      "rating": rating,
      "quantity": quantity,
      "order_date":orderDate.toIso8601String()
    };
  }

  @override
  String toString() {
    return '{id: $id, name:$name, quantity:$quantity, imageUrl:$imageUrl, brandName:$brandName, packageName:$packageName, price:$price, rating:$rating}';
  }
}

List<ProductModel> productFromJson(String jsonData) {
  final data = json.decode(jsonData);
  return List<ProductModel>.from(data.map((item) => ProductModel.fromJson(item)));
}

String productToJson(ProductModel data) {
  final jsonData = data.toJson();
  return json.encode(jsonData);
}
