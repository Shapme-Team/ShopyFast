import 'package:flutter/material.dart';
import 'package:ShopyFast/view/screens/cart/cart_screen.dart';
import 'components/body.dart';

class OrdersScreen extends StatelessWidget {
  static const String routeName = "/orders";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        title: Text(
          'Orders',
          style: TextStyle(
            color: Theme.of(context).primaryColor,
            fontSize: 23,
            fontWeight: FontWeight.w600,
          ),
        ),
        leading: Icon(Icons.menu),
        actions: [
          Icon(
            Icons.search,
            color: Colors.grey,
          ),
          IconButton(
            color: Colors.grey,
            icon: Icon(Icons.shopping_cart_outlined),
            onPressed: () => Navigator.pushNamed(context, CartScreen.routeName),
          ),
        ],
      ),
      body: Body(),
      // bottomNavigationBar: CustomBottomNavBar(selectedMenu: MenuState.orders),
    );
  }
}
