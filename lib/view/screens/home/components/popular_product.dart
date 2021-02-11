import 'package:flutter/material.dart';
import '../../../components/product_card.dart';
import '../../../../domain/models/Product.dart';

import '../../../../utils/constants/size_config.dart';
import 'section_title.dart';

class PopularProducts extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: getWidth(20)),
          child: SectionTitle(title: "Popular Products", press: () {}),
        ),
        SizedBox(height: getWidth(20)),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              ...List.generate(
                demoProducts.length,
                (index) {
                  return ProductCard(product: demoProducts[index]);
                  // here by default width and height is 0
                },
              ),
              SizedBox(width: getWidth(20)),
            ],
          ),
        )
      ],
    );
  }
}
