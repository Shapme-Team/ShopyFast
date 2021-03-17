import 'package:ShopyFast/domain/models/order.dart';
import 'package:ShopyFast/domain/provider/authprovider.dart';
import 'package:ShopyFast/domain/provider/cartProvider.dart';
import 'package:ShopyFast/domain/provider/productProvider.dart';
import 'package:ShopyFast/getit.dart';
import 'package:ShopyFast/view/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
        var cart = Provider.of<CartProvider>(context).getCart;
        var cartCheck = cart != null && cart.product.length > 0;
        var customerData = getIt<AuthProvider>().getCustomer;

        Map<String, int> mapOfProductIds = {};
        cart.product.forEach((e) => mapOfProductIds[e.productId] = e.quantity);

        var order = Order(
          amount: cart.amount,
          customer: customerData,
          deliveryStatus: 'PROCESSING',
          productsIds: mapOfProductIds,
          customerId: customerData?.customerId,
        );
        return SizedBox(
          child: Scaffold(
            appBar: buildAppBar(context),
            body: cartCheck ? CartProducts(cart.product) : buildNoItemWidget(),
            bottomNavigationBar:
                cartCheck ? CheckoutCard(order, cart.product) : SizedBox(),
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

  Widget buildNoItemWidget() => Center(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.cleaning_services,
              size: 32,
              color: Theme.of(context).accentColor,
            ),
            Padding(
              padding: EdgeInsets.all(8),
              child: Text(
                'no item in cart',
                style: TextStyle(
                    fontSize: 18, color: Theme.of(context).accentColor),
              ),
            ),
            ElevatedButton(
              child: Text(
                'continue shoping',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ],
        ),
      );
}
