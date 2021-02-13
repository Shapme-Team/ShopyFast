import 'package:flutter/material.dart';

class CategoriesScreen extends StatelessWidget {
  static const String routeName = "/categories";
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Categories"),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              // SizedBox(height: getProportionateScreenHeight(20)),
              //  HomeHeader(),
              // SizedBox(height: getProportionateScreenWidth(10)),
              // DiscountBanner(),
              // Categories(),
              // SpecialOffers(),
              // SizedBox(height: getProportionateScreenWidth(30)),
              // PopularProducts(),
              // SizedBox(height: getProportionateScreenWidth(30)),
            ],
          ),
        ),
      ),
    );
  }
}
