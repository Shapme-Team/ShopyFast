import 'dart:async';

import 'package:ShopyFast/utils/globals.dart';

import '../../data/source/hiveLocalDatabase.dart';
import '../../data/source/orderDataSource.dart';
import '../models/Cart.dart';
import '../models/customer.dart';
import '../models/order.dart';

abstract class CartReposotory {
  Cart getCartData();
  bool addToCart(Cart cart);

  FutureOr<List<Order>> getListOfOrders();
  Future<Order> addOrder(Order order);
  bool deleteOrder(Order order);
}

class CartReposotoryImp extends CartReposotory {
  HiveLocalDatabase _hiveLocalDatabase;
  OrderDataSource _orderDataSource;
  CartReposotoryImp(this._hiveLocalDatabase, this._orderDataSource);

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

//------------------------------------ customer ---------
  @override
  Customer getCustomerData() {
    var customerData = _hiveLocalDatabase.getCustomerData();
    if (customerData != null) return customerData;
    return null;
  }

  @override
  bool addCustomerData(Customer customer) {
    _hiveLocalDatabase.saveCustomerData(customer);
    // update to cloud also;
  }
//------------------------------------ orders ---------

  @override
  Future<Order> addOrder(Order order) async {
    var orderValue = await _orderDataSource.addOrder(order);
    //-------------- currently : local storage of orders is non efficient

    // if (orderValue != null) {
    //   _hiveLocalDatabase.addOrderToDatabase(orderValue);
    // }
    return orderValue;
  }

  @override
  Future<List<Order>> getListOfOrders() async {
    List<Order> orders;
    // orders = _hiveLocalDatabase.getListOfOrders();
    orders = await _orderDataSource.getListOfOrders(globalCustomer.uid);

    //-------------- currently :  local fetch of orders is non efficient

    // orders = _hiveLocalDatabase.getListOfOrders();
    // if (orders != null && orders.length > 0) {
    //   var apiOrders =
    //       await _orderDataSource.getListOfRunningOrders(globalCustomer.uid);
    //   print('api orders length: ${apiOrders.length} ');
    //   orders = [...apiOrders, ...orders];
    // } else {
    //   orders = await _orderDataSource.getListOfOrders(globalCustomer.uid);
    //   orders.forEach((order) {
    //     if(order.deliveryStatus == StatusConstant.DONE )
    //     _hiveLocalDatabase.addOrderToDatabase(order);
    //   });
    // }
    // deleteOrder(orders[0]);
    if (orders == null) orders = [];
    return orders;
  }

  @override
  bool deleteOrder(Order order) {
    var check = _hiveLocalDatabase.deleteOrder(order);
    return check;
  }
}
