import 'package:ShopyFast/data/core/apiClient.dart';
import 'package:ShopyFast/domain/models/order.dart';

abstract class OrderDataSource {
  Future<List<Order>> getListOfOrders(String customerId);
  Future<List<Order>> getListOfRunningOrders(String customerId);
  Future<Order> addOrder(Order orderItem);
  Future<bool> deleteOrder(String orderId);
}

class OrderDataSourceApiImple extends OrderDataSource {
  final ApiClient _apiClient;
  OrderDataSourceApiImple(this._apiClient);

  @override
  Future<List<Order>> getListOfOrders(String customerId) async {
    try {
      var response = await _apiClient.get('order/customer/$customerId') as List;
      var orders = response.map((e) => Order.fromMap(e)).toList();
      // print('order response : ${orders.length}');

      return orders;
    } catch (err) {
      print('error while order fetch : $err');
      return null;
    }
  }

  Future<List<Order>> getListOfRunningOrders(String customerId) async {
    try {
      var response = await _apiClient
          .get('order/customer/$customerId?running=true') as List;
      var orders = response.map((e) => Order.fromMap(e)).toList();
      // print('order response : ${orders.length}');

      return orders;
    } catch (err) {
      print('error while order running fetch : $err');
      return null;
    }
  }

  @override
  Future<bool> deleteOrder(String orderId) async {
    try {
      await _apiClient.get('order/delete/$orderId');
      return true;
    } catch (err) {
      print('error while order fetch : $err');
      return null;
    }
  }

  @override
  Future<Order> addOrder(Order orderItem) async {
    try {
      var response = await _apiClient.post('order/new', orderItem.toMap());
      orderItem = Order.fromMap(response);
      print('order dateItme from data source: ${orderItem.dateTime}');
      return orderItem;
    } catch (err) {
      print('error while order add DS: $err');
      return null;
    }
  }
}
