import 'package:flutter/material.dart';

class ProductDetail extends StatefulWidget {
  final String productId;

  ProductDetail({this.productId});

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Price Detail"),
      ),
      body: Text(widget.productId),
    );
  }
}
