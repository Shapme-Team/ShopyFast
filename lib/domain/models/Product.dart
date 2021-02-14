import 'dart:convert';

class Product {
  final String productName;
  final String description;
  final String productId;
  final num price;
  int quantity;
  final String imageUrl;
  final String category;
  final String subcategory;
  final num weight;
  final String measureUnit;
  Product({
    this.productName = '',
    this.description = '',
    this.productId = '',
    this.price = 0.0,
    this.quantity = 0,
    this.imageUrl = '',
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
      'imageUrl': imageUrl,
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
      imageUrl: map['imageUrl'] ?? '',
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
}

List<Product> demoProducts = [
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
      productName: 'Edible Oil',
      category: 'Beverages',
      description: 'Greate for your health',
      imageUrl: 'assets/images/glap.png',
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
      imageUrl: 'assets/images/aashirvaad-atta-whole-wheat.jpg',
      measureUnit: 'Kg',
      price: 50.00,
      productId: 'sldfffdwefd',
      quantity: 2,
      subcategory: 'Aata',
      weight: 1),
];
