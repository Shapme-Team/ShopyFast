import 'package:ShopyFast/domain/provider/productProvider.dart';
import 'package:ShopyFast/view/components/circularLoadingWidget.dart';
import 'package:ShopyFast/view/screens/categoryDetailScreen/components/subProductWidget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../components/noProductFoundWidget.dart';

class SubcategoryPage extends StatefulWidget {
  final String sid;
  final String categoryId;
  SubcategoryPage({this.sid, this.categoryId});

  @override
  _SubcategoryPageState createState() => _SubcategoryPageState();
}

class _SubcategoryPageState extends State<SubcategoryPage> {
  Future _fetchProduct;
  @override
  void initState() {
    _fetchProduct = Provider.of<ProductProvider>(context, listen: false)
        .fetchProductsOfSid(widget.sid);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _fetchProduct,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting)
          return CircularLoadingWidget();
        else
          return Container(
            child: SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                child: Consumer<ProductProvider>(
                  builder: (context, value, child) {
                    var products = value.getProductsOfSub(widget.sid);
                    return products.length > 0
                        ? ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: products.length,
                            itemBuilder: (_, index) {
                              return SubProductWidget(products[index]);
                            })
                        : NoProductFoundWidget();
                  },
                ),
              ),
            ),
          );
      },
    );
  }
}
// SubProductWidget(
//                 Product(
//                     category: 'xyx',
//                     description: 'this is a very good product',
//                     imageUrl: 'assets/images/categoryItems/arial.webp',
//                     measureUnit: 'kg',
//                     weight: 1,
//                     price: 85.00,
//                     productId: 'slfjkefwfd',
//                     productName: 'Arial 1Kg pack',
//                     subcategory: 'Detergent'),
//               )
