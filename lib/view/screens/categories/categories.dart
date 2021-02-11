import 'package:flutter/material.dart';

import 'components/body.dart';

class CategoriesScreen extends StatelessWidget {
  static const String routeName = "/categories";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Categories"),
      ),
      body: Body(),
    );
  }
}
