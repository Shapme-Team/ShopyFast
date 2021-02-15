import 'package:ShopyFast/domain/models/Product.dart';

abstract class CartDataSource {
  Future<List<Product>> getListOfItemsInCart();
  Future<bool> updateItemInCart(Product product);
  Future<bool> removeItemFromCart(String productId);
}

class CartDataSourceLocalImple extends CartDataSource {
  @override
  Future<List<Product>> getListOfItemsInCart() {
    // TODO: implement getListOfItemsInCart
    throw UnimplementedError();
  }

  @override
  Future<bool> removeItemFromCart(String productId) {
    // TODO: implement removeItemFromCart
    throw UnimplementedError();
  }

  @override
  Future<bool> updateItemInCart(Product product) {
    // TODO: implement updateItemInCart
    throw UnimplementedError();
  }
}
