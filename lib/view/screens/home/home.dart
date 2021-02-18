import 'package:ShopyFast/domain/provider/cartProvider.dart';
import 'package:ShopyFast/domain/provider/productProvider.dart';
import 'package:ShopyFast/utils/constants/size_config.dart';
import 'package:ShopyFast/view/screens/cart/cart_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../getit.dart';
import 'components/categories_main.dart';
import 'components/popular_product.dart';

class HomeScreen extends StatefulWidget {
  final User user;

  HomeScreen({this.user});
  static String routeName = "/home";

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var cartValue = 10;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: getIt<CartProvider>(),
      builder: (context, child) {
        return Scaffold(
            appBar: buildAppBar(context),
            body: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CategoriesMain(),
                  SizedBox(height: getWidth(30)),
                  PopularProducts(),
                  SizedBox(height: getWidth(30)),
                ],
              ),
            ));
      },
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      elevation: 1,
      title: Text(
        'ShopyFast',
        style: TextStyle(
          color: Theme.of(context).primaryColor,
          fontSize: 23,
          fontWeight: FontWeight.w600,
        ),
      ),
      actions: [
        IconButton(
          onPressed: () {},
          iconSize: 28,
          icon: Icon(Icons.search, color: Colors.grey),
        ),
        Consumer<CartProvider>(
          builder: (context, value, child) {
            var noOfCartItems = value.getNoOfItemsInCart;
            Provider.of<ProductProvider>(context, listen: false)
                .initCartItems(value.getCartItems);
            return Stack(
              children: [
                IconButton(
                  color: noOfCartItems > 0
                      ? Theme.of(context).primaryColor
                      : Colors.grey,
                  iconSize: 28,
                  icon: Icon(Icons.shopping_cart_outlined),
                  onPressed: () =>
                      Navigator.pushNamed(context, CartScreen.routeName),
                ),
                noOfCartItems > 0
                    ? Positioned(
                        top: 4,
                        right: 4,
                        child: Container(
                            padding: EdgeInsets.all(noOfCartItems > 9 ? 2 : 4),
                            decoration: BoxDecoration(
                              color: Theme.of(context).primaryColor,
                              shape: BoxShape.circle,
                            ),
                            child: Text(
                              noOfCartItems.toString(),
                              style: TextStyle(color: Colors.white),
                            )),
                      )
                    : SizedBox(),
              ],
            );
          },
        ),
      ],
    );
  }
}
