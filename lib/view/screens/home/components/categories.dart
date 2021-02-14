import 'package:ShopyFast/utils/categoryConstants.dart';
import 'package:ShopyFast/view/screens/categoryDetailScreen/categoryDetailScreen.dart';
import 'package:flutter/material.dart';

import '../../../../utils/constants/size_config.dart';

class Categories extends StatelessWidget {
  final catConst = CategoriesConstant.CATEGORY_CONSTANTS;
  final nameVar = CategoriesConstant.NAME;
  @override
  Widget build(BuildContext context) {
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
            childAspectRatio: 10 / 11,
            shrinkWrap: true,
            // mainAxisSpacing: getWidth(8),
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            // crossAxisAlignment: CrossAxisAlignment.start,
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
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(CategoryDetailScreen.routeName,
            arguments: CategoryDetailScreenArg(categoryId));
      },
      child: Container(
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
                alignment: Alignment.center,
                padding: EdgeInsets.only(top: 4),
                child: Text(
                  CategoriesConstant.CATEGORY_CONSTANTS[categoryId]
                      [CategoriesConstant.NAME],
                  style: TextStyle(fontWeight: FontWeight.w600, height: 1.2),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              )
            ],
          )),
    );
  }
}

// class CategoryCard extends StatelessWidget {
//   const CategoryCard({
//     Key key,
//     @required this.icon,
//     @required this.text,
//     @required this.press,
//   }) : super(key: key);

//   final String icon, text;
//   final GestureTapCallback press;

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: press,
//       child: SizedBox(
//         width: getWidth(55),
//         child: Column(
//           children: [
//             Container(
//               padding: EdgeInsets.all(getWidth(15)),
//               height: getWidth(55),
//               width: getWidth(55),
//               decoration: BoxDecoration(
//                 color: Color(0xFFFFECDF),
//                 borderRadius: BorderRadius.circular(10),
//               ),
//               child: SvgPicture.asset(icon),
//             ),
//             SizedBox(height: 5),
//             Text(text, textAlign: TextAlign.center)
//           ],
//         ),
//       ),
//     );
//   }
// }
