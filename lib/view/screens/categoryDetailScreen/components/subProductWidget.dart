import 'package:ShopyFast/domain/models/Product.dart';
import 'package:ShopyFast/domain/provider/cartProvider.dart';
import 'package:ShopyFast/domain/provider/productProvider.dart';
import 'package:ShopyFast/utils/constants/size_config.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

enum IncrementDecrement { INCREMENT, DECREMENT }

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
                  width: 1, color: Colors.blueGrey.withOpacity(.5)))),
      // margin: EdgeInsets.only(bottom: 4),
      // padding: EdgeInsets.all(8),
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
          BottomSide(product: product)
        ],
      ),
    );
  }

  SizedBox bulidProductImage(Product product) {
    print('IMAGE URL IS :--' + product.toString());
    return SizedBox(
        height: getHeight(150),
        width: getWidth(150),
        child: CachedNetworkImage(
          imageUrl: product.imageUrl,
          fit: BoxFit.cover,
        ));
    // Image.asset(
    //   // product.imageUrl,
    //   'assets/images/categoryItems/besan.webp',
    //   fit: BoxFit.cover,
    // ));
  }
}

class BottomSide extends StatelessWidget {
  const BottomSide({
    Key key,
    @required this.product,
  }) : super(key: key);

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          product.quantity > 0
              ? buildIncrementDecrement(context)
              : GestureDetector(
                  onTap: () {
                    onPlusMinusClick(IncrementDecrement.INCREMENT, context);
                    print('product quantity: ${product.quantity}');
                  },
                  child: Container(
                    width: 100,
                    height: 40,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: Colors.redAccent,
                        borderRadius: BorderRadius.circular(8)),
                    child: Text('Add',
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.w600)),
                  ),
                )
        ],
      ),
    );
  }

  Widget buildIncrementDecrement(BuildContext context) {
    return Container(
      child: Row(
        children: [
          plusMinusButton(IncrementDecrement.DECREMENT, context),
          Container(
            height: 40,
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 4),
            alignment: Alignment.center,
            decoration: BoxDecoration(color: Colors.redAccent),
            child: Text(product.quantity.toString(),
                style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.w600)),
          ),
          plusMinusButton(IncrementDecrement.INCREMENT, context),
        ],
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

  Widget plusMinusButton(IncrementDecrement idValue, BuildContext context) {
    return GestureDetector(
      onTap: () => onPlusMinusClick(idValue, context),
      child: Container(
        height: 40,
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: Colors.redAccent,
            ),
            borderRadius: BorderRadius.circular(4)),
        // width: 30,
        child: Icon(
          idValue == IncrementDecrement.INCREMENT ? Icons.add : Icons.remove,
          color: Colors.redAccent,
        ),
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
        padding: const EdgeInsets.all(4.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: Text(
                    'Rs. ${product.price}',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                    padding: EdgeInsets.all(8),
                    child: Text(
                      '${product.weight} ${product.measureUnit}',
                      style: TextStyle(fontSize: 16),
                    )),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(4),
              child: Text(
                product.productName,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: Text(
                product.description,
                maxLines: 2,
                style: TextStyle(
                  fontSize: 18,
                  height: 1.2,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
