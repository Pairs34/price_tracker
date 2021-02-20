import 'package:flutter/material.dart';
import 'package:price_tracker/Forms/Main/Content.dart';

void main() {
  runApp(PriceTracker());
}

class PriceTracker extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _PriceTrackerState createState() => _PriceTrackerState();
}

class _PriceTrackerState extends State<PriceTracker> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text("Price Tracker"),
        ),
        drawer: CustomDrawer(),

      )
    );
  }
}
