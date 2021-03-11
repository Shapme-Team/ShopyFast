import 'package:ShopyFast/domain/models/Product.dart';
import 'package:ShopyFast/domain/provider/cartProvider.dart';
import 'package:ShopyFast/domain/provider/productProvider.dart';
import 'package:ShopyFast/utils/constants/size_config.dart';
import 'package:ShopyFast/utils/globals.dart';
import 'package:ShopyFast/view/components/plusMinusWidget.dart';
import 'package:ShopyFast/view/screens/categoryDetailScreen/components/productDetailDialog.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class SubProductWidget extends StatefulWidget {
  final Product product;
  SubProductWidget(this.product);
  @override
  _SubProductWidgetState createState() => _SubProductWidgetState();
}

class _SubProductWidgetState extends State<SubProductWidget> {
  @override
  Widget build(BuildContext context) {
    var product = widget.product;
    // product.quantity = 1;
    return Container(
      decoration: BoxDecoration(
          // borderRadius: BorderRadius.circular(8),
          border: Border(
              bottom: BorderSide(
                  width: 1,
                  color: Theme.of(context).accentColor.withOpacity(.2)))),
      // margin: EdgeInsets.only(bottom: 4),
      padding: EdgeInsets.all(4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              bulidProductImage(product),
              RightSide(product: product),
            ],
          ),
        ],
      ),
    );
  }

  Widget bulidProductImage(Product product) {
    // print('IMAGE URL IS :--' + product.imageUrl);
    return GestureDetector(
      onTap: () => showDialogWidget(product),
      child: Container(
          height: getHeight(100),
          width: getWidth(100),
          decoration: BoxDecoration(
              border: Border(
                  right: BorderSide(
                      width: 1,
                      color: Theme.of(context).accentColor.withOpacity(.1)))),
          padding: EdgeInsets.only(left: 8, top: 8, right: 8),
          child: CachedNetworkImage(
              // product.imageUrl,
              fadeInDuration: Duration(milliseconds: 100),
              imageUrl: product.imageUrl,
              fit: BoxFit.contain,
              placeholder: (build, url) => Shimmer.fromColors(
                    baseColor: Colors.grey[300],
                    highlightColor: Colors.white,
                    child: SizedBox(
                      height: 125,
                      width: 125,
                      child: Image.asset(
                        'assets/images/product_placeholder.jpg',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ))),
    );
  }

  showDialogWidget(Product product) {
    print('dialog called');
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        content: ProductDetailDialog(product),
      ),
    );
  }
}

class RightSide extends StatelessWidget {
  const RightSide({
    Key key,
    @required this.product,
  }) : super(key: key);

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(left: 8, bottom: 4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Rs. ${product.price}',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Container(
                    padding: EdgeInsets.all(8),
                    child: Text(
                      '${product.weight} ${product.measureUnit}',
                      style: TextStyle(fontSize: 18),
                    )),
              ],
            ),
            Container(
              alignment: Alignment.bottomLeft,
              padding: const EdgeInsets.only(bottom: 8),
              child: Text(
                product.productName,
                style: TextStyle(
                    fontSize: 16, fontWeight: FontWeight.w500, height: 1.2),
              ),
            ),
            PlusMinusWidget(product.quantity, onPlusMinusClick),
          ],
        ),
      ),
    );
  }

  onPlusMinusClick(IncrementDecrement idValue, BuildContext context) {
    if (idValue == IncrementDecrement.INCREMENT) {
      product.quantity++;
      Provider.of<CartProvider>(context, listen: false)
          .addItemToCart(product.copyWith());
    } else {
      product.quantity--;
      Provider.of<CartProvider>(context, listen: false)
          .removeItemFromCart(product.copyWith());
    }

    Provider.of<ProductProvider>(context, listen: false)
        .updateProductQuantity(product);
  }
}
