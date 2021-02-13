import 'package:ShopyFast/domain/provider/productProvider.dart';
import 'package:ShopyFast/getit.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../components/coustom_bottom_nav_bar.dart';
import '../screens/bottomNavScreens/categories/categories.dart';
import '../screens/home/home.dart';
import '../screens/bottomNavScreens/orders/orders.dart';
import '../screens/bottomNavScreens/profile/profile_screen.dart';

class ScreenWrapper extends StatefulWidget {
  @override
  _ScreenWrapperState createState() => _ScreenWrapperState();
}

class _ScreenWrapperState extends State<ScreenWrapper> {
  int _currentIndex = 0;
  ProductProvider _productProvider;

  @override
  void initState() {
    _productProvider = getIt<ProductProvider>();
    super.initState();
  }

  List<Widget> _listOfNavScreen = [
    HomeScreen(),
    CategoriesScreen(),
    OrdersScreen(),
    ProfileScreen(),
  ];
  _setCurrentScreen(int index) {
    if (_currentIndex != index) setState(() => _currentIndex = index);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => _productProvider,
        ),
      ],
      child: SafeArea(
          child: Scaffold(
              body: WillPopScope(
                onWillPop: () async {
                  if (_currentIndex != 0) {
                    _setCurrentScreen(0);
                    return Future.value(false);
                  }
                  return Future.value(true);
                  // return true;
                },
                child: _listOfNavScreen[_currentIndex],
              ),
              bottomNavigationBar: CustomBottomNavBar((index) {
                _setCurrentScreen(index);
              }, _currentIndex))),
    );
  }
}
