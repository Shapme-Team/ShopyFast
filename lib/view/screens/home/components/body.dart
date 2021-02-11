import 'package:flutter/material.dart';

import '../../../../utils/constants/size_config.dart';
import 'categories.dart';
import 'discount_banner.dart';
import 'home_header.dart';
import 'popular_product.dart';
import 'special_offers.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // SizedBox(height: getProportionateScreenHeight(20)),
            //  HomeHeader(),
            // SizedBox(height: getProportionateScreenWidth(10)),
            DiscountBanner(),
            Categories(),
            // SpecialOffers(),
            SizedBox(height: getWidth(30)),
            PopularProducts(),
            SizedBox(height: getWidth(30)),
          ],
        ),
      ),
    );
  }
}
