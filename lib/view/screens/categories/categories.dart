import 'package:ShopyFast/utils/constants/enums.dart';
import 'package:flutter/material.dart';
import '../../components/coustom_bottom_nav_bar.dart';

import 'components/body.dart';

class CategoriesScreen extends StatelessWidget {
  static String routeName = "/categories";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Categories"),
      ),
      body: Body(),
      bottomNavigationBar:
          CustomBottomNavBar(selectedMenu: MenuState.categories),
    );
  }
}
