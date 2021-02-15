import 'package:flutter/material.dart';

import 'Product.dart';

class Cart {
  List<Product> product;
  double amount;
  Cart({this.product, this.amount});
}

// Demo data for our cart

List<Cart> demoCart1 = [];
