import 'package:ShopyFast/domain/models/Product.dart';
import 'package:ShopyFast/domain/provider/productProvider.dart';
import 'package:ShopyFast/getit.dart';
import 'package:ShopyFast/utils/categoryConstants.dart';
import 'package:ShopyFast/view/components/shimmers/verticalProductShimmer.dart';
import 'package:ShopyFast/view/screens/categoryDetailScreen/categoryDetailScreen.dart';
import 'package:ShopyFast/view/screens/home/components/category_type_header.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../utils/constants/size_config.dart';
import 'productSnapcard.dart';

class ProductSnaps extends StatefulWidget {
  @override
  _ProductSnapsState createState() => _ProductSnapsState();
}

class _ProductSnapsState extends State<ProductSnaps> {
  @override
  void initState() {
    getIt<ProductProvider>().getProductSnapFromSubcategories(
        CategoriesConstant.SPECIAL_SUBCATEGORIES);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print('product snap build');
    return Container(
        child: ListView(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      children: [
        ...CategoriesConstant.SPECIAL_SUBCATEGORIES.map((sid) =>
            Consumer<ProductProvider>(builder: (context, value, child) {
              var subProducts = value.getProductsOfSub(sid);
              bool isProductsEmpty = subProducts.isEmpty;

              if (!isProductsEmpty && subProducts.length > 5) {
                subProducts = subProducts.getRange(0, 5).toList();
              }
              return isProductsEmpty
                  ? VerticalProductShimmer()
                  : buildProductsSnapItems(sid, subProducts);
            })),
      ],
    ));
  }

  Widget buildProductsSnapItems(String sid, List<Product> subProducts) {
    return Container(
      // padding: const EdgeInsets.only(bottom: 16),
      color: Colors.white,
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
          ),
          SizedBox(height: 8),
          Divider(
              // height: 3,
              )
        ],
      ),
    );
  }

  moreProductsWidget(String sid) => Container(
        width: MediaQuery.of(context).size.width / 3,
        child: ElevatedButton(
          onPressed: () {
            Navigator.of(context).pushNamed(CategoryDetailScreen.routeName,
                arguments: CategoryDetailScreenArg(
                    CategoriesConstant.getCategoryIdOfSubcategory(sid), sid));
          },
          // color: Theme.of(context).accentColor,
          child: Text('See all',
              style: TextStyle(
                fontSize: 16,
                color: Colors.white,
              )),
        ),
      );
}
