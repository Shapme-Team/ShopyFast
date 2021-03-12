import 'package:ShopyFast/domain/models/Product.dart';
import 'package:ShopyFast/domain/models/order.dart';
import 'package:ShopyFast/domain/provider/orderProvider.dart';
import 'package:ShopyFast/domain/provider/productProvider.dart';
import 'package:ShopyFast/view/components/shimmers/verticalProductShimmer.dart';
import 'package:ShopyFast/view/screens/home/components/productSnapcard.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../getit.dart';
import 'category_type_header.dart';

class OrderSnapWidget extends StatefulWidget {
  @override
  _OrderSnapWidgetState createState() => _OrderSnapWidgetState();
}

class _OrderSnapWidgetState extends State<OrderSnapWidget> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getIt<OrderProvider>().fetchOrders(fetchProductsAlso: true),
        // future: Future.delayed(Duration(seconds: 500)),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Row(
                // mainAxisAlignment: MainA,
                children: [VerticalProductShimmer()]);
          } else
            return buildOrderProducts();
        });
  }

  Widget buildOrderProducts() {
    return Consumer<OrderProvider>(builder: (context, value, _) {
      // var orders = value.getListOfOrders;
      // var products = orderOrders(orders);
      var products = value.getListOfAllSortProduct;
      // print('listof products : $products');

      return products.length > 0
          ? Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Column(
                children: [
                  CategoryTypeHeader('Recent Orders'),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: IntrinsicHeight(
                      child: Row(
                        children: [
                          ...List.generate(
                            products.length,
                            (index) {
                              return ProductSnapCard(products[index]);
                            },
                          ),
                          // SizedBox(width: getWidth(20)),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            )
          : VerticalProductShimmer();
    });
  }
}
