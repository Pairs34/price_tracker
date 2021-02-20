import 'package:flutter/material.dart';
import 'package:price_tracker/Models/DrawerModel.dart';

class CustomDrawer extends StatelessWidget {

  List<CompanyModel> companies = List<CompanyModel>(5);

  CustomDrawer() {
    this.companies.add(
        CompanyModel("assets/images/company/hb.png", "Hepsiburada"));
    this.companies.add(
        CompanyModel("assets/images/company/hb.png", "Gittigidiyor"));
    this.companies.add(
        CompanyModel("assets/images/company/hb.png", "Trendyol"));
    this.companies.add(CompanyModel("assets/images/company/hb.png", "MM"));
    this.companies.add(CompanyModel("assets/images/company/hb.png", "N11"));
    this.companies.add(CompanyModel("assets/images/company/hb.png", "Teknosa"));
    this.companies.add(CompanyModel("assets/images/company/hb.png", "A101"));
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      semanticLabel: "Drawer Left",
      child: CustomScrollView(
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.deepPurple,
            floating: true,
            flexibleSpace: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image(
                image: AssetImage("assets/images/price-logo.png"),
              ),
            ),
            expandedHeight: 200,
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
                  (context, index) {
                return TextButton(
                  child: ListTile(
                    leading: SizedBox(
                      width: 48,
                      height: 48,
                      child: Image(
                        image: AssetImage(this.companies[index].companyImage),
                      ),
                    ),
                    title: Text(this.companies[index].companyName),
                  ),
                );
              },
              childCount: companies.length,
            ),
          ),
        ],
      ),
    );
  }
}
