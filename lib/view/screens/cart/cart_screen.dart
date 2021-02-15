import 'package:ShopyFast/domain/provider/cartProvider.dart';
import 'package:ShopyFast/domain/provider/productProvider.dart';
import 'package:ShopyFast/getit.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../domain/models/Cart.dart';

import 'components/cartProducts.dart';
import 'components/check_out_card.dart';

class CartScreen extends StatefulWidget {
  static String routeName = "/cart";

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: getIt<CartProvider>(),
        ),
        ChangeNotifierProvider.value(value: getIt<ProductProvider>())
      ],
      builder: (context, child) {
        var cart = Provider.of<CartProvider>(context).getCartItems;
        return SizedBox(
          child: Scaffold(
            appBar: buildAppBar(context),
            body: CartProducts(cart.product),
            bottomNavigationBar: CheckoutCard(cart.amount),
          ),
        );
      },
    );
  }

  AppBar buildAppBar(BuildContext context) {
    var cartItems = Provider.of<CartProvider>(context).getNoOfItemsInCart;
    return AppBar(
      title: Text(
        "Your Cart",
        style: TextStyle(color: Colors.black),
      ),
      actions: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 8),
          alignment: Alignment.center,
          child: Text(
            '$cartItems Items',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        )
      ],
    );
  }
}
