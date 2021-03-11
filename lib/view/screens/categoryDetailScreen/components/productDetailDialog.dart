import 'package:ShopyFast/domain/models/Product.dart';
import 'package:ShopyFast/utils/constants/size_config.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ProductDetailDialog extends StatelessWidget {
  final Product product;
  ProductDetailDialog(this.product);

  @override
  Widget build(BuildContext context) {
    print('productdetail build dialog');
    return Container(
      // color: Colors.white,
      padding: EdgeInsets.all(8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            // height: 300,
            margin: EdgeInsets.only(bottom: 8),
            width: getWidth(300),
            child: CachedNetworkImage(
              imageUrl: product.imageUrl,
              fit: BoxFit.contain,
              placeholder: (context, url) =>
                  Image.asset('assets/images/product_placeholder.png'),
            ),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Text(product.productName,
                style: TextStyle(
                  fontSize: 20,
                  color: Theme.of(context).accentColor,
                  fontWeight: FontWeight.bold,
                )),
          ),
          Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Price',
                style: TextStyle(fontSize: 18),
              ),
              Container(
                  padding: EdgeInsets.all(8),
                  child: Text(
                    'Rs. ${product.price}',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  )),
            ],
          ),
          Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Quantity',
                style: TextStyle(fontSize: 18),
              ),
              Container(
                  padding: EdgeInsets.all(8),
                  child: Text(
                    '${product.weight} ${product.measureUnit}',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  )),
            ],
          ),
        ],
      ),
    );
  }
}
