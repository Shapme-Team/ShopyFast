import 'package:ShopyFast/domain/provider/screenRouteProvider.dart';
import 'package:ShopyFast/view/helper/screenWrapper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import '../../../data/core/apiConstant.dart';
import '../../../domain/provider/cartProvider.dart';
import '../../../domain/provider/productProvider.dart';
import '../../../getit.dart';
import '../../../utils/constants/size_config.dart';
import '../SearchScreen/searchScreen.dart';
import '../cart/cart_screen.dart';
import 'components/categories_main.dart';
import 'components/popular_product.dart';

class HomeScreen extends StatefulWidget {
  final User user;

  HomeScreen({this.user});
  static const String routeName = "/home";

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // final socketUrl = 'https://shopyfast.herokuapp.com/';
  final socketUrl = ApiConstants.BASE_URL;
  var cartValue = 10;
  CartProvider _cartProvider;

  connectToSocketIo() {
    IO.Socket socket = IO.io(socketUrl, <String, dynamic>{
      'transports': ['websocket'],
      // "autoConnect": false
    });
    // if (socket.connected) {
    socket.onConnect((data) {
      print('socket connected !');
      _cartProvider.setSocket = socket;
    });
    // } else
    // print('socket is already connected !');
    socket.onConnectError(
        (data) => print('error while connecting socket: $data'));
    socket.onDisconnect((_) => print('socket disconnect'));
  }

  @override
  void initState() {
    _cartProvider = getIt<CartProvider>();
    connectToSocketIo();
    Provider.of<ProductProvider>(context, listen: false)
        .initCartItems(_cartProvider.getCartItems);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
          onPressed: () {
            Navigator.of(context).pushNamed(
              SearchScreen.routeName,
              // arguments: CategoryDetailScreenArg(CategoriesConstant.GROCERY),
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
                    onPressed: () async {
                      var route = await Navigator.pushNamed(
                          context, CartScreen.routeName);
                      if (route != null) {
                        Provider.of<ScreenRouteProvider>(context, listen: false)
                            .goToPageIndex(route);
                      }
                    }),
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
