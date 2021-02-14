import 'package:ShopyFast/utils/categoryConstants.dart';
import 'package:ShopyFast/view/screens/categoryDetailScreen/components/subcategoryPage.dart';
import 'package:flutter/material.dart';

import 'customTabBar.dart';

class CustomTabViewWidget extends StatelessWidget {
  final List<String> subcategoryList;
  final String categoryId;
  final int initPosition;
  const CustomTabViewWidget({
    Key key,
    @required this.subcategoryList,
    @required this.categoryId,
    this.initPosition,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomTabView(
      initPosition: initPosition,
      itemCount: subcategoryList.length,
      tabBuilder: (context, index) {
        var subCategoryName = CategoriesConstant.CATEGORY_CONSTANTS[categoryId]
            [CategoriesConstant.SUBCATEGORIES][subcategoryList[index]];
        return Tab(
            child: Text(
          subCategoryName,
          // style: TextStyle(color: Colors.black),
        ));
      },
      pageBuilder: (context, index) {
        return SubcategoryPage(
          sid: subcategoryList[index],
          categoryId: categoryId,
        );
      },
    );
  }
}
