import 'package:ShopyFast/view/screens/bottomNavScreens/categories/categoriesScreen.dart';
import 'package:ShopyFast/view/screens/bottomNavScreens/orders/orders.dart';
import 'package:ShopyFast/view/screens/bottomNavScreens/profile/profile_screen.dart';
import 'package:ShopyFast/view/screens/home/home.dart';
import 'package:flutter/cupertino.dart';

class ScreenRouteProvider extends ChangeNotifier {
  int _currentIndex = 0;

  int get getCurrentPageIndex => _currentIndex;
  setCurrentIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }

  goToPageIndex(String routeName) {
    var index = 0;
    switch (routeName) {
      case HomeScreen.routeName:
        index = 0;
        break;
      case CategoriesScreen.routeName:
        index = 1;
        break;
      case OrdersScreen.routeName:
        index = 2;
        break;
      case ProfileScreen.routeName:
        index = 3;
        break;
      default:
        index = 0;
    }
    setCurrentIndex(index);
  }
}
