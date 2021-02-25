import 'package:ShopyFast/domain/models/Product.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ProductItemWidget extends StatelessWidget {
  final Product product;
  ProductItemWidget(this.product);

  @override
  Widget build(BuildContext context) {
    var totalProductAmount =
        (product.price * product.quantity).toStringAsFixed(1);

    return Container(
      margin: EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
          color: Colors.white54, borderRadius: BorderRadius.circular(8)),
      child: Row(
        children: [
          SizedBox(
              height: 75,
              width: 75,
              child: CachedNetworkImage(
                imageUrl: product.imageUrl,
                fit: BoxFit.contain,
                placeholder: (context, url) => SizedBox(
                    height: 75,
                    width: 75,
                    child:
                        Image.asset('assets/images/product_placeholder.jpg')),
              )),
          // SizedBox(
          //     height: 75,
          //     width: 75,
          //     child: Image.asset('assets/images/categoryItems/apple.jpg')),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        constraints: BoxConstraints(
                            maxWidth: MediaQuery.of(context).size.width * .4),
                        padding: const EdgeInsets.all(4),
                        child: Text(
                          product.productName,
                          maxLines: 2,
                          style: TextStyle(fontSize: 18, height: 1.1),
                        ),
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 4),
                            child: RichText(
                              text: TextSpan(children: [
                                TextSpan(
                                    text: product.quantity.toString(),
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        color: Colors.green,
                                        fontSize: 16)),
                                TextSpan(
                                    text:
                                        ' x ${product.weight} ${product.measureUnit}',
                                    style: TextStyle(
                                        color: Colors.grey, fontSize: 16)),
                              ]),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Rs $totalProductAmount',
                        style: TextStyle(
                          fontSize: 18,
                        )),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
