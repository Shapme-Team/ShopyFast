import 'package:ShopyFast/domain/models/Product.dart';
import 'package:ShopyFast/view/screens/checkout/components/productOrderWidget.dart';
import 'package:flutter/material.dart';

class OrderProductsWidget extends StatelessWidget {
  final List<Product> listOfProducts;
  OrderProductsWidget(this.listOfProducts);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      margin: EdgeInsets.only(bottom: 12),
      decoration:
          BoxDecoration(color: Colors.blueGrey.shade100.withOpacity(.3)),
      child: Column(
        children: listOfProducts.map((e) => ProductItemWidget(e)).toList(),
      ),
    );
  }
}
