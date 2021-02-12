import 'package:ShopyFast/utils/categoryConstants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../utils/constants/size_config.dart';

class Categories extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> categories = [
      {"icon": "assets/icons/Flash Icon.svg", "text": "Flash Deal"},
      {"icon": "assets/icons/Bill Icon.svg", "text": "Bill"},
      {"icon": "assets/icons/Game Icon.svg", "text": "Game"},
      {"icon": "assets/icons/Gift Icon.svg", "text": "Daily Gift"},
      {"icon": "assets/icons/Discover.svg", "text": "More"},
    ];
    List<Map<String, dynamic>> categories2 = [
      {
        "icon": "assets/images/categories/grocery-cat.jpg",
        "text": CategoriesConstant.GROCERY
      },
      {
        "icon": "assets/images/categories/beverages-cat.jpg",
        "text": CategoriesConstant.BEVERAGES
      },
      {
        "icon": "assets/images/categories/personalcare-cat.jpg",
        "text": CategoriesConstant.PERSONAL_CARE
      },
      {
        "icon": "assets/images/categories/dairyproduct-cat.jpg",
        "text": CategoriesConstant.BREAKFAST_AND_DAIRY
      },
      {
        "icon": "assets/images/categories/fnv-cat.jpg",
        "text": CategoriesConstant.FRUITS_AND_VEGETABLE
      },
      {
        "icon": "assets/images/categories/household-cat.jpg",
        "text": CategoriesConstant.HOUSEHOLD_ITEMS
      },
      {
        "icon": "assets/images/categories/instantfood-cat.jpg",
        "text": CategoriesConstant.INSTANT_FOOD
      },
      {
        "icon": "assets/images/categories/chocolate-cat.jpg",
        "text": CategoriesConstant.CHOCOLATES_AND_ICE_CREAM
      },
    ];
    return Container(
      padding: EdgeInsets.all(getWidth(20)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Shop by categories',
            style: TextStyle(
              fontSize: 20,
              color: Colors.black87,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          GridView.count(
            crossAxisCount: 3,
            physics: NeverScrollableScrollPhysics(),
            childAspectRatio: 1,
            shrinkWrap: true,
            mainAxisSpacing: getWidth(8),
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            // crossAxisAlignment: CrossAxisAlignment.start,
            children:
                // [
                //   Container(
                //     height: 100,
                //     child: ListView.builder(
                //       shrinkWrap: true,
                //       itemCount: categories.length,
                //       itemBuilder: (BuildContext context, index) {
                //         return CategoryCard(
                //           icon: categories[index]["icon"],
                //           text: categories[index]["text"],
                //           press: () {},
                //         );
                //       },
                //     ),
                //   ),
                // ]
                List.generate(
              categories2.length,
              (index) => CategoryCard2(
                categories2[index]["icon"],
                categories2[index]["text"],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CategoryCard2 extends StatelessWidget {
  final String imageAsset;
  final String categoryName;
  CategoryCard2(this.imageAsset, this.categoryName);

  @override
  Widget build(BuildContext context) {
    return Container(
        // color: Colors.amber,
        //  height: getHeight(50),
        padding: EdgeInsets.all(4),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              imageAsset,
              width: getWidth(80),
              height: getHeight(75),
              fit: BoxFit.contain,
            ),
            Container(
              height: getHeight(20),
              alignment: Alignment.center,
              child: Text(
                categoryName,
                textAlign: TextAlign.center,
              ),
            )
          ],
        ));
  }
}

class CategoryCard extends StatelessWidget {
  const CategoryCard({
    Key key,
    @required this.icon,
    @required this.text,
    @required this.press,
  }) : super(key: key);

  final String icon, text;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: SizedBox(
        width: getWidth(55),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(getWidth(15)),
              height: getWidth(55),
              width: getWidth(55),
              decoration: BoxDecoration(
                color: Color(0xFFFFECDF),
                borderRadius: BorderRadius.circular(10),
              ),
              child: SvgPicture.asset(icon),
            ),
            SizedBox(height: 5),
            Text(text, textAlign: TextAlign.center)
          ],
        ),
      ),
    );
  }
}
