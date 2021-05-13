import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:price_tracker/Forms/frmDetail.dart';
import 'package:price_tracker/Models/Product.dart';
import 'package:search_widget/search_widget.dart';

class PricesPage extends StatefulWidget {
  @override
  State<PricesPage> createState() => _PricesPageState();
}

class _PricesPageState extends State<PricesPage> {
  var priceJson = "";
  List<ProductModel> productList;
  List<ProductModel> displayList;

  List<ProductModel> parseProducts(String responseBody) {
    final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

    return parsed
        .map<ProductModel>((json) => ProductModel.fromJson(json))
        .toList();
  }

  void GetAllPrices() {
    var url = Uri.parse('http://185.242.160.147/mysqlcon.php');
    http.post(url, body: {'action': 'list_price'}).then((value) => {
          if (value.statusCode == 200)
            {
              setState(() {
                productList = parseProducts(value.body);
              })
            }
          else
            {
              setState(() {
                productList = null;
              })
            }
        });
  }

  @override
  void initState() {
    super.initState();

    GetAllPrices();
  }

  @override
  Widget build(BuildContext context) {
    if (productList == null) {
      return Text("NO_DATA");
    } else {
      //displayList = productList;

      return Column(
        children: [
          Padding(
              padding: EdgeInsets.all(5),
              child: TextField(
                decoration: InputDecoration(hintText: "Ürün ara"),
                onChanged: (value) {
                  value = value.toLowerCase();
                  print(value);
                  setState(() {
                    displayList = productList.where((element) {
                      var productTitle = element.title.toLowerCase();
                      return productTitle.contains(value);
                    }).toList();
                  });
                },
              )),
          Expanded(
            child: ListView.builder(
                shrinkWrap: true,
                itemCount: displayList == null
                    ? productList.length
                    : displayList.length,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ProductDetail(
                                    productId: displayList == null
                                        ? productList[index].productId
                                        : displayList[index].productId,
                                  )));
                    },
                    child: Card(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Ürün Adı",
                            style: TextStyle(color: Colors.redAccent),
                          ),
                          Text(displayList == null
                              ? productList[index].title
                              : displayList[index].title),
                          Text(
                            "Satıcı",
                            style: TextStyle(color: Colors.redAccent),
                          ),
                          Text(displayList == null
                              ? productList[index].seller
                              : displayList[index].seller),
                          Text(
                            "Ürün Fiyatı",
                            style: TextStyle(color: Colors.redAccent),
                          ),
                          Text(
                            displayList == null
                                ? productList[index].discountedPrice
                                : displayList[index].discountedPrice,
                            style: TextStyle(color: Colors.blue),
                          ),
                          Text(
                            "Ürün Linki",
                            style: TextStyle(color: Colors.redAccent),
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(0, 0, 5, 0),
                            child: Row(
                              children: [
                                Expanded(
                                    child: Text(displayList == null
                                        ? productList[index].productUri
                                        : displayList[index].productUri))
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                }),
          ),
        ],
      );
    }
  }
}
