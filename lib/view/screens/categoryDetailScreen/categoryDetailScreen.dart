import 'package:ShopyFast/domain/provider/cartProvider.dart';
import 'package:ShopyFast/domain/provider/productProvider.dart';
import 'package:ShopyFast/domain/provider/screenRouteProvider.dart';
import 'package:ShopyFast/getit.dart';
import 'package:ShopyFast/utils/constants/themeConstants.dart';
import 'package:ShopyFast/utils/constants/size_config.dart';
import 'package:ShopyFast/view/components/cartIconWidget.dart';
import 'package:ShopyFast/view/screens/cart/cart_screen.dart';
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
  CartProvider _cartProvider;

  reloadFunction() {
    setState(() {});
  }

  @override
  void initState() {
    _productProvider = getIt<ProductProvider>();
    _cartProvider = getIt<CartProvider>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    CategoryDetailScreenArg arg = ModalRoute.of(context).settings.arguments;
    List<String> _listOfSubcategory = getListOfSubcategory(arg.categoryId);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: _productProvider,
        ),
        ChangeNotifierProvider.value(value: _cartProvider)
      ],
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title:
                Text(categoryConstant[arg.categoryId][CategoriesConstant.NAME]),
            // actions: [
            //   CartIconWidget(reloadFunction),
            // ],
          ),
          body: CustomTabViewWidget(
              initPosition: arg.subCategoryId != null
                  ? _listOfSubcategory.indexOf(arg.subCategoryId)
                  : 0,
              subcategoryList: _listOfSubcategory,
              categoryId: arg.categoryId),
          bottomNavigationBar: buildBottomNavBar(),
        ),
      ),
    );
  }

  Consumer<CartProvider> buildBottomNavBar() {
    return Consumer<CartProvider>(
      builder: (context, value, child) {
        var noOfItemsInCart = value.getNoOfItemsInCart;
        var amount = value.getCart.amount;
        return noOfItemsInCart > 0
            ? Container(
                height: getHeight(58),
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    Icon(Icons.shopping_cart_outlined),
                    SizedBox(
                      width: getWidth(8),
                    ),
                    RichText(
                        text: TextSpan(
                            text: '$noOfItemsInCart Items ',
                            style: TextStyle(
                                fontSize: 16,
                                color: Theme.of(context).accentColor),
                            children: [
                          TextSpan(
                              text: '  Rs $amount',
                              style: TextStyle(
                                  color: kActiveGreenColor,
                                  fontWeight: FontWeight.bold))
                        ])),
                    Expanded(child: SizedBox()),
                    ElevatedButton(
                        onPressed: () => onCartIconPress(),
                        child: Text('View Cart'))
                  ],
                ),
              )
            : SizedBox();
      },
    );
  }

  onCartIconPress() async {
    var route = await Navigator.pushNamed(context, CartScreen.routeName);
    getIt<ProductProvider>().initCartItems = getIt<CartProvider>().getCart;
    reloadFunction();

    if (route != null) {
      Navigator.of(context).pop(route);
      // getIt<ScreenRouteProvider>().goToPageIndex(route);
    } else
      print('route is null');
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
  final String subCategoryId;
  CategoryDetailScreenArg(this.categoryId, [this.subCategoryId]);
}
