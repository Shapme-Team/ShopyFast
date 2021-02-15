import 'dart:convert';
import 'package:ShopyFast/domain/models/Product.dart';
import 'package:ShopyFast/domain/models/customer.dart';
import 'package:hive/hive.dart';

part 'order.g.dart';
@HiveType(typeId : 1)
class Order {
  @HiveField(0)
  final String orderId;
  @HiveField(1)
  final Customer customer;
  @HiveField(2)
  final num amount;
  @HiveField(3)
  final DateTime dateTime;
  @HiveField(4)
  String deliveryStatus;
  @HiveField(5)
  final List<Product> products;

  Order({
    this.customer,
    this.orderId,
    this.amount = 0.0,
    this.dateTime,
    this.deliveryStatus = '',
    this.products = const [],
  });

  Map<String, dynamic> toMap() {
    return {
      'orderId': orderId,
      'amount': amount,
      'customer': customer?.toMap(),
      'dateTime': dateTime?.millisecondsSinceEpoch,
      'deliveryStatus': deliveryStatus,
      'products': products?.map((x) => x?.toMap())?.toList(),
    };
  }

  factory Order.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Order(
      orderId: map['orderId'] ?? '',
      amount: map['amount'] ?? 0,
      customer: Customer.fromMap(map['customer']) ?? Customer(),
      dateTime: DateTime.fromMillisecondsSinceEpoch(map['dateTime']),
      deliveryStatus: map['deliveryStatus'] ?? '',
      products: List<Product>.from(
          map['products']?.map((x) => Product.fromMap(x) ?? Product()) ??
              const []),
    );
  }

  String toJson() => json.encode(toMap());

  factory Order.fromJson(String source) => Order.fromMap(json.decode(source));
}

List<Order> dummyOrderItem = [
  Order(
    amount: 200,
    dateTime: DateTime.now(),
    deliveryStatus: 'Processing',
    orderId: '123456',
    products: [
      Product(
          productName: 'Mango',
          category: 'FnV',
          description: 'Greate for your health',
          imageUrl: 'assets/images/glap.png',
          measureUnit: 'Kg',
          price: 50.00,
          productId: 'sldffwefd',
          quantity: 2,
          subcategory: 'Fruit',
          weight: 1),
    ],
  ),
  Order(
    amount: 1030,
    dateTime: DateTime.now(),
    deliveryStatus: 'Processing',
    orderId: '123456',
    products: [
      Product(
          productName: 'Mango',
          category: 'FnV',
          description: 'Greate for your health',
          imageUrl: 'assets/images/glap.png',
          measureUnit: 'Kg',
          price: 50.00,
          productId: 'sldffwefd',
          quantity: 2,
          subcategory: 'Fruit',
          weight: 1),
    ],
  ),
  Order(
    amount: 330,
    dateTime: DateTime.now(),
    deliveryStatus: 'Processing',
    orderId: '123456',
    products: [
      Product(
          productName: 'Mango',
          category: 'FnV',
          description: 'Greate for your health',
          imageUrl: 'assets/images/glap.png',
          measureUnit: 'Kg',
          price: 50.00,
          productId: 'sldffwefd',
          quantity: 2,
          subcategory: 'Fruit',
          weight: 1),
    ],
  ),
  Order(
    amount: 500,
    dateTime: DateTime.now(),
    deliveryStatus: 'Processing',
    orderId: '123456',
    products: [
      Product(
          productName: 'Mango',
          category: 'FnV',
          description: 'Greate for your health',
          imageUrl: 'assets/images/glap.png',
          measureUnit: 'Kg',
          price: 50.00,
          productId: 'sldffwefd',
          quantity: 2,
          subcategory: 'Fruit',
          weight: 1),
    ],
  ),
  Order(
    amount: 430,
    dateTime: DateTime.now(),
    deliveryStatus: 'Processing',
    orderId: '123456',
    products: [
      Product(
          productName: 'Mango',
          category: 'FnV',
          description: 'Greate for your health',
          imageUrl: 'assets/images/glap.png',
          measureUnit: 'Kg',
          price: 50.00,
          productId: 'sldffwefd',
          quantity: 2,
          subcategory: 'Fruit',
          weight: 1),
      Product(
          productName: 'Aashirvad Atta',
          category: 'Grocery',
          description: 'Greate for your health',
          imageUrl: 'assets/images/aashirvaad-atta-whole-wheat.jpg',
          measureUnit: 'Kg',
          price: 50.00,
          productId: 'sldfffdwefd',
          quantity: 2,
          subcategory: 'Aata',
          weight: 1),
    ],
  ),
];
