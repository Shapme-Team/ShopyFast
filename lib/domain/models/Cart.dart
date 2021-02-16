import 'package:hive/hive.dart';

import 'Product.dart';
// part 'Cart.g.dart';
part 'gen/Cart.g.dart';

@HiveType(typeId: 3)
class Cart {
  @HiveField(0)
  List<Product> product;

  @HiveField(1)
  double amount;

  Cart({this.product, this.amount});
}

// Demo data for our cart

List<Cart> demoCart1 = [];
