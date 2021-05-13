import 'package:flutter/foundation.dart';

class ProductModel {
  String id;
  String productUri;
  String originalPrice;
  String discountedPrice;
  String sellingPrice;
  String seller;
  String company;
  String productId;
  String title;

  ProductModel(
      {this.id,
      this.productUri,
      this.originalPrice,
      this.discountedPrice,
      this.sellingPrice,
      this.seller,
      this.company,
      this.productId,
      this.title});

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json["id"],
      productUri: json["productUri"],
      originalPrice: json["originalPrice"],
      discountedPrice: json["discountedPrice"],
      sellingPrice: json["sellingPrice"],
      seller: json["seller"],
      company: json["company"],
      productId: json["productId"],
      title: json["title"],
    );
  }
}
