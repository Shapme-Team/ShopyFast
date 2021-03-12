import 'package:ShopyFast/data/source/orderDataSource.dart';
import 'package:ShopyFast/domain/models/Product.dart';
import 'package:ShopyFast/domain/models/order.dart';

abstract class OrderRepository {
  Future<List<Order>> getListOfOrders(String customerId);
  Future<bool> deleteOrder(String orderId);
  Future<Order> addOrder(Order orderItem);
  Future<Product> getProductById(String id);
  // Future<List<Order>> getListOfRunningOrders(String customerId);
}

class OrderRepositoryImple extends OrderRepository {
  final OrderDataSource _orderDataSource;

  OrderRepositoryImple(this._orderDataSource);

  @override
  Future<Order> addOrder(Order orderItem) async {
    var order = await _orderDataSource.addOrder(orderItem);
    return order;
  }

  @override
  Future<bool> deleteOrder(String orderId) async {
    var check = await _orderDataSource.deleteOrder(orderId);
    return check;
  }

  @override
  Future<List<Order>> getListOfOrders(String customerId) async {
    var listOfOrders = await _orderDataSource.getListOfOrders(customerId);
    return listOfOrders;
  }

  Future<Product> getProductById(String id) async {
    var product = await _orderDataSource.getProductById(id);
    return product;
  }
  // @override
  // Future<List<Order>> getListOfRunningOrders(String customerId) async {
  //   var
  // }
}
