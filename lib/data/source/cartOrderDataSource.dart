import 'package:ShopyFast/domain/models/Product.dart';

abstract class CartOrderDataSource {
  Future<List<Product>> getListOfCartProduct();
}
