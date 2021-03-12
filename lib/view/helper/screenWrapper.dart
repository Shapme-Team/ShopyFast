import 'package:ShopyFast/domain/provider/authprovider.dart';
import 'package:ShopyFast/domain/provider/cartProvider.dart';
import 'package:ShopyFast/domain/provider/orderProvider.dart';
import 'package:ShopyFast/domain/provider/productProvider.dart';
import 'package:ShopyFast/domain/provider/screenRouteProvider.dart';
import 'package:ShopyFast/getit.dart';
import 'package:ShopyFast/view/screens/categoryDetailScreen/categoryDetailScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../components/coustom_bottom_nav_bar.dart';
import '../screens/bottomNavScreens/categories/categories.dart';
import '../screens/home/home.dart';
import '../screens/bottomNavScreens/orders/ordersScreen.dart';
import '../screens/bottomNavScreens/profile/profile_screen.dart';

class ScreenWrapper extends StatefulWidget {
  @override
  _ScreenWrapperState createState() => _ScreenWrapperState();
}

class _ScreenWrapperState extends State<ScreenWrapper> {
  // int _currentIndex = 0;
  ProductProvider _productProvider;

  @override
  void initState() {
    _productProvider = getIt<ProductProvider>();
    print('init state of ScreenWrapper');
    super.initState();
  }

  List<Widget> _listOfNavScreen = [
    HomeScreen(),
    CategoriesScreen(),
    OrdersScreen(),
    ProfileScreen(),
  ];

  // _setCurrentScreen(int index) {
  //   if (_currentIndex != index) setState(() => _currentIndex = index);
  // }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: _productProvider,
        ),
        ChangeNotifierProvider.value(value: getIt<AuthProvider>()),
        ChangeNotifierProvider.value(value: getIt<CartProvider>()),
        ChangeNotifierProvider.value(value: getIt<ScreenRouteProvider>()),
        ChangeNotifierProvider.value(value: getIt<OrderProvider>()),
      ],
      child: SafeArea(
        child: Consumer<ScreenRouteProvider>(builder: (context, value, child) {
          var _currentIndex = value.getCurrentPageIndex;
          return Scaffold(
            body: WillPopScope(
              onWillPop: () async {
                if (_currentIndex != 0) {
                  value.setCurrentIndex(0);
                  return Future.value(false);
                }
                return Future.value(true);
                // return true;
              },
              child: _listOfNavScreen[_currentIndex],
            ),
            bottomNavigationBar: CustomBottomNavBar((index) {
              value.setCurrentIndex(index);
            }, _currentIndex),
          );
        }),
      ),
    );
  }
}
