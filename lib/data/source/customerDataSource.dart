import 'package:ShopyFast/data/core/apiClient.dart';
import 'package:ShopyFast/domain/models/customer.dart';

abstract class CustomerDataSource {
  Future<Customer> addCustomer(Customer customer);
  Future<Customer> updateCustomer(String customerId);
}

class CustomerDataSourceApiImple extends CustomerDataSource {
  final ApiClient _apiClient;
  CustomerDataSourceApiImple(this._apiClient);

  @override
  Future<Customer> updateCustomer(String customerId) async {
    try {
      var updatedcustomer = await _apiClient.put('customer/delete/$customerId');
      print('updated customer : $updatedcustomer');
      return updatedcustomer;
    } catch (err) {
      print('error while order fetch : $err');
      return null;
    }
  }

  @override
  Future<Customer> addCustomer(Customer customer) async {
    try {
      var response = await _apiClient.post('customer/new', customer.toMap());
      customer = Customer.fromMap(response);
      print(
          'Custoemr Created Id: ${customer.customerId} Name:${customer.name}');
      return customer;
    } catch (err) {
      print('error while order add DS: $err');
      return null;
    }
  }
}
