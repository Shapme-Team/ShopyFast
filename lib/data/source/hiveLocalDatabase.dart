import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as pathProvider;

import '../../domain/models/Cart.dart';
import '../../domain/models/Product.dart';
import '../../domain/models/customer.dart';
import '../../domain/models/order.dart';

const ORDER_BOX = 'order';
const CART_BOX = 'cart';
const CUSTOMER_BOX = 'customer';

abstract class HiveLocalDatabase {
  Cart getCartData();
  bool updateToCart(Cart cart);

  List<Order> getListOfOrders();
  bool addOrderToDatabase(Order order);
  bool deleteOrder(Order order);

  Customer getCustomerData();
  saveCustomerData(Customer customer);
  bool updateCustomer(Customer customer);
  bool deleteCustomerData();
}

class HiveLocalDatabaseImpl extends HiveLocalDatabase {
  HiveLocalDatabaseImpl._();
  Box<Order> orderBox;
  Box<Cart> cartBox;
  Box<Customer> customerBox;

  static Future<HiveLocalDatabaseImpl> createDatabase() async {
    var _instance = HiveLocalDatabaseImpl._();
    await _instance._initHive();
    return _instance;
  }

  _initHive() async {
    final appDocumentDir =
        await pathProvider.getApplicationDocumentsDirectory();
    Hive.init(appDocumentDir.path);

    Hive.registerAdapter(OrderAdapter());
    Hive.registerAdapter(ProductAdapter());
    Hive.registerAdapter(CartAdapter());
    Hive.registerAdapter(CustomerAdapter());

    orderBox = await Hive.openBox(ORDER_BOX);
    cartBox = await Hive.openBox(CART_BOX);
    customerBox = await Hive.openBox(CUSTOMER_BOX);
  }
//------------------------------------ cart

  @override
  bool updateToCart(Cart cart) {
    try {
      cartBox.put(0, cart);
      return true;
    } catch (err) {
      print('error: hive : $err');
      return false;
    }
  }

  @override
  Cart getCartData() {
    try {
      var preCart = cartBox.get(0);

      return preCart;
    } catch (err) {
      print('error: hive : $err');
      return null;
    }
  }

//------------------------------------ customer
  @override
  saveCustomerData(Customer customer) {
    print('customerId: hive ${customer.customerId}');

    customerBox.put(0, customer);
  }

  @override
  Customer getCustomerData() {
    var customer;
    if (customerBox.values.length > 0) customer = customerBox.getAt(0);
    print('custoerm hive: ${customer.toString()}');
    return customer;
  }

  @override
  bool updateCustomer(Customer customer) {
    customerBox.putAt(0, customer);
    return true;
  }

  @override
  bool deleteCustomerData() {
    if (customerBox.values.length > 0) customerBox.deleteAt(0);
    return true;
  }

//------------------------------------ order
  @override
  List<Order> getListOfOrders() {
    var orders = orderBox.values.toList();
    orders.forEach((element) {
      var dateTime = element.dateTime.isUtc;

      print('date : ${element.dateTime} : $dateTime');
    });
    return orders;
  }

  @override
  bool addOrderToDatabase(Order order) {
    try {
      orderBox.add(order);
      print('order date is: ${order.dateTime}');
      return true;
    } catch (err) {
      print('error: hive : $err');
      return false;
    }
  }

  @override
  bool deleteOrder(Order order) {
    try {
      for (int i = 0; i < orderBox.length; i++) {
        var newBox = orderBox.getAt(i);
        if (newBox.orderId == order.orderId) {
          orderBox.deleteAt(i);
          return true;
        }
        // orderBox.deleteAt(i);
      }
      print('all orders deleted');
      return false;
    } catch (err) {
      print('error on delete: $err');
      return false;
    }
  }
}
