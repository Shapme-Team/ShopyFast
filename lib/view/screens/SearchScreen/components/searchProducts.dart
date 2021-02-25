import 'package:ShopyFast/view/screens/categoryDetailScreen/components/subProductWidget.dart';
import 'package:flutter/material.dart';

import '../../../../domain/models/Product.dart';
import '../../../../utils/constants/size_config.dart';

class SearchProducts extends StatefulWidget {
  final List<Product> searchProducts;
  SearchProducts(this.searchProducts);
  @override
  _SearchProductsState createState() => _SearchProductsState();
}

class _SearchProductsState extends State<SearchProducts> {
  @override
  Widget build(BuildContext context) {
    var products = widget.searchProducts;
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: getWidth(20)),
        child: ListView.builder(
          itemCount: products.length,
          itemBuilder: (context, index) => Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: SubProductWidget(products[index]),
          ),
        ));
  }
}
