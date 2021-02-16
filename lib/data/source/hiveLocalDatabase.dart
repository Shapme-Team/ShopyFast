import 'package:ShopyFast/domain/models/Cart.dart';
import 'package:ShopyFast/domain/models/Product.dart';
import 'package:ShopyFast/domain/models/customer.dart';
import 'package:ShopyFast/domain/models/order.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as pathProvider;

const ORDER_BOX = 'order';
const CART_BOX = 'cart';
const CUSTOMER_BOX = 'customer';

abstract class HiveLocalDatabase {
  Cart getCartData();
  bool updateToCart(Cart cart);

  List<Order> getListOfOrders();
  bool addOrderToDatabase(Order order);

  Customer getCustomerData();
  bool addCustomerData(Customer customer);
}

class HiveLocalDatabaseImpl extends HiveLocalDatabase {
  HiveLocalDatabaseImpl._();
  Box orderBox;
  Box<Cart> cartBox;

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
    orderBox = await Hive.openBox(ORDER_BOX);
    cartBox = await Hive.openBox(CART_BOX);
  }

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
  addOrderToDatabase(Order order) {
    // TODO: implement addOrderToDatabase
    throw UnimplementedError();
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

  @override
  List<Order> getListOfOrders() {
    // TODO: implement getListOfOrders
    throw UnimplementedError();
  }

  @override
  addCustomerData(Customer customer) {
    // TODO: implement addCustomerData
    throw UnimplementedError();
  }

  @override
  Customer getCustomerData() {
    // TODO: implement getCustomerData
    throw UnimplementedError();
  }
}
