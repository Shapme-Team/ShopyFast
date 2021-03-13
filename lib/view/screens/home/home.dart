import 'package:ShopyFast/domain/provider/orderProvider.dart';
import 'package:ShopyFast/domain/provider/screenRouteProvider.dart';
import 'package:ShopyFast/view/screens/home/components/ordersSnap.dart';
import 'package:ShopyFast/view/screens/home/components/productSnaps.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../data/core/apiConstant.dart';
import '../../../domain/provider/cartProvider.dart';
import '../../../domain/provider/productProvider.dart';
import '../../../getit.dart';
import '../../../utils/constants/size_config.dart';
import '../SearchScreen/searchScreen.dart';
import '../cart/cart_screen.dart';
import 'components/categories_main.dart';

class HomeScreen extends StatefulWidget {
  final User user;

  HomeScreen({this.user});
  static const String routeName = "/home";

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final socketUrl = ApiConstants.BASE_URL;
  var cartValue = 10;
  CartProvider _cartProvider;

  @override
  void initState() {
    _cartProvider = getIt<CartProvider>();
    Provider.of<ProductProvider>(context, listen: false).initCartItems =
        _cartProvider.getCartItems;
    getIt<OrderProvider>().setSocket();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: buildAppBar(context),
        backgroundColor: Theme.of(context).backgroundColor,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CategoriesMain(),
                SizedBox(height: getWidth(30)),
                ProductSnaps2(),
                // OrderSnapWidget()
              ],
            ),
          ),
        ));
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      elevation: 1,
      leading: Container(
          padding: EdgeInsets.only(left: 8, top: 8, bottom: 8),
          child: Image.asset('assets/images/full_logo.png')),
      title: Text(
        'ShopyFast',
        style: TextStyle(
          color: Theme.of(context).primaryColor,
          fontSize: 22,
          fontWeight: FontWeight.w600,
        ),
      ),
      actions: [
        IconButton(
          onPressed: () {
            Navigator.of(context).pushNamed(
              SearchScreen.routeName,
            );
          },
          iconSize: 28,
          icon: Icon(Icons.search, color: Colors.grey),
        ),
        Consumer<CartProvider>(
          builder: (context, value, child) {
            var noOfCartItems = value.getNoOfItemsInCart;
            return Stack(
              children: [
                IconButton(
                  color: noOfCartItems > 0
                      ? Theme.of(context).primaryColor
                      : Colors.grey,
                  iconSize: 28,
                  icon: Icon(Icons.shopping_cart_outlined),
                  onPressed: () => _onCartIconPress(),
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

  _onCartIconPress() async {
    var route = await Navigator.pushNamed(context, CartScreen.routeName);
    setState(() {});
    Provider.of<ProductProvider>(context, listen: false).initCartItems =
        _cartProvider.getCartItems;
    if (route != null) {
      Provider.of<ScreenRouteProvider>(context, listen: false)
          .goToPageIndex(route);
    }
  }
}
