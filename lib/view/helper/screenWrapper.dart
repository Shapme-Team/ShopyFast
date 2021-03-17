import 'package:ShopyFast/domain/provider/authprovider.dart';
import 'package:ShopyFast/domain/provider/cartProvider.dart';
import 'package:ShopyFast/domain/provider/orderProvider.dart';
import 'package:ShopyFast/domain/provider/productProvider.dart';
import 'package:ShopyFast/domain/provider/screenRouteProvider.dart';
import 'package:ShopyFast/getit.dart';
import 'package:ShopyFast/utils/constants/size_config.dart';
import 'package:ShopyFast/view/components/cartIconWidget.dart';
import 'package:ShopyFast/view/screens/SearchScreen/searchScreen.dart';
import 'package:ShopyFast/view/screens/categoryDetailScreen/categoryDetailScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../components/coustom_bottom_nav_bar.dart';
import '../screens/bottomNavScreens/categories/categoriesScreen.dart';
import '../screens/home/home.dart';
import '../screens/bottomNavScreens/orders/ordersScreen.dart';
import '../screens/bottomNavScreens/profile/profile_screen.dart';

class ScreenWrapper extends StatefulWidget {
  @override
  _ScreenWrapperState createState() => _ScreenWrapperState();
}

class _ScreenWrapperState extends State<ScreenWrapper> {
  // int _currentIndex = 0;

  reloadFunction() {
    setState(() {});
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

  String _appBarTitleFunction(int index) {
    switch (index) {
      case 0:
        return 'ShopyFast';
      case 1:
        return 'Categories';
      case 2:
        return 'Orders';
      case 3:
        return 'Profile';
      default:
        return 'Shopyfast';
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // print('build of screen wrapper ');
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: getIt<ProductProvider>(),
        ),
        ChangeNotifierProvider.value(value: getIt<AuthProvider>()),
        ChangeNotifierProvider.value(value: getIt<CartProvider>()),
        ChangeNotifierProvider.value(value: getIt<ScreenRouteProvider>()),
        ChangeNotifierProvider.value(value: getIt<OrderProvider>()),
      ],
      child: SafeArea(
        child: Consumer<ScreenRouteProvider>(builder: (context, value, child) {
          var _currentIndex = value.getCurrentPageIndex;
          // print('current page: $_currentIndex ');

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
              child: StatefulBuilder(builder: (context, setState2) {
                return _listOfNavScreen[_currentIndex];
              }),
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
