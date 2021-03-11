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

import '../../../../domain/models/Product.dart';

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
      width: MediaQuery.of(context).size.width / 2.5,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.start,
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
                  height: getHeight(130),
                  width: getWidth(125),
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
          Align(
              alignment: Alignment.center,
              child:
                  PlusMinusWidget(widget.product.quantity, onPlusMinusClick)),
          // PlusMinusButton(product: widget.product)
        ],
      ),
    );
  }

  onPlusMinusClick(IncrementDecrement idValue, BuildContext context) {
    var product = widget.product;
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

  showDialogWidget(Product product) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        content: ProductDetailDialog(product),
      ),
    );
  }
}
