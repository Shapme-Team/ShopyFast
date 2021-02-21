import 'package:hive/hive.dart';
part 'gen/customer.g.dart';

@HiveType(typeId: 4)
class Customer {
  @HiveField(0)
  final String name;
  @HiveField(1)
  final num phoneNumber;
  @HiveField(2)
  final String customerId;
  @HiveField(3)
  final String address;
  @HiveField(4)
  final String email;

  Customer({
    this.name,
    this.phoneNumber,
    this.customerId,
    this.address,
    this.email,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'phoneNumber': phoneNumber,
      'customerId': customerId,
      'address': address,
      'email': email
    };
  }

  factory Customer.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Customer(
      name: map['name'] ?? '',
      phoneNumber: map['phoneNumber'] ?? 0,
      customerId: map['customerId'] ?? '',
      address: map['address'] ?? '',
      email: map['email'] ?? '',
    );
  }
}
