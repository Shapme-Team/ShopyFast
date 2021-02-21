import 'package:flutter/cupertino.dart';
import 'package:socket_io_client/socket_io_client.dart';

import '../../utils/constants/globals.dart';
import '../models/Cart.dart';
import '../models/Product.dart';
import '../models/order.dart';
import '../repositories/cartRepository.dart';

class CartProvider extends ChangeNotifier {
  Cart _cart;
  List<Order> _listOfOrders = [];
  CartReposotory _cartReposotory;
  Socket _socket;

  CartProvider(this._cartReposotory) {
    _cart = _cartReposotory.getCartData() ?? Cart(product: [], amount: 0.0);
    print('cart is null:  ${_cart == null}');
  }
  set setSocket(Socket socket) {
    _socket = socket;
    initSocket();
  }

  initSocket() {
    _socket?.on(globalCustomerId, (data) => onOrderStatusChange(data));
  }

  onOrderStatusChange(dynamic data) {
    var orderId = data['orderId'];
    var status = data['status'];

    _listOfOrders
        .firstWhere((element) => element.orderId == orderId, orElse: () => null)
        ?.deliveryStatus = status;

    notifyListeners();
    print('status change of orderId: $orderId with status: $status');
  }

  Cart get getCartItems => _cart;
  List<Order> get getListOfOrders => _listOfOrders;
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

  clearCartItems() {
    _cart.product.clear();
    _cart.amount = 0.0;
    _cartReposotory.addToCart(_cart);
    notifyListeners();
  }

//---------------------- order ----------------------

  fetchOrders() async {
    var conditionCheck = _listOfOrders != null && _listOfOrders.length > 0;

    if (!conditionCheck) {
      var orders = await _cartReposotory.getListOfOrders();
      // print('order response : ${orders.length}');
      if (orders == null) {
        _listOfOrders = [];
      } else
        _listOfOrders = orders;
      notifyListeners();
    } else {
      print('order data already exist: ${_listOfOrders.length}');
    }
  }

  Future<bool> addOrder(Order order) async {
    var orderRes = await _cartReposotory.addOrder(order);
    if (orderRes != null) {
      _listOfOrders.add(orderRes);
      notifyListeners();
      return true;
    }
    return false;
  }

  deleteOrder(Order order) {
    _cartReposotory.deleteOrder(order);
    _listOfOrders.removeWhere((element) => element.orderId == order.orderId);
    notifyListeners();
  }
}
