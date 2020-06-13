import 'dart:convert';
import 'package:baby_220fa3cd9a07183fa6e7d8f5082f21c4dcffa74f/model/product.dart';

class CartModel{
  int totalPrice;
  int totalItem;
  List<ProductModel> products;

  CartModel({
    this.totalPrice,
    this.totalItem,
    this.products
  });

  @override
  String toString() {
    return '${this.totalPrice}, ${this.totalItem}, {$products}';
  }

  factory CartModel.fromJson(Map<String, dynamic> json) {
    return CartModel(
      totalPrice: json["total_price"],
      totalItem: json["total_item"],
      products: List<ProductModel>.from(json["products_list"].map((product) {
        return ProductModel.fromJson(product);
      }))
    );
  }

  Map<String,dynamic> toJson(){
    return {
      "total_price": totalPrice,
      "total_item": totalItem,
      "products_list": products
    };
  }
}

CartModel cartFromJson(String jsonData) {
  final data = json.decode(jsonData);
  return CartModel.fromJson(data);
}

String cartToJson(CartModel data) {
  final jsonData = data.toJson();
  return json.encode(jsonData);
}
