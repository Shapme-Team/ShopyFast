import 'package:flutter/material.dart';

import '../components/coustom_bottom_nav_bar.dart';
import '../screens/categories/categories.dart';
import '../screens/home/home.dart';
import '../screens/orders/orders.dart';
import '../screens/profile/profile_screen.dart';

class ScreenWrapper extends StatefulWidget {
  @override
  _ScreenWrapperState createState() => _ScreenWrapperState();
}

class _ScreenWrapperState extends State<ScreenWrapper> {
  int _currentIndex = 0;

  @override
  void initState() {
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

  // takeCurrentStatus(String currentStatus) {
  //   _currentStatus = currentStatus;
  //   print('current status is : $_currentStatus');
  // }

  // @override
  // void didChangeAppLifecycleState(AppLifecycleState state) {
  //   print('state is : $state');
  //   if (state == AppLifecycleState.paused) {
  //   } else if (state == AppLifecycleState.resumed) {
  //     initClient();
  //   } else if (state == AppLifecycleState.inactive) {
  //     _myChatProvider.disconneceSockets(socket, takeCurrentStatus);
  //   }
  //   super.didChangeAppLifecycleState(state);
  // }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: WillPopScope(
              onWillPop: () async {
                print('will pop called **************** ');
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
            }, _currentIndex)));
  }
}
