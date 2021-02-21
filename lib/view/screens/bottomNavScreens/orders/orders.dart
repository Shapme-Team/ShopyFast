import 'package:ShopyFast/view/screens/SearchScreen/searchScreen.dart';
import 'package:flutter/material.dart';
import 'package:ShopyFast/view/screens/cart/cart_screen.dart';
//import 'components/body.dart';

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
        actions: [
          IconButton(
              icon: Icon(
                Icons.search,
                color: Colors.grey,
              ),
              onPressed: () =>
                  Navigator.pushNamed(context, SearchScreen.routeName)),
          IconButton(
            color: Colors.grey,
            icon: Icon(Icons.shopping_cart_outlined),
            onPressed: () => Navigator.pushNamed(context, CartScreen.routeName),
          ),
        ],
      ),
      body: OrdersScreen(),
      // bottomNavigationBar: CustomBottomNavBar(selectedMenu: MenuState.orders),
    );
  }
}
