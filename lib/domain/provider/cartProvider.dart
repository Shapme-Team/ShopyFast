import 'package:ShopyFast/domain/models/Cart.dart';
import 'package:ShopyFast/domain/models/Product.dart';
import 'package:flutter/cupertino.dart';

class CartProvider extends ChangeNotifier {
  Cart _cart = Cart(amount: 0, product: []);
  CartProvider();

  Cart get getCartItems => _cart;
  int get getNoOfItemsInCart => _cart?.product?.length ?? 0;

  addItemToCart(Product product) {
    if (product.quantity > 1) {
      _cart.product
          .firstWhere((element) => element.productId == product.productId)
          ?.quantity = product.quantity;
    } else {
      _cart.product.add(product);
    }
    _cart.amount += product.price;
    _cart.amount = double.parse(_cart.amount.toStringAsFixed(2));
    notifyListeners();
  }

  removeItemFromCart(Product product) {
    // var myProduct = product.copyWith();
    if (product.quantity < 1) {
      _cart.product
          .removeWhere((element) => element.productId == product.productId);
    } else {
      _cart.product
          .firstWhere((element) => element.productId == product.productId,
              orElse: () => null)
          ?.quantity = product.quantity;
    }
    _cart.amount -= product.price;
    // implement add to local database
    _cart.amount = double.parse(_cart.amount.toStringAsFixed(2));
    notifyListeners();
  }
}
