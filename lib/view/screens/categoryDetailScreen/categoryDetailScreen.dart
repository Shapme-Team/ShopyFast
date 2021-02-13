import 'package:ShopyFast/domain/provider/productProvider.dart';
import 'package:ShopyFast/getit.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../utils/categoryConstants.dart';
import 'components/customTabWidget.dart';

class CategoryDetailScreen extends StatefulWidget {
  static String routeName = "/categoryDetailScreen";

  CategoryDetailScreen();
  @override
  _CategoryDetailScreenState createState() => _CategoryDetailScreenState();
}

class _CategoryDetailScreenState extends State<CategoryDetailScreen> {
  var categoryConstant = CategoriesConstant.CATEGORY_CONSTANTS;
  ProductProvider _productProvider;

  @override
  void initState() {
    _productProvider = getIt<ProductProvider>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    CategoryDetailScreenArg arg = ModalRoute.of(context).settings.arguments;
    List<String> _listOfSubcategory = getListOfSubcategory(arg.categoryId);
    return ChangeNotifierProvider.value(
      value: _productProvider,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title:
                Text(categoryConstant[arg.categoryId][CategoriesConstant.NAME]),
          ),
          body: CustomTabViewWidget(
              subcategoryList: _listOfSubcategory, categoryId: arg.categoryId),
        ),
      ),
    );
  }

  List<String> getListOfSubcategory(String categoryId) {
    var categoryConstant = CategoriesConstant.CATEGORY_CONSTANTS;
    var mapOfSub =
        categoryConstant[categoryId][CategoriesConstant.SUBCATEGORIES] as Map;
    var listOfSubcategoryIds = mapOfSub.keys.toList();
    return listOfSubcategoryIds;
  }
}

class CategoryDetailScreenArg {
  final String categoryId;
  CategoryDetailScreenArg(this.categoryId);
}
