import 'package:ShopyFast/data/core/apiConstant.dart';
import 'package:ShopyFast/domain/repositories/orderRepository.dart';
import 'package:ShopyFast/utils/globals.dart';
import 'package:flutter/cupertino.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import '../models/Product.dart';
import '../models/order.dart';

class OrderProvider extends ChangeNotifier {
  List<Order> _listOfOrders = [];
  OrderRepository _orderRepository;
  Socket _socket;
  final socketUrl = ApiConstants.BASE_URL;
  Map<String, List<Product>> _mapOfProducts = {};
  List<Product> _listOfAllSortProducts = [];

  OrderProvider(this._orderRepository);

  List<Product> getProductsOfOrder(String orderId) {
    if (_mapOfProducts[orderId] != null) {
      return _mapOfProducts[orderId];
    } else
      return [];
  }

  List<Product> get getListOfAllSortProduct => _listOfAllSortProducts;

  setSocket() {
    var socketValue = _socket = IO.io(socketUrl, <String, dynamic>{
      'transports': ['websocket'],
      // "autoConnect": false
    });
    _socket.onConnect((data) {
      print('_socket connected !');
      _socket = socketValue;
      initSocket();
    });
  }

  initSocket() {
    if (globalCustomer?.uid != null)
      _socket?.on(globalCustomer.uid, (data) => onOrderStatusChange(data));
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

  List<Order> get getListOfOrders => _listOfOrders;

//---------------------- order ----------------------

  fetchOrders({bool fetchProductsAlso = false}) async {
    var conditionCheck = _listOfOrders != null && _listOfOrders.length > 0;

    if (!conditionCheck) {
      var orders = await _orderRepository.getListOfOrders(globalCustomer.uid);
      if (orders == null) {
        _listOfOrders = [];
      } else
        _listOfOrders = orders;
      notifyListeners();
      if (fetchProductsAlso) {
        print('------------------------------------- ***');
        print('inside product also fetch ');
        print('------------------------------------- ***');
        await getAllSortOrderedProducts();
      }
    } else {
      print('order data already exist: ${_listOfOrders.length}');
    }
  }

  Future<bool> addOrder(Order order) async {
    var orderRes = await _orderRepository.addOrder(order);
    if (orderRes != null) {
      _listOfOrders.add(orderRes);
      notifyListeners();
      return true;
    }
    return false;
  }

  deleteOrder(Order order) {
    _orderRepository.deleteOrder(order.orderId);
    _listOfOrders.removeWhere((element) => element.orderId == order.orderId);
    notifyListeners();
  }

  getProductOfOrder(Order order) async {
    if (_mapOfProducts[order.orderId] != null) return;

    var productIdsMap = order.productsIds;
    var listOfProducts = await Future.wait(productIdsMap.entries
        .map((e) => _orderRepository.getProductById(e.key)));

    listOfProducts.removeWhere((element) => element == null);
    listOfProducts.forEach((element) {
      element.quantity = productIdsMap[element.productId];
    });
    _mapOfProducts[order.orderId] = listOfProducts;
    // refreshProductsWithCartItems(listOfProducts);
    notifyListeners();
  }

// custom function
  getAllSortOrderedProducts() async {
    if (_listOfAllSortProducts.length > 0) return;
    if (_listOfOrders != null && _listOfOrders.length > 0) {
      List<Order> myOrders;
      List<Product> listOfProducts = [];

      if (_listOfOrders.length > 5) {
        myOrders = _listOfOrders.getRange(0, 4).toList();
      } else
        myOrders = _listOfOrders;

      await Future.wait(myOrders.map((order) => getProductOfOrder(order)));
      //-----------------------------------------
      myOrders.forEach((order) {
        listOfProducts.addAll(_mapOfProducts[order.orderId]);
      });

      print('------------------------------------- ***');
      print('my final sort products: ${listOfProducts.length}');
      print('------------------------------------- ***');
      listOfProducts.forEach((element) {
        element.quantity = 0;
      });
      _listOfAllSortProducts = orderProducts(listOfProducts);
      notifyListeners();
    }
  }

  List<Product> orderProducts(List<Product> products) {
    List<Product> productList = [];
    List<Product> finalProductList = [];
    Map<String, int> productMap = {};

    productList = [...products];

    productList.forEach((element) {
      if (productMap[element.productId] != null) {
        productMap[element.productId]++;
      } else
        productMap[element.productId] = 1;
    });

    productMap.entries.toList().sort((a, b) => b.value.compareTo(a.value));
    productMap.entries.forEach((productEntry) {
      var myProduct = productList
          .firstWhere((product) => product.productId == productEntry.key);
      finalProductList.add(myProduct);
    });
    return finalProductList;
  }
}
