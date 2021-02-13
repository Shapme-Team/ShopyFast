import 'package:flutter/material.dart';

import '../../../../utils/constants/size_config.dart';
import 'categories.dart';
import 'popular_product.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Categories(),
            SizedBox(height: getWidth(30)),
            PopularProducts(),
            SizedBox(height: getWidth(30)),
          ],
        ),
      ),
    );
  }
}
