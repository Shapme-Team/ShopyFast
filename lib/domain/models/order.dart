import 'dart:convert';

import 'package:ShopyFast/domain/models/Product.dart';
import 'package:ShopyFast/domain/models/customer.dart';

class Order {
  final String orderId;
  final Customer customer;
  final num amount;
  final DateTime dateTime;
  String deliveryStatus;
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
