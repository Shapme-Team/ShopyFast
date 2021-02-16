import 'package:ShopyFast/domain/models/Cart.dart';
import 'package:ShopyFast/domain/models/Product.dart';
import 'package:ShopyFast/domain/repositories/cartRepository.dart';
import 'package:flutter/cupertino.dart';

class CartProvider extends ChangeNotifier {
  Cart _cart;
  CartReposotory _cartReposotory;
  CartProvider(this._cartReposotory) {
    _cart = _cartReposotory.getCartData() ?? Cart(product: [], amount: 0.0);
    print('cart is null:  ${_cart == null}');
  }

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
    _cartReposotory.addToCart(_cart);
    notifyListeners();
  }

  directRemoveFromCart(Product product) {
    _cart.product
        ?.removeWhere((element) => element.productId == product.productId);
    _cart.amount -= product.price * product.quantity;
    _cart.amount = double.parse(_cart.amount.toStringAsFixed(2));
    _cartReposotory.addToCart(_cart);
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
    _cartReposotory.addToCart(_cart);

    if (_cart.product.isEmpty) {
      _cart.amount = 0.0;
    }

    notifyListeners();
  }
}
