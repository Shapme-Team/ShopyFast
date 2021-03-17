import 'dart:convert';

import 'package:ShopyFast/utils/globals.dart';
import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';

import 'Product.dart';
import 'customer.dart';

part 'gen/order.g.dart';

@HiveType(typeId: 1)
class Order {
  @HiveField(0)
  String orderId;
  @HiveField(1)
  final Customer customer;
  @HiveField(2)
  final num amount;
  @HiveField(3)
  DateTime dateTime;
  @HiveField(4)
  String deliveryStatus;
  @HiveField(5)
  final Map<String, int> productsIds;
  @HiveField(6)
  final String customerId;

  Order({
    @required this.customerId,
    this.customer,
    this.orderId,
    this.amount = 0.0,
    this.dateTime,
    this.deliveryStatus = '',
    this.productsIds = const {},
  });

  Map<String, dynamic> toMap() {
    return {
      // '_id': orderId,
      'customerId': customerId,
      'amount': amount,
      'customer': customer?.toMap(),
      // 'dateTime': dateTime?.millisecondsSinceEpoch,
      'deliveryStatus': deliveryStatus,
      'productsIds': productsIds,
    };
  }

  factory Order.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Order(
      customerId: map['customerId'],
      orderId: map['_id'] ?? '',
      amount: map['amount'] ?? 0,
      customer: Customer.fromMap(map['customer']) ?? Customer(),
      dateTime: DateTime.parse(map['dateTime']),
      deliveryStatus: map['deliveryStatus'] ?? '',
      productsIds: Map.from(map['productsIds'] ?? const {}),
    );
  }

  String toJson() => json.encode(toMap());

  factory Order.fromJson(String source) => Order.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Order(orderId: $orderId, customer: $customer, amount: $amount, dateTime: $dateTime, deliveryStatus: $deliveryStatus, productsIds: $productsIds, customerId: $customerId)';
  }
}

// List<Order> dummyOrderItem = [
//   Order(
//     customerId: globalCustomer.uid,
//     amount: 200,
//     dateTime: DateTime.now(),
//     deliveryStatus: 'Processing',
//     orderId: '123456',
//     products: [
//       Product(
//           productName: 'Mango',
//           category: 'FnV',
//           description: 'Greate for your health',
//           imageUrl: 'assets/images/glap.png',
//           measureUnit: 'Kg',
//           price: 50.00,
//           productId: 'sldffwefd',
//           quantity: 2,
//           subcategory: 'Fruit',
//           weight: 1),
//     ],
//   ),
//   Order(
//     customerId: globalCustomer.uid,
//     amount: 1030,
//     dateTime: DateTime.now(),
//     deliveryStatus: 'Processing',
//     orderId: '123456',
//     products: [
//       Product(
//           productName: 'Mango',
//           category: 'FnV',
//           description: 'Greate for your health',
//           imageUrl: 'assets/images/glap.png',
//           measureUnit: 'Kg',
//           price: 50.00,
//           productId: 'sldffwefd',
//           quantity: 2,
//           subcategory: 'Fruit',
//           weight: 1),
//     ],
//   ),
//   Order(
//     customerId: globalCustomer.uid,
//     amount: 330,
//     dateTime: DateTime.now(),
//     deliveryStatus: 'Processing',
//     orderId: '123456',
//     products: [
//       Product(
//           productName: 'Mango',
//           category: 'FnV',
//           description: 'Greate for your health',
//           imageUrl: 'assets/images/glap.png',
//           measureUnit: 'Kg',
//           price: 50.00,
//           productId: 'sldffwefd',
//           quantity: 2,
//           subcategory: 'Fruit',
//           weight: 1),
//     ],
//   ),
//   Order(
//     customerId: globalCustomer.uid,
//     amount: 500,
//     dateTime: DateTime.now(),
//     deliveryStatus: 'Processing',
//     orderId: '123456',
//     products: [
//       Product(
//           productName: 'Mango',
//           category: 'FnV',
//           description: 'Greate for your health',
//           imageUrl: 'assets/images/glap.png',
//           measureUnit: 'Kg',
//           price: 50.00,
//           productId: 'sldffwefd',
//           quantity: 2,
//           subcategory: 'Fruit',
//           weight: 1),
//     ],
//   ),
//   Order(
//     customerId: globalCustomer.uid,
//     amount: 430,
//     dateTime: DateTime.now(),
//     deliveryStatus: 'Processing',
//     orderId: '123456',
//     products: [
//       Product(
//           productName: 'Mango',
//           category: 'FnV',
//           description: 'Greate for your health',
//           imageUrl: 'assets/images/glap.png',
//           measureUnit: 'Kg',
//           price: 50.00,
//           productId: 'sldffwefd',
//           quantity: 2,
//           subcategory: 'Fruit',
//           weight: 1),
//       Product(
//           productName: 'Aashirvad Atta',
//           category: 'Grocery',
//           description: 'Greate for your health',
//           imageUrl: 'assets/images/aashirvaad-atta-whole-wheat.jpg',
//           measureUnit: 'Kg',
//           price: 50.00,
//           productId: 'sldfffdwefd',
//           quantity: 2,
//           subcategory: 'Aata',
//           weight: 1),
//     ],
//   ),
// ];
