import 'package:flutter/material.dart';

import 'Forms/frmDetail.dart';
import 'Forms/frmPrices.dart';

void main() {
  runApp(PriceTracker());
}

class PriceTracker extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _PriceTrackerState createState() => _PriceTrackerState();
}

class _PriceTrackerState extends State<PriceTracker> {
  int selectedTab = 0;
  List<Widget> pages = [PricesPage(), Text("Ayarlar")];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Price Tracking Mobile',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Scaffold(
          appBar: AppBar(
            title: Text("Price Tracker"),
          ),
          body: pages[selectedTab],
          bottomNavigationBar: BottomNavigationBar(
            onTap: changedNavigationBar,
            currentIndex: selectedTab,
            items: [
              BottomNavigationBarItem(label: "History", icon: Icon(Icons.home)),
              BottomNavigationBarItem(
                  label: "Ayarlar", icon: Icon(Icons.settings)),
            ],
          ),
        ));
  }

  void changedNavigationBar(int value) {
    setState(() {
      selectedTab = value;
    });
  }
}
