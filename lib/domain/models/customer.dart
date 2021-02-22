import 'package:hive/hive.dart';

part 'gen/customer.g.dart';

@HiveType(typeId: 4)
class Customer {
  @HiveField(0)
  String name;
  @HiveField(1)
  num phoneNumber;
  @HiveField(2)
  String customerId;
  @HiveField(3)
  String address;
  @HiveField(4)
  String email;

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
      '_id': customerId,
      'address': address,
      'emailId': email
    };
  }
  // _id: id,
  //               name,
  //               phoneNumber,
  //               emailId,
  //               address,

  factory Customer.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Customer(
      name: map['name'] ?? '',
      phoneNumber: map['phoneNumber'] ?? 0,
      customerId: map['_id'] ?? '',
      address: map['address'] ?? '',
      email: map['emailId'] ?? '',
    );
  }

  @override
  String toString() {
    return 'Customer(name: $name, phoneNumber: $phoneNumber, customerId: $customerId, address: $address, email: $email)';
  }
}
