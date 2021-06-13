import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:price_tracker/Forms/frmDetail.dart';
import 'package:price_tracker/Models/Product.dart';

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
    var url = Uri.parse('http://price.botsepeti.net/api.php');
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

      return Scaffold(
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            GetAllPrices();
          },
          label: Text("Yenile"),
          icon: Icon(Icons.refresh),
        ),
        body: Column(
          children: [
            Padding(
                padding: EdgeInsets.all(5),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "BÜYÜK/küçük harflere duyarlı değildir",
                      labelText: "Ürün Adı",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(8),
                        ),
                      ),
                    ),
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
                  ),
                )),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
                child: Scrollbar(
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
                                          product: displayList == null
                                              ? productList[index]
                                              : displayList[index],
                                        )));
                          },
                          child: Card(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Ürün Kodu",
                                    style: TextStyle(color: Colors.redAccent),
                                  ),
                                  Text(
                                    displayList == null
                                        ? productList[index].productId
                                        : displayList[index].productId,
                                  ),
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
                                        ? productList[index]
                                            .discountedPrice
                                            .toString()
                                        : displayList[index]
                                            .discountedPrice
                                            .toString(),
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
                                                : displayList[index]
                                                    .productUri))
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                ),
              ),
            ),
          ],
        ),
      );
    }
  }
}
