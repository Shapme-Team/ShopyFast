import 'package:ShopyFast/domain/provider/screenRouteProvider.dart';
import 'package:ShopyFast/main.dart';
import 'package:ShopyFast/utils/categoryConstants.dart';
import 'package:ShopyFast/view/screens/categoryDetailScreen/categoryDetailScreen.dart';
import 'package:ShopyFast/view/screens/home/components/category_type_header.dart';
import 'package:flutter/material.dart';

import '../../../../getit.dart';
import '../../../../utils/constants/size_config.dart';

class CategoriesMain extends StatelessWidget {
  final catConst = CategoriesConstant.CATEGORY_CONSTANTS;
  final nameVar = CategoriesConstant.NAME;
  @override
  Widget build(BuildContext context) {
    // var size = MediaQuery.of(context).size;
    // final double itemHeight = (size.height) / 3;
    // final double itemWidth = size.width / 3;
    // List<Map<String, dynamic>> categories = [
    //   {"icon": "assets/icons/Flash Icon.svg", "text": "Flash Deal"},
    //   {"icon": "assets/icons/Bill Icon.svg", "text": "Bill"},
    //   {"icon": "assets/icons/Game Icon.svg", "text": "Game"},
    //   {"icon": "assets/icons/Gift Icon.svg", "text": "Daily Gift"},
    //   {"icon": "assets/icons/Discover.svg", "text": "More"},
    // ];
    List<Map<String, dynamic>> categories = [
      {
        "img": "assets/images/categories/grocery-cat.jpg",
        "text": CategoriesConstant.GROCERY
      },
      {
        "img": "assets/images/categories/beverages-cat.jpg",
        "text": CategoriesConstant.BEVERAGES
      },
      {
        "img": "assets/images/categories/personalcare-cat.jpg",
        "text": CategoriesConstant.PERSONAL_CARE
      },
      {
        "img": "assets/images/categories/dairyproduct-cat.jpg",
        "text": CategoriesConstant.BREAKFAST_AND_DAIRY
      },
      {
        "img": "assets/images/categories/fnv-cat.jpg",
        "text": CategoriesConstant.FRUITS_AND_VEGETABLE
      },
      {
        "img": "assets/images/categories/household-cat.jpg",
        "text": CategoriesConstant.HOUSEHOLD_ITEMS
      },
      {
        "img": "assets/images/categories/instantfood-cat.jpg",
        "text": CategoriesConstant.INSTANT_FOOD
      },
      {
        "img": "assets/images/categories/chocolate-cat.jpg",
        "text": CategoriesConstant.CHOCOLATES_AND_ICE_CREAM
      },
      {
        "img": "assets/images/categories/biscut-cat.webp",
        "text": CategoriesConstant.BISCUTE_AND_SNACK
      },
    ];

    return Container(
      // padding: EdgeInsets.all(getWidth(20)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          CategoryTypeHeader('Popular Categories'),
          SizedBox(
            height: getHeight(8),
          ),
          GridView.count(
            crossAxisCount: 3,
            physics: NeverScrollableScrollPhysics(),
            childAspectRatio: 1,
            shrinkWrap: true,
            mainAxisSpacing: getWidth(8),
            crossAxisSpacing: getWidth(8),
            children: List.generate(
              categories.length,
              (index) => CategoryCard(
                categories[index]["img"],
                categories[index]["text"],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CategoryCard extends StatelessWidget {
  final String imageAsset;
  final String categoryId;
  CategoryCard(this.imageAsset, this.categoryId);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
            color: Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  imageAsset,
                  width: getWidth(70),
                  height: getHeight(70),
                  fit: BoxFit.contain,
                ),
                Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.only(top: getHeight(4)),
                  child: Text(
                    CategoriesConstant.CATEGORY_CONSTANTS[categoryId]
                        [CategoriesConstant.NAME],
                    style: TextStyle(fontWeight: FontWeight.w500, height: 1.2),
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                )
              ],
            )),
        Positioned.fill(
            child: Material(
          color: Colors.transparent,
          child: InkWell(
            splashColor: Theme.of(context).accentColor.withOpacity(.3),
            onTap: () async {
              await MyApp.analytics.logEvent(parameters: {
                'categoryId': CategoriesConstant.CATEGORY_CONSTANTS[categoryId]
                    [CategoriesConstant.NAME]
              }, name: 'CATEGORY_CLICK');

              var routeName = await Navigator.of(context).pushNamed(
                  CategoryDetailScreen.routeName,
                  arguments: CategoryDetailScreenArg(categoryId));
              if (routeName != null) {
                getIt<ScreenRouteProvider>().goToPageIndex(routeName);
              }
            },
          ),
        ))
      ],
    );
  }
}
