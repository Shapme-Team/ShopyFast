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
                  itemCount: CategoriesConstant.CATEGORY_CONSTANTS.length,
                  itemBuilder: (BuildContext context, int index) {
                    var namekey = CategoriesConstant.CATEGORY_CONSTANTS.values
                        .elementAt(index);
                    var subcategoriekey = namekey['subcategories'];
                    print(subcategoriekey);
                    return new ExpansionTile(
                      leading: Icon(Icons.shopping_bag_outlined),
                      title: new Text(
                        namekey['name'],
                        style: new TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      children: <Widget>[
                        new Column(
                          children:
                              _buildExpandableContent(subcategoriekey[index]),
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
}

_buildExpandableContent(dynamic subcat) {
  List<Widget> columnContent = [];

  //
  columnContent.add(
    ListTile(
      title: Text(
        'content',
        style: TextStyle(fontSize: 18.0),
      ),
      leading: Icon(Icons.money),
    ),
  );

  return columnContent;
}
