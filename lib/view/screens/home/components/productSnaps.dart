import 'package:ShopyFast/domain/provider/productProvider.dart';
import 'package:ShopyFast/getit.dart';
import 'package:ShopyFast/utils/categoryConstants.dart';
import 'package:ShopyFast/view/components/shimmers/verticalProductShimmer.dart';
import 'package:ShopyFast/view/screens/categoryDetailScreen/categoryDetailScreen.dart';
import 'package:ShopyFast/view/screens/home/components/category_type_header.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'productSnapcard.dart';
import '../../../../domain/models/Product.dart';

import '../../../../utils/constants/size_config.dart';

class ProductSnaps extends StatefulWidget {
  @override
  _ProductSnapsState createState() => _ProductSnapsState();
}

class _ProductSnapsState extends State<ProductSnaps> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      children: [
        ...CategoriesConstant.SPECIAL_SUBCATEGORIES
            .map((sid) => buildSnapFutureBuilder(sid))
      ],
    );
  }

  Widget buildSnapFutureBuilder(String sid) {
    return FutureBuilder(
        future: getIt<ProductProvider>().fetchProductsOfSid(sid),
        // future: Future.delayed(Duration(seconds: 500)),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return VerticalProductShimmer();
          } else
            return buildProductsList(sid);
        });
  }

  Widget buildProductsList(String sid) {
    return Consumer<ProductProvider>(builder: (context, value, child) {
      var subProducts = value.getProductsOfSub(sid);
      if (subProducts.length > 5) {
        subProducts = subProducts.getRange(0, 5).toList();
      }
      return Padding(
        padding: const EdgeInsets.only(bottom: 16),
        child: Column(
          children: [
            CategoryTypeHeader(CategoriesConstant.getSubcategoryList()[sid]),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: IntrinsicHeight(
                child: Row(
                  children: [
                    ...List.generate(
                      subProducts.length,
                      (index) {
                        return ProductSnapCard(subProducts[index]);
                      },
                    ),
                    moreProductsWidget(sid),
                    SizedBox(width: getWidth(20)),
                  ],
                ),
              ),
            )
          ],
        ),
      );
    });
  }

  moreProductsWidget(String sid) => Container(
        width: MediaQuery.of(context).size.width / 3,
        child: RaisedButton(
          onPressed: () {
            Navigator.of(context).pushNamed(CategoryDetailScreen.routeName,
                arguments: CategoryDetailScreenArg(
                    CategoriesConstant.getCategoryIdOfSubcategory(sid), sid));
          },
          color: Theme.of(context).accentColor,
          child: Text('See all',
              style: TextStyle(
                fontSize: 16,
                color: Colors.white,
              )),
        ),
      );
}