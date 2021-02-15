import 'package:ShopyFast/view/screens/categoryDetailScreen/components/subProductWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../domain/models/Product.dart';
import '../../../../utils/constants/constants.dart';
import '../../../../utils/constants/size_config.dart';

class CartProducts extends StatefulWidget {
  final List<Product> cartProducts;
  CartProducts(this.cartProducts);
  @override
  _CartProductsState createState() => _CartProductsState();
}

class _CartProductsState extends State<CartProducts> {
  @override
  Widget build(BuildContext context) {
    var products = widget.cartProducts;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: getWidth(20)),
      child: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) => Padding(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: Dismissible(
            key: Key(products[index].productId.toString()),
            direction: DismissDirection.endToStart,
            onDismissed: (direction) {},
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

class CartCard extends StatelessWidget {
  final Product product;
  CartCard(this.product);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 88,
          child: AspectRatio(
            aspectRatio: 0.88,
          ),
        ),
        SizedBox(width: 20),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10),
            Text.rich(
              TextSpan(
                text: '₹ ${product.price}',
                style: TextStyle(
                    fontWeight: FontWeight.w600, color: kPrimaryColor),
                children: [
                  TextSpan(
                      text: "", style: Theme.of(context).textTheme.bodyText1),
                ],
              ),
            )
          ],
        )
      ],
    );
  }
}
