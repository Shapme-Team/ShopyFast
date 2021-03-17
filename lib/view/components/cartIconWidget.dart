import 'package:ShopyFast/domain/provider/cartProvider.dart';
import 'package:ShopyFast/domain/provider/productProvider.dart';
import 'package:ShopyFast/domain/provider/screenRouteProvider.dart';
import 'package:ShopyFast/view/screens/cart/cart_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../getit.dart';

class CartIconWidget extends StatefulWidget {
  final Function screenReloadFunction;

  CartIconWidget(this.screenReloadFunction);

  @override
  _CartIconWidgetState createState() => _CartIconWidgetState();
}

class _CartIconWidgetState extends State<CartIconWidget> {
  @override
  Widget build(BuildContext context) {
    return Consumer<CartProvider>(
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
    );
  }

  _onCartIconPress() async {
    var route = await Navigator.pushNamed(context, CartScreen.routeName);
    getIt<ProductProvider>().initCartItems = getIt<CartProvider>().getCart;
    widget.screenReloadFunction();

    if (route != null) {
      getIt<ScreenRouteProvider>().goToPageIndex(route);
    }
  }
}
