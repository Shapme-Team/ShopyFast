import 'package:ShopyFast/screens/orders/orders.dart';

import '../screens/categories/categories.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../screens/home/home.dart';
import '../screens/profile/profile_screen.dart';

import '../constants/constants.dart';
import '../constants/enums.dart';

class CustomBottomNavBar extends StatelessWidget {
  const CustomBottomNavBar({
    Key key,
    @required this.selectedMenu,
  }) : super(key: key);

  final MenuState selectedMenu;

  @override
  Widget build(BuildContext context) {
    final Color inActiveIconColor = Color(0xFFB6B6B6);
    return Container(
      padding: EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            offset: Offset(0, -15),
            blurRadius: 20,
            color: Color(0xFFDADADA).withOpacity(0.15),
          ),
        ],
        // borderRadius: BorderRadius.only(
        //   topLeft: Radius.circular(20),
        //   topRight: Radius.circular(20),
        // ),
      ),
      child: SafeArea(
          top: false,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              GestureDetector(
                onTap: () => Navigator.pushReplacementNamed(
                    context, HomeScreen.routeName),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: SvgPicture.asset(
                        "assets/icons/Shop Icon.svg",
                        height: 30,
                        color: MenuState.home == selectedMenu
                            ? kPrimaryColor
                            : inActiveIconColor,
                      ),
                      onPressed: () => Navigator.pushReplacementNamed(
                          context, HomeScreen.routeName),
                    ),
                    Text(
                      'Home',
                      style: TextStyle(
                        color: MenuState.home == selectedMenu
                            ? kPrimaryColor
                            : inActiveIconColor,
                      ),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () => Navigator.pushReplacementNamed(
                    context, HomeScreen.routeName),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: SvgPicture.asset(
                        "assets/icons/categories.svg",
                        height: 30,
                        color: MenuState.categories == selectedMenu
                            ? kPrimaryColor
                            : inActiveIconColor,
                      ),
                      onPressed: () => Navigator.pushReplacementNamed(
                          context, CategoriesScreen.routeName),
                    ),
                    Text(
                      'Categories',
                      style: TextStyle(
                        color: MenuState.categories == selectedMenu
                            ? kPrimaryColor
                            : inActiveIconColor,
                      ),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () => Navigator.pushReplacementNamed(
                    context, OrdersScreen.routeName),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.shopping_bag_outlined,
                      size: 30,
                      color: MenuState.orders == selectedMenu
                          ? kPrimaryColor
                          : inActiveIconColor,
                    ),
                    //   SvgPicture.asset(
                    //     "assets/icons/categories.svg",
                    //     height: 30,
                    //     color: MenuState.categories == selectedMenu
                    //         ? kPrimaryColor
                    //         : inActiveIconColor,
                    //   ),
                    //   onPressed: () => Navigator.pushReplacementNamed(
                    //       context, CategoriesScreen.routeName),
                    // ),
                    Text(
                      'Orders',
                      style: TextStyle(
                        color: MenuState.orders == selectedMenu
                            ? kPrimaryColor
                            : inActiveIconColor,
                      ),
                    ),
                  ],
                ),
              ),
              // IconButton(
              //   icon: SvgPicture.asset("assets/icons/Chat bubble Icon.svg"),
              //   onPressed: () {},
              // ),
              IconButton(
                icon: SvgPicture.asset(
                  "assets/icons/User Icon.svg",
                  color: MenuState.profile == selectedMenu
                      ? kPrimaryColor
                      : inActiveIconColor,
                ),
                onPressed: () => Navigator.pushReplacementNamed(
                    context, ProfileScreen.routeName),
              ),
            ],
          )),
    );
  }
}
