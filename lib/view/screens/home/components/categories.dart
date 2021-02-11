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
    return Container(
      padding: EdgeInsets.all(getWidth(20)),
      child: Column(
        children: [
          Text(
            'Categories',
            style: TextStyle(
              fontSize: 20,
              color: Colors.black87,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
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
              categories.length,
              (index) => CategoryCard(
                icon: categories[index]["icon"],
                text: categories[index]["text"],
                press: () {},
              ),
            ),
          ),
        ],
      ),
    );
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