import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../data/core/apiConstant.dart';
import '../../../domain/provider/cartProvider.dart';
import '../../../domain/provider/productProvider.dart';
import '../../../getit.dart';
import '../../../utils/constants/size_config.dart';
import '../../helper/appBarWidget.dart';
import 'components/categories_main.dart';
import 'components/productSnaps.dart';

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

  reloadFunction() {
    print('reload function called');
    setState(() {});
  }

  @override
  void initState() {
    _cartProvider = getIt<CartProvider>();
    Provider.of<ProductProvider>(context, listen: false).initCartItems =
        _cartProvider.getCart;
    // getIt<OrderProvider>().setSocket();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print('build of home called ---');
    return Scaffold(
        appBar: AppBarWidget(
          context: context,
          reloadFunction: reloadFunction,
          routeName: HomeScreen.routeName,
        ),
        backgroundColor: Theme.of(context).backgroundColor,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CategoriesMain(),
                SizedBox(height: getWidth(30)),
                ProductSnaps(),
                // OrderSnapWidget()
              ],
            ),
          ),
        ));
  }

  // AppBar buildAppBar(BuildContext context) {
  //   return AppBar(
  //     elevation: 1,
  //     leading: Container(
  //         padding: EdgeInsets.only(left: 8, top: 8, bottom: 8),
  //         child: Image.asset('assets/images/full_logo.png')),
  //     title: Text(
  //       'ShopyFast',
  //       style: TextStyle(
  //         color: Theme.of(context).primaryColor,
  //         fontSize: 22,
  //         fontWeight: FontWeight.w600,
  //       ),
  //     ),
  //     actions: [
  //       IconButton(
  //         onPressed: () {
  //           Navigator.of(context).pushNamed(
  //             SearchScreen.routeName,
  //           );
  //         },
  //         iconSize: 28,
  //         icon: Icon(Icons.search, color: Colors.grey),
  //       ),
  //       CartIconWidget(reloadFunction)
  //     ],
  //   );
  // }
}
