import 'package:ShopyFast/view/screens/orders/orders.dart';

import '../screens/categories/categories.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../screens/home/home.dart';
import '../screens/profile/profile_screen.dart';

import '../../utils/constants/constants.dart';
import '../../utils/constants/enums.dart';

class CustomBottomNavBar extends StatelessWidget {
  const CustomBottomNavBar(
    this.onStateChange,
    this.currentIndex,
  );

  final int currentIndex;
  final Function onStateChange;

  @override
  Widget build(BuildContext context) {
    final Color inActiveIconColor = Color(0xFFB6B6B6);
    returnIconColor(int i) {
      if (i == currentIndex) {
        return kPrimaryColor;
      } else
        return inActiveIconColor;
    }

    var bottomNavItems = [
      BottomNavigationBarItem(
          label: 'Home',
          icon: SvgPicture.asset(
            "assets/icons/Shop Icon.svg",
            height: 30,
            color: returnIconColor(0),
          )),
      BottomNavigationBarItem(
          label: 'Categories',
          icon: SvgPicture.asset(
            "assets/icons/categories.svg",
            height: 30,
            color: returnIconColor(1),
          )),
      BottomNavigationBarItem(
          label: 'Orders',
          icon: SvgPicture.asset(
            "assets/icons/shopping-bag.svg",
            height: 30,
            color: returnIconColor(2),
          )),
      BottomNavigationBarItem(
          label: 'Profile',
          icon: SvgPicture.asset(
            "assets/icons/User Icon.svg",
            height: 30,
            color: returnIconColor(3),
          )),
    ];

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
      child: BottomNavigationBar(
        items: bottomNavItems,
        onTap: (value) => onStateChange(value),
        backgroundColor: Colors.white,
        unselectedItemColor: inActiveIconColor,
        showSelectedLabels: true,
        selectedItemColor: kPrimaryColor,
        type: BottomNavigationBarType.fixed,
        selectedLabelStyle: TextStyle(color: kPrimaryColor),
        currentIndex: currentIndex,
      ),
    );
  }
}
//  BottomNavBar(selectedMenu: selectedMenu, inActiveIconColor: inActiveIconColor)

// class BottomNavBar extends StatelessWidget {
//   const BottomNavBar({
//     Key key,
//     @required this.selectedMenu,
//     @required this.inActiveIconColor,
//   }) : super(key: key);

//   final MenuState selectedMenu;
//   final Color inActiveIconColor;

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//         top: false,
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceAround,
//           children: [
//             GestureDetector(
//               onTap: () =>
//                   Navigator.pushReplacementNamed(context, HomeScreen.routeName),
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   IconButton(
//                     icon: SvgPicture.asset(
//                       "assets/icons/Shop Icon.svg",
//                       height: 30,
//                       color: MenuState.home == selectedMenu
//                           ? kPrimaryColor
//                           : inActiveIconColor,
//                     ),
//                     onPressed: () => Navigator.pushReplacementNamed(
//                         context, HomeScreen.routeName),
//                   ),
//                   Text(
//                     'Home',
//                     style: TextStyle(
//                       color: MenuState.home == selectedMenu
//                           ? kPrimaryColor
//                           : inActiveIconColor,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             GestureDetector(
//               onTap: () =>
//                   Navigator.pushReplacementNamed(context, HomeScreen.routeName),
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   IconButton(
//                     icon: SvgPicture.asset(
//                       "assets/icons/categories.svg",
//                       height: 30,
//                       color: MenuState.categories == selectedMenu
//                           ? kPrimaryColor
//                           : inActiveIconColor,
//                     ),
//                     onPressed: () => Navigator.pushReplacementNamed(
//                         context, CategoriesScreen.routeName),
//                   ),
//                   Text(
//                     'Categories',
//                     style: TextStyle(
//                       color: MenuState.categories == selectedMenu
//                           ? kPrimaryColor
//                           : inActiveIconColor,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             GestureDetector(
//               onTap: () => Navigator.pushReplacementNamed(
//                   context, OrdersScreen.routeName),
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   Icon(
//                     Icons.shopping_bag_outlined,
//                     size: 30,
//                     color: MenuState.orders == selectedMenu
//                         ? kPrimaryColor
//                         : inActiveIconColor,
//                   ),
//                   //   SvgPicture.asset(
//                   //     "assets/icons/categories.svg",
//                   //     height: 30,
//                   //     color: MenuState.categories == selectedMenu
//                   //         ? kPrimaryColor
//                   //         : inActiveIconColor,
//                   //   ),
//                   //   onPressed: () => Navigator.pushReplacementNamed(
//                   //       context, CategoriesScreen.routeName),
//                   // ),
//                   Text(
//                     'Orders',
//                     style: TextStyle(
//                       color: MenuState.orders == selectedMenu
//                           ? kPrimaryColor
//                           : inActiveIconColor,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             // IconButton(
//             //   icon: SvgPicture.asset("assets/icons/Chat bubble Icon.svg"),
//             //   onPressed: () {},
//             // ),
//             IconButton(
//               icon: SvgPicture.asset(
//                 "assets/icons/User Icon.svg",
//                 color: MenuState.profile == selectedMenu
//                     ? kPrimaryColor
//                     : inActiveIconColor,
//               ),
//               onPressed: () => Navigator.pushReplacementNamed(
//                   context, ProfileScreen.routeName),
//             ),
//           ],
//         ));
//   }
// }
