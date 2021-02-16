import 'package:ShopyFast/domain/provider/cartProvider.dart';
import 'package:ShopyFast/view/screens/categoryDetailScreen/components/subProductWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

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
          child: Dismissible(
            key: Key(products[index].productId.toString()),
            direction: DismissDirection.endToStart,
            onDismissed: (direction) {
              Provider.of<CartProvider>(context, listen: false)
                  .directRemoveFromCart(products[index]);
            },
            background: Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: Color(0xFFFFE6E6),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Row(
                children: [
                  Spacer(),
                  SvgPicture.asset("assets/icons/Trash.svg"),
                ],
              ),
            ),
            child: SubProductWidget(products[index]),
          ),
        ),
      ),
    );
  }
}
