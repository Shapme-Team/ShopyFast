class Customer {
  final String customerName;
  final num phoneNumber;
  final String customerId;
  final String address;

  Customer({
    this.customerName,
    this.phoneNumber,
    this.customerId,
    this.address,
  });

  Map<String, dynamic> toMap() {
    return {
      'customerName': customerName,
      'phoneNumber': phoneNumber,
      'customerId': customerId,
      'address': address,
    };
  }

  factory Customer.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Customer(
      customerName: map['customerName'] ?? '',
      phoneNumber: map['phoneNumber'] ?? 0,
      customerId: map['customerId'] ?? '',
      address: map['address'] ?? '',
    );
  }
}
