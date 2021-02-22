import 'package:ShopyFast/data/core/apiClient.dart';
import 'package:ShopyFast/domain/models/customer.dart';

abstract class CustomerDataSource {
  Future<bool> addCustomer(Customer customer);
  Future<Customer> updateCustomer(Customer customer);
  Future<Customer> getCustomerData(String customerId);
}

class CustomerDataSourceApiImple extends CustomerDataSource {
  final ApiClient _apiClient;
  CustomerDataSourceApiImple(this._apiClient);

  @override
  Future<Customer> updateCustomer(Customer customer) async {
    try {
      print('customer id: ${customer.toString()}');

      var updatedCustomer = await _apiClient.put(
          'customer/update/${customer.customerId}', customer.toMap());
      print('updated customer : $updatedCustomer');
      return customer;
    } catch (err) {
      print('error while customer update : $err');
      return null;
    }
  }

  @override
  Future<bool> addCustomer(Customer customer) async {
    try {
      await _apiClient.post('customer/new', customer.toMap());
      return true;
    } catch (err) {
      print('error while customer add DS: $err');
      return false;
    }
  }

  @override
  Future<Customer> getCustomerData(String customerId) async {
    try {
      print('user id: $customerId');
      var response = await _apiClient.get('customer/$customerId');
      var customer = Customer.fromMap(response);
      return customer;
    } catch (err) {
      print('error while customer get DS: $err');
      return null;
    }
  }
}
