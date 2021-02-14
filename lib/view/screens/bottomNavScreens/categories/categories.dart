import 'package:ShopyFast/view/screens/categoryDetailScreen/categoryDetailScreen.dart';
import 'package:flutter/material.dart';
import '../../../../utils/categoryConstants.dart';
import 'dart:convert';

class CategoriesScreen extends StatefulWidget {
  static const String routeName = "/categories";

  @override
  _CategoriesScreenState createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Categories"),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: CategoriesConstant.CATEGORY_CONSTANTS.length,
                  itemBuilder: (BuildContext context, int index) {
                    var categoryId = CategoriesConstant.CATEGORY_CONSTANTS.keys
                        .elementAt(index);
                    var category = CategoriesConstant.CATEGORY_CONSTANTS.values
                        .elementAt(index);
                    var subMap =
                        category[CategoriesConstant.SUBCATEGORIES] as Map;
                    var subEntity = subMap.entries.toList();
                    var categoryName = category[CategoriesConstant.NAME];

                    return ExpansionTile(
                      leading: Icon(Icons.shopping_bag_outlined),
                      onExpansionChanged: (value) {},
                      title: Text(
                        categoryName,
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      children: <Widget>[
                        Column(
                          children:
                              _buildExpandableContent(subEntity, categoryId),
                        ),
                      ],
                    );
                  })
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _buildExpandableContent(
      List<MapEntry> subMapEntry, String category) {
    //
    return subMapEntry.map((e) {
      return GestureDetector(
        onTap: () => Navigator.of(context).pushNamed(
            CategoryDetailScreen.routeName,
            arguments: CategoryDetailScreenArg(category, e.key)),
        child: ListTile(
          title: Text(
            e.value,
            style: TextStyle(fontSize: 18.0),
          ),
          leading: Icon(Icons.subdirectory_arrow_right_rounded),
        ),
      );
    }).toList();
  }
}
