import 'dart:convert';
import 'dart:ffi';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:price_tracker/Models/Product.dart';
import 'package:price_tracker/Models/ProductHistory.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:http/http.dart' as http;

class ProductDetail extends StatefulWidget {
  final ProductModel product;

  ProductDetail({this.product});

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  List<ProductHistoryModel> productHistoryList;
  TooltipBehavior _tooltipBehavior;
  ZoomPanBehavior _zoomPanBehavior;
  TrackballBehavior _trackballBehavior;
  List<ProductHistoryModel> parseProducts(String responseBody) {
    final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

    return parsed
        .map<ProductHistoryModel>((json) => ProductHistoryModel.fromJson(json))
        .toList();
  }

  void GetAllPrices() {
    var url = Uri.parse('http://185.242.160.147/mysqlcon.php');
    http.post(url, body: {
      'action': 'get_detail',
      'productId': widget.product.productId
    }).then((value) => {
          if (value.statusCode == 200)
            {
              setState(() {
                productHistoryList = parseProducts(value.body);
                print(productHistoryList);
              })
            }
          else
            {
              setState(() {
                productHistoryList = null;
              })
            }
        });
  }

  @override
  void initState() {
    super.initState();
    _zoomPanBehavior = ZoomPanBehavior(
      enableDoubleTapZooming: true,
      enablePinching: true,
      enablePanning: true,
    );
    _trackballBehavior = TrackballBehavior(
        // Enables the trackball
        enable: true,
        tooltipDisplayMode: TrackballDisplayMode.floatAllPoints,
        tooltipSettings: InteractiveTooltip(enable: true, color: Colors.red));
    _tooltipBehavior = TooltipBehavior(
        enable: true,
        borderColor: Colors.red,
        borderWidth: 5,
        color: Colors.lightBlue);
    GetAllPrices();
  }

  @override
  Widget build(BuildContext context) {
    final List<Color> color = <Color>[];
    color.add(Colors.blue[50]);
    color.add(Colors.blue[200]);
    color.add(Colors.blue);

    final List<double> stops = <double>[];
    stops.add(0.0);
    stops.add(0.5);
    stops.add(1.0);

    final LinearGradient gradientColors =
        LinearGradient(colors: color, stops: stops);

    return Scaffold(
      appBar: AppBar(
        title: Text("Price Detail"),
      ),
      body: Container(
          child: SfCartesianChart(
        title: ChartTitle(text: widget.product.title),
        tooltipBehavior: _tooltipBehavior,
        /*primaryYAxis: NumericAxis(
          anchorRangeToVisiblePoints: false,
          autoScrollingMode: AutoScrollingMode.start,
          minimum: productHistoryList != null
              ? productHistoryList.map((e) => e.discountedPrice).reduce(min)
              : 0,
          maximum: productHistoryList != null
              ? productHistoryList.map((e) => e.discountedPrice).reduce(max)
              : 20000,
        ),*/
        primaryXAxis: CategoryAxis(),
        zoomPanBehavior: _zoomPanBehavior,
        series: <ChartSeries>[
          StackedLineSeries<ProductHistoryModel, String>(
            dataSource: productHistoryList,
            yValueMapper: (ProductHistoryModel product, _) =>
                product.discountedPrice,
            xValueMapper: (ProductHistoryModel product, _) =>
                product.created_at,
            dataLabelSettings: DataLabelSettings(
                isVisible: true,
                showCumulativeValues: true,
                useSeriesColor: true),
          )
        ],
      )),
    );
  }
}
