import 'package:ShopyFast/domain/provider/screenRouteProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../domain/models/order.dart';
import '../../../../domain/provider/cartProvider.dart';
import '../../../../getit.dart';
import '../../../components/circularLoadingWidget.dart';
import '../../SearchScreen/searchScreen.dart';
import '../../cart/cart_screen.dart';
import 'components/orderItemWidget.dart';

class OrdersScreen extends StatefulWidget {
  static const String routeName = "/orders";

  @override
  _OrdersScreenState createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
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
        // leading: Icon(Icons.menu),
        actions: [
          IconButton(
              icon: Icon(
                Icons.search,
                size: 28,
                color: Colors.grey,
              ),
              onPressed: () =>
                  Navigator.pushNamed(context, SearchScreen.routeName)),
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
                      onPressed: () async {
                        var route = await Navigator.pushNamed(
                            context, CartScreen.routeName);
                        if (route != null) {
                          Provider.of<ScreenRouteProvider>(context,
                                  listen: false)
                              .goToPageIndex(route);
                        }
                      }),
                  noOfCartItems > 0
                      ? Positioned(
                          top: 4,
                          right: 4,
                          child: Container(
                              padding:
                                  EdgeInsets.all(noOfCartItems > 9 ? 2 : 4),
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
      ),
      body: FutureBuilder(
        future: getIt<CartProvider>().fetchOrders(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting)
            return CircularLoadingWidget();
          else {
            var orders = Provider.of<CartProvider>(context).getListOfOrders;
            return orders.length > 0
                ? buildOrderList(reorderOrderItems(orders))
                : buildNoOrderWidget();
            ;
          }
        },
      ),
    );
  }

  Widget buildOrderList(List<Order> listOfOrders) => Container(
        margin: EdgeInsets.all(8),
        child: ListView.builder(
          itemCount: listOfOrders.length,
          itemBuilder: (context, index) {
            var orderItem = listOfOrders[index];
            return OrderItemWidget(orderItem);
          },
        ),
      );

  List<Order> reorderOrderItems(List<Order> orders) {
    orders.sort((a, b) => b.dateTime.compareTo(a.dateTime));
    return orders;
  }

  Widget buildNoOrderWidget() => Container(
          child: Center(
        child: Text('no orders yet !',
            style:
                TextStyle(fontSize: 18, color: Theme.of(context).primaryColor)),
      ));
}
