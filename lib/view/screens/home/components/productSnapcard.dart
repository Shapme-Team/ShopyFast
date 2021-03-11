import 'package:ShopyFast/domain/provider/cartProvider.dart';
import 'package:ShopyFast/domain/provider/productProvider.dart';
import 'package:ShopyFast/utils/constants/size_config.dart';
import 'package:ShopyFast/view/screens/categoryDetailScreen/components/productDetailDialog.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../domain/models/Product.dart';
import '../../../../utils/constants/constants.dart';
import '../../productDetails/details_screen.dart';

enum IncrementDecrement { INCREMENT, DECREMENT }

class ProductSnapCard extends StatefulWidget {
  const ProductSnapCard(
    this.product,
  );

  final Product product;

  @override
  _ProductSnapCardState createState() => _ProductSnapCardState();
}

class _ProductSnapCardState extends State<ProductSnapCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
              blurRadius: 4, color: Colors.grey[400], offset: Offset(1, 2)),
        ],
      ),
      margin: EdgeInsets.all(8),
      padding: EdgeInsets.all(8),
      width: MediaQuery.of(context).size.width / 3 + 16,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          GestureDetector(
            onTap: () => showDialogWidget(widget.product),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(15),
              ),
              child: CachedNetworkImage(
                  imageUrl: widget.product.imageUrl,
                  fadeInDuration: Duration(milliseconds: 100),
                  fadeOutDuration: Duration(milliseconds: 100),
                  fit: BoxFit.contain,
                  placeholder: (build, url) => Shimmer.fromColors(
                        baseColor: Colors.grey[300],
                        highlightColor: Colors.white,
                        child: SizedBox(
                          height: getHeight(125),
                          width: getWidth(125),
                          child: Image.asset(
                            'assets/images/product_placeholder.jpg',
                            fit: BoxFit.cover,
                          ),
                        ),
                      )),
            ),
          ),
          SizedBox(height: getHeight(10)),
          Material(
            child: InkWell(
              splashColor: Colors.red,
              child: Text(
                widget.product.productName,
                style: TextStyle(
                    color: Theme.of(context).accentColor, fontSize: 16),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 4),
            padding: EdgeInsets.symmetric(vertical: 4),
            color: Colors.grey[200],
            child: Text(
              ' ${widget.product.weight} ${widget.product.measureUnit} ',
              style: TextStyle(color: Theme.of(context).accentColor),
            ),
          ),
          SizedBox(height: 8),
          Text.rich(
            TextSpan(
              text: '₹',
              style: TextStyle(
                  fontSize: 22,
                  color: Theme.of(context).accentColor,
                  fontWeight: FontWeight.w600),
              children: [
                TextSpan(
                  text: ' ${widget.product.price}',
                  style: TextStyle(
                      fontSize: 18,
                      color: Theme.of(context).accentColor,
                      fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
          SizedBox(height: 8),
          PlusMinusButton(product: widget.product)
        ],
      ),
    );
  }

  showDialogWidget(Product product) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        content: ProductDetailDialog(product),
      ),
    );
  }
}

class PlusMinusButton extends StatelessWidget {
  const PlusMinusButton({
    Key key,
    @required this.product,
  }) : super(key: key);

  final Product product;

  @override
  Widget build(BuildContext context) {
    return product.quantity > 0
        ? buildIncrementDecrement(context)
        : GestureDetector(
            onTap: () {
              onPlusMinusClick(IncrementDecrement.INCREMENT, context);
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: Colors.redAccent,
                  borderRadius: BorderRadius.circular(8)),
              child: Text('Add',
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.w600)),
            ),
          );
  }

  Widget buildIncrementDecrement(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          plusMinusButton(IncrementDecrement.DECREMENT, context),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            // height: 30,
            // padding: EdgeInsets.symmetric(horizontal: 20, vertical: 4),
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
        // height: 30,
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
