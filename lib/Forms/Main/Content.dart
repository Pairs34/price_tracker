import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      semanticLabel: "Drawer Left",
      child: SafeArea(
        child: Column(
          children: <Widget>[
            Image(
              image: AssetImage("assets/images/price-logo.png"),
            ),
            Card(
              child: ListView.builder(
                itemCount: 10,
                itemBuilder: (BuildContext context, int index) {
                  return Text("Item $index");
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
