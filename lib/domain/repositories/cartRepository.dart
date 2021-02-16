import 'package:ShopyFast/data/source/hiveLocalDatabase.dart';
import 'package:ShopyFast/domain/models/Cart.dart';
import 'package:ShopyFast/domain/models/customer.dart';
import 'package:ShopyFast/domain/models/order.dart';

abstract class CartReposotory {
  Cart getCartData();
  List<Order> getListOfOrders();
  Customer getCustomerData();

  bool addToCart(Cart cart);
  bool addOrderToDatabase(Order order);
  bool addCustomerData(Customer customer);
}

class CartReposotoryImp extends CartReposotory {
  HiveLocalDatabase _hiveLocalDatabase;
  CartReposotoryImp(this._hiveLocalDatabase);

  @override
  bool addCustomerData(Customer customer) {
    _hiveLocalDatabase.addCustomerData(customer);
    // update to cloud also;
  }

  @override
  bool addOrderToDatabase(Order order) {
    _hiveLocalDatabase.addOrderToDatabase(order);
    // update to cloud also
  }

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

  @override
  Customer getCustomerData() {
    var customerData = _hiveLocalDatabase.getCustomerData();
    if (customerData != null) return customerData;
    return null;
  }

  @override
  List<Order> getListOfOrders() {
    var orders = _hiveLocalDatabase.getListOfOrders();
    if (orders != null) return orders;
    return null;
  }
}
