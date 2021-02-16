import 'package:ShopyFast/domain/provider/cartProvider.dart';
import 'package:ShopyFast/domain/provider/productProvider.dart';
import 'package:ShopyFast/utils/categoryConstants.dart';
import 'package:ShopyFast/utils/theme.dart';
import 'package:ShopyFast/view/screens/SearchScreen/components/searchProducts.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../getit.dart';

class SearchScreen extends StatefulWidget {
  static String routeName = '/searchScreen';
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController _controller;
  FocusNode _focusNode;

  onChange(String value) {
    if (value.length > 1) getIt<ProductProvider>().searchAutoComplete(value);
  }

  onSubmit(value) async {
    print('submit value: $value');
    getIt<ProductProvider>().getProductBySearch(value);
  }

  @override
  void initState() {
    _controller = TextEditingController();
    _focusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: getIt<CartProvider>(),
        ),
        ChangeNotifierProvider.value(value: getIt<ProductProvider>())
      ],
      builder: (context, child) {
        return SafeArea(
          child: Scaffold(
            appBar: AppBar(
                bottom: SearchBottomTabBar(
                  controller: _controller,
                  onChange: onChange,
                  onSubmit: onSubmit,
                  focusNode: _focusNode,
                ),
                title: Text('Search Products')),
            body: Consumer<ProductProvider>(
              builder: (context, value, child) {
                var searchProducts = value.getSearchResultProducts;
                var autoSearch = value.getSearchAutoComplete;
                return Stack(children: [
                  _focusNode.hasPrimaryFocus
                      ? buildAutoCompleteItem(autoSearch)
                      : SearchProducts(searchProducts)
                ]);
              },
            ),
          ),
        );
      },
    );
  }

  SingleChildScrollView buildAutoCompleteItem(
      List<MapEntry<String, String>> autoSearch) {
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: autoSearch.map((subItem) {
            return GestureDetector(
              onTap: () {
                if (_focusNode.hasPrimaryFocus) {
                  FocusScope.of(context).unfocus();
                }
                getIt<ProductProvider>().fetchProductsOfSid(subItem.key, true);
              },
              child: Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      border: Border(
                    bottom: BorderSide(width: 1, color: Colors.grey[300]),
                  )),
                  child: Text(
                    '${subItem.value}',
                    style: TextStyle(fontSize: 18),
                  )),
            );
          }).toList(),
        ),
      ),
    );
  }
}

class SearchBottomTabBar extends StatelessWidget
    implements PreferredSizeWidget {
  final TextEditingController controller;
  final Function onChange;
  final FocusNode focusNode;
  final Function onSubmit;
  SearchBottomTabBar({
    @required this.controller,
    @required this.onChange,
    @required this.onSubmit,
    @required this.focusNode,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55,
      alignment: Alignment.center,
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      // color: Colors.blue,
      child: Center(
        child: TextFormField(
          focusNode: focusNode,
          autofocus: true,
          onChanged: onChange,
          onFieldSubmitted: onSubmit,
          controller: controller,
          style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 18,
              color: Theme.of(context).primaryColor),
          decoration: InputDecoration(
              suffixIcon: Icon(Icons.search),
              focusColor: Colors.blue,
              hintText: 'Search Item',
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
              contentPadding:
                  EdgeInsets.only(left: 22, bottom: 12, top: 12, right: 22),
              hintStyle: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 18,
              )),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(65);
}
