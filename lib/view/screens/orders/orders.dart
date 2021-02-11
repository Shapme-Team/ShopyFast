import 'package:flutter/material.dart';
import '../../components/coustom_bottom_nav_bar.dart';
import '../../../utils/constants/enums.dart';

import 'components/body.dart';

class OrdersScreen extends StatelessWidget {
  static const String routeName = "/orders";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("orders"),
      ),
      body: Body(),
      // bottomNavigationBar: CustomBottomNavBar(selectedMenu: MenuState.orders),
    );
  }
}
