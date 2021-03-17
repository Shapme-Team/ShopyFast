import 'package:ShopyFast/utils/constants/size_config.dart';
import 'package:ShopyFast/view/components/cartIconWidget.dart';
import 'package:ShopyFast/view/screens/SearchScreen/searchScreen.dart';
import 'package:ShopyFast/view/screens/bottomNavScreens/categories/categoriesScreen.dart';
import 'package:ShopyFast/view/screens/bottomNavScreens/orders/orders.dart';
import 'package:ShopyFast/view/screens/bottomNavScreens/profile/profile_screen.dart';
import 'package:ShopyFast/view/screens/home/home.dart';
import 'package:flutter/material.dart';

class AppBarWidget extends StatelessWidget with PreferredSizeWidget {
  final BuildContext context;
  final String routeName;
  final List<Widget> actions;
  final Function reloadFunction;
  AppBarWidget(
      {this.actions, this.context, this.routeName, this.reloadFunction});

  String _appBarTitleFunction(String routeName) {
    switch (routeName) {
      case HomeScreen.routeName:
        return 'ShopyFast';
      case CategoriesScreen.routeName:
        return 'Categories';
      case OrdersScreen.routeName:
        return 'Orders';
      case ProfileScreen.routeName:
        return 'Profile';
      default:
        return 'Shopyfast';
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> _defaultAction = [
      IconButton(
        onPressed: () {
          Navigator.of(context).pushNamed(
            SearchScreen.routeName,
          );
        },
        iconSize: 28,
        icon: Icon(Icons.search, color: Colors.grey),
      ),
      CartIconWidget(reloadFunction ?? () {})
    ];
    return AppBar(
      elevation: 1,
      leading: routeName == HomeScreen.routeName
          ? Container(
              padding: EdgeInsets.only(
                left: getWidth(10),
                top: getHeight(8),
                bottom: getWidth(8),
              ),
              child: Image.asset('assets/images/full_logo.png'))
          : null,
      centerTitle: routeName == HomeScreen.routeName,
      title: Text(
        _appBarTitleFunction(routeName),
        style: TextStyle(
          color: Theme.of(context).primaryColor,
          fontSize: 22,
          fontWeight: FontWeight.w600,
        ),
      ),
      actions: [..._defaultAction, ...actions ?? []],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(56);
}
