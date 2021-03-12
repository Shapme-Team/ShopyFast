import '../../data/source/hiveLocalDatabase.dart';
import '../models/Cart.dart';

abstract class CartReposotory {
  Cart getCartData();
  bool addToCart(Cart cart);
}

class CartReposotoryImp extends CartReposotory {
  HiveLocalDatabase _hiveLocalDatabase;
  CartReposotoryImp(this._hiveLocalDatabase);

//------------------------------------ cart ---------

  @override
  bool addToCart(Cart cart) {
    var check = _hiveLocalDatabase.updateToCart(cart);
    return check;
  }

  @override
  Cart getCartData() {
    var cartData = _hiveLocalDatabase.getCartData();
    return cartData;
  }
}
