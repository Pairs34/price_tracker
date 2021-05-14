class ProductHistoryModel {
  double discountedPrice;
  String created_at;

  ProductHistoryModel({this.discountedPrice, this.created_at});

  factory ProductHistoryModel.fromJson(Map<String, dynamic> json) {
    return ProductHistoryModel(
        discountedPrice: double.parse(json["price"]),
        created_at: json["created_at"]);
  }
}
