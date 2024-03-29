import 'dart:convert';
import 'package:hive/hive.dart';

part 'gen/Product.g.dart';

@HiveType(typeId: 2)
class Product {
  @HiveField(0)
  final String productName;
  @HiveField(1)
  final String description;
  @HiveField(2)
  final String productId;
  @HiveField(3)
  final num price;
  @HiveField(4)
  int quantity;
  @HiveField(5)
  final String imageUrl;
  @HiveField(6)
  final String category;
  @HiveField(7)
  final String subcategory;
  @HiveField(8)
  final num weight;
  @HiveField(9)
  final String measureUnit;
  Product({
    this.productName = '',
    this.description = '',
    this.productId = '',
    this.price = 0.0,
    this.quantity = 0,
    this.imageUrl,
    this.category = '',
    this.subcategory = '',
    this.weight = 0,
    this.measureUnit = '',
  });

  Map<String, dynamic> toMap() {
    return {
      '_id': productId,
      'productName': productName,
      'description': description,
      'price': price,
      'quantity': quantity,
      'images': imageUrl,
      'category': category,
      'subcategory': subcategory,
      'weight': weight,
      'measureUnit': measureUnit,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Product(
      productId: map['_id'],
      productName: map['productName'] ?? '',
      description: map['description'] ?? '',
      price: map['price'] ?? 0.0,
      quantity: map['quantity'] ?? 0,
      imageUrl: map['images'] ?? '',
      category: map['category'] ?? '',
      subcategory: map['subcategory'] ?? '',
      weight: map['weight'] ?? 0,
      measureUnit: map['measureUnit'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());
  factory Product.fromJson(String source) =>
      Product.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Product(productName: $productName, description: $description, productId: $productId, price: $price, quantity: $quantity, imageUrl: $imageUrl, category: $category, subcategory: $subcategory, weight: $weight, measureUnit: $measureUnit)';
  }

  Product copyWith({
    String productName,
    String description,
    String productId,
    num price,
    int quantity,
    String imageUrl,
    String category,
    String subcategory,
    num weight,
    String measureUnit,
  }) {
    return Product(
      productName: productName ?? this.productName,
      description: description ?? this.description,
      productId: productId ?? this.productId,
      price: price ?? this.price,
      quantity: quantity ?? this.quantity,
      imageUrl: imageUrl ?? this.imageUrl,
      category: category ?? this.category,
      subcategory: subcategory ?? this.subcategory,
      weight: weight ?? this.weight,
      measureUnit: measureUnit ?? this.measureUnit,
    );
  }
}

List<Product> demoProducts = [
  Product(
      productName: 'Mango',
      category: 'FnV',
      description: 'Greate for your health',
      imageUrl: 'assets/images/chakki_aata.webp',
      measureUnit: 'Kg',
      price: 50.00,
      productId: 'sldffwefd',
      quantity: 2,
      subcategory: 'Fruit',
      weight: 1),
  Product(
      productName: 'Edible Oil',
      category: 'Beverages',
      description: 'Greate for your health',
      imageUrl: 'assets/images/chakki_aata.webp',
      measureUnit: 'Kg',
      price: 50.00,
      productId: 'sldfdsfwefd',
      quantity: 2,
      subcategory: 'Oil',
      weight: 1),
  Product(
      productName: 'Aashirvad Atta',
      category: 'Grocery',
      description: 'Greate for your health',
      imageUrl: 'assets/images/chakki_aata.webp',
      measureUnit: 'Kg',
      price: 50.00,
      productId: 'sldfffdwefd',
      quantity: 2,
      subcategory: 'Aata',
      weight: 1),
];
