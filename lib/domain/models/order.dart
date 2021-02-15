import 'dart:convert';

import 'package:ShopyFast/domain/models/Product.dart';

class Order {
  final String customerName;
  final String orderId;
  final int phoneNumber;
  final String customerId;
  final num amount;
  final String address;
  final DateTime dateTime;
  String deliveryStatus;
  final List<Product> products;
  Order({
    this.orderId,
    this.customerName = '',
    this.phoneNumber = 0,
    this.customerId = '',
    this.amount = 0.0,
    this.address = '',
    this.dateTime,
    this.deliveryStatus = '',
    this.products = const [],
  });

  Map<String, dynamic> toMap() {
    return {
      'customerName': customerName,
      '_id': orderId,
      'phoneNumber': phoneNumber,
      'customerId': customerId,
      'amount': amount,
      'address': address,
      'dateTime': dateTime?.toIso8601String(),
      'deliveryStatus': deliveryStatus,
      'products': products?.map((x) => x?.toMap())?.toList(),
    };
  }

  factory Order.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Order(
      customerName: map['customerName'] ?? '',
      orderId: map['_id'] ?? '',
      phoneNumber: map['phoneNumber'] ?? 0,
      customerId: map['customerId'] ?? '',
      amount: map['amount'] ?? 0,
      address: map['address'] ?? '',
      dateTime: DateTime.parse(map['dateTime']),
      deliveryStatus: map['deliveryStatus'] ?? '',
      products: List<Product>.from(
          map['products']?.map((x) => Product.fromMap(x) ?? Product()) ??
              const []),
    );
  }

  @override
  String toString() {
    return 'Order( orderId: $orderId, customerName: $customerName, phoneNumber: $phoneNumber, customerId: $customerId, amount: $amount, address: $address, dateTime: $dateTime, deliveryStatus: $deliveryStatus, products: $products)';
  }

  String toJson() => json.encode(toMap());

  factory Order.fromJson(String source) => Order.fromMap(json.decode(source));
}

List<Order> dummyOrderItem = [
  Order(
      address: 'Alipur Delhi 36, near GLPS , hno 894 1st floor',
      amount: 500.9,
      customerId: 'new33df2',
      customerName: 'Akash Maurya',
      dateTime: DateTime.parse('2021-02-07T10:30:00.673+00:00'),
      deliveryStatus: "PROCESSING",
      orderId: 'new43jd0',
      phoneNumber: 4353535353,
      products: [
        Product(
          category: 'Fruits and vegitable',
          description:
              'item is very good for health and give you greate nutrients',
          imageUrl: 'assets/images/gorfers_tide.jpg',
          measureUnit: 'kg',
          price: 40,
          productId: 'flajsdflsf',
          productName: 'Apple (Kashmiri)',
          quantity: 4,
          subcategory: 'Fruits',
          weight: 1,
        ),
        Product(
          category: 'Fruits and vegitable',
          description:
              'item is very good for health and give you great nutrients',
          imageUrl: 'assets/images/gorfers_tide.jpg',
          measureUnit: 'kg',
          price: 40,
          productId: 'flajsdflsf',
          productName: 'Banana (Kashmiri)',
          quantity: 4,
          subcategory: 'Fruits',
          weight: 1,
        ),
        // Product(
        //   category: 'Fruits and vegitable',
        //   description:
        //       'item is very good for health and give you greate nutrients',
        //   imageUrl: 'assets/images/gorfers_tide.jpg',
        //   measureUnit: 'kg',
        //   price: 30,
        //   productId: 'flajsdflsf',
        //   productName: 'Potato (U.P)',
        //   quantity: 2,
        //   subcategory: 'Vegitable',
        //   weight: 1,
        // ),
      ]),
  Order(
      address: 'Alipur Delhi 36, near GLPS , hno 894 1st floor',
      amount: 894.0,
      customerId: 'new33df2',
      customerName: 'Sanjay Saini',
      dateTime: DateTime.parse('2021-02-07T11:20:00.673+00:00'),
      deliveryStatus: "PROCESSING",
      orderId: 'new43jd0',
      phoneNumber: 4353535353,
      products: [
        Product(
          category: 'Fruits and vegitable',
          description:
              'item is very good for health and give you greate nutrients',
          imageUrl: 'assets/images/gorfers_tide.jpg',
          measureUnit: 'kg',
          price: 40,
          productId: 'flajsdflsf',
          productName: 'Apple (Kashmiri)',
          quantity: 4,
          subcategory: 'Fruits',
          weight: 1,
        ),
        Product(
          category: 'Fruits and vegitable',
          description:
              'item is very good for health and give you great nutrients',
          imageUrl: 'assets/images/gorfers_tide.jpg',
          measureUnit: 'kg',
          price: 40,
          productId: 'flajsdflsf',
          productName: 'Banana (Kashmiri)',
          quantity: 4,
          subcategory: 'Fruits',
          weight: 1,
        ),
        Product(
          category: 'Fruits and vegitable',
          description:
              'item is very good for health and give you greate nutrients',
          imageUrl: 'assets/images/gorfers_tide.jpg',
          measureUnit: 'kg',
          price: 30,
          productId: 'flajsdflsf',
          productName: 'Potato (U.P)',
          quantity: 2,
          subcategory: 'Vegitable',
          weight: 1,
        ),
      ]),
  Order(
      address: 'Alipur Delhi 36, near GLPS , hno 894 1st floor',
      amount: 2098,
      customerId: 'new33df2',
      customerName: 'Rahul Kumar',
      dateTime: DateTime.parse('2021-02-07T11:30:00.673+00:00'),
      deliveryStatus: "PROCESSING",
      orderId: 'new43jd0',
      phoneNumber: 4353535353,
      products: [
        Product(
          category: 'Fruits and vegitable',
          description:
              'item is very good for health and give you greate nutrients',
          imageUrl: 'assets/images/gorfers_tide.jpg',
          measureUnit: 'kg',
          price: 40,
          productId: 'flajsdflsf',
          productName: 'Apple (Kashmiri)',
          quantity: 4,
          subcategory: 'Fruits',
          weight: 1,
        ),
        Product(
          category: 'Fruits and vegitable',
          description:
              'item is very good for health and give you great nutrients',
          imageUrl: 'assets/images/gorfers_tide.jpg',
          measureUnit: 'kg',
          price: 40,
          productId: 'flajsdflsf',
          productName: 'Banana (Kashmiri)',
          quantity: 4,
          subcategory: 'Fruits',
          weight: 1,
        ),
        Product(
          category: 'Fruits and vegitable',
          description:
              'item is very good for health and give you greate nutrients',
          imageUrl: 'assets/images/gorfers_tide.jpg',
          measureUnit: 'kg',
          price: 30,
          productId: 'flajsdflsf',
          productName: 'Potato (U.P)',
          quantity: 2,
          subcategory: 'Vegitable',
          weight: 1,
        ),
      ]),
  Order(
      address: 'Alipur Delhi 36, near GLPS , hno 894 1st floor',
      amount: 223.00,
      customerId: 'new33df2',
      customerName: 'Shruti sain',
      dateTime: DateTime.parse('2021-02-07T11:15:00.673+00:00'),
      deliveryStatus: "PROCESSING",
      orderId: 'new43jd0',
      phoneNumber: 4353535353,
      products: [
        Product(
          category: 'Fruits and vegitable',
          description:
              'item is very good for health and give you greate nutrients',
          imageUrl: 'assets/images/gorfers_tide.jpg',
          measureUnit: 'kg',
          price: 40,
          productId: 'flajsdflsf',
          productName: 'Apple (Kashmiri)',
          quantity: 4,
          subcategory: 'Fruits',
          weight: 1,
        ),
        Product(
          category: 'Fruits and vegitable',
          description:
              'item is very good for health and give you great nutrients',
          imageUrl: 'assets/images/gorfers_tide.jpg',
          measureUnit: 'kg',
          price: 40,
          productId: 'flajsdflsf',
          productName: 'Banana (Kashmiri)',
          quantity: 4,
          subcategory: 'Fruits',
          weight: 1,
        ),
        Product(
          category: 'Fruits and vegitable',
          description:
              'item is very good for health and give you greate nutrients',
          imageUrl: 'assets/images/gorfers_tide.jpg',
          measureUnit: 'kg',
          price: 30,
          productId: 'flajsdflsf',
          productName: 'Potato (U.P)',
          quantity: 2,
          subcategory: 'Vegitable',
          weight: 1,
        ),
      ]),
  Order(
      address: 'Alipur Delhi 36, near GLPS , hno 894 1st floor',
      amount: 1250.0,
      customerId: 'new33df2',
      customerName: 'Ramesh sharma ',
      dateTime: DateTime.parse('2021-02-07T11:01:01.673+00:00'),
      deliveryStatus: "ON WAY",
      orderId: 'new43jd0',
      phoneNumber: 4353535353,
      products: [
        Product(
          category: 'Fruits and vegitable',
          description:
              'item is very good for health and give you greate nutrients',
          imageUrl: 'assets/images/gorfers_tide.jpg',
          measureUnit: 'kg',
          price: 40,
          productId: 'flajsdflsf',
          productName: 'Apple (Kashmiri)',
          quantity: 4,
          subcategory: 'Fruits',
          weight: 1,
        ),
        Product(
          category: 'Fruits and vegitable',
          description:
              'item is very good for health and give you greate nutrients',
          imageUrl: 'assets/images/gorfers_tide.jpg',
          measureUnit: 'kg',
          price: 40,
          productId: 'flajsdflsf',
          productName: 'Banana (Kashmiri)',
          quantity: 4,
          subcategory: 'Fruits',
          weight: 1,
        ),
        Product(
          category: 'Fruits and vegitable',
          description:
              'item is very good for health and give you greate nutrients',
          imageUrl: 'assets/images/gorfers_tide.jpg',
          measureUnit: 'kg',
          price: 30,
          productId: 'flajsdflsf',
          productName: 'Potato (Kashmiri)',
          quantity: 2,
          subcategory: 'Vegitable',
          weight: 1,
        ),
      ]),
];
