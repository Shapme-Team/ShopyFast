import 'package:ShopyFast/data/source/customerDataSource.dart';
import 'package:ShopyFast/data/source/hiveLocalDatabase.dart';
import 'package:ShopyFast/domain/models/customer.dart';

abstract class CustomerRepository {
  Future<Customer> getCustomerData(String uid);
  Future<bool> addCustomerData(Customer customer, [bool local]);
  Future<bool> updateCustomer(Customer customer);
  deleteCustomerLocally();
}

class CustomerRespositoryImp extends CustomerRepository {
  final CustomerDataSource _customerDataSource;
  final HiveLocalDatabase _hiveLocalDatabase;
  CustomerRespositoryImp(this._customerDataSource, this._hiveLocalDatabase);

  @override
  addCustomerData(Customer customer, [bool local]) async {
    try {
      var check = true;
      if (local == null) {
        check = await _customerDataSource.addCustomer(customer);
      } else
        print('only local ----------- ');
      if (check) {
        _hiveLocalDatabase.saveCustomerData(customer);
        return true;
      }
      return false;
    } catch (err) {
      print('error on adding customer: $err');
      return false;
    }
  }

  @override
  getCustomerData(String uid) async {
    try {
      var customerData;
      customerData = _hiveLocalDatabase.getCustomerData();
      if (customerData == null && uid != null) {
        customerData = await _customerDataSource.getCustomerData(uid);
        if (customerData != null) {
          _hiveLocalDatabase.saveCustomerData(customerData);
          return customerData;
        } else
          return null;
      }

      return customerData;
    } catch (err) {
      print('error on getting customer: $err');
      return null;
    }
  }

  @override
  updateCustomer(Customer customer) async {
    try {
      _hiveLocalDatabase.updateCustomer(customer);
      var customerRes = await _customerDataSource.updateCustomer(customer);
      return customerRes != null;
    } catch (err) {
      print('error on updating customer: $err');
      return null;
    }
  }

  @override
  deleteCustomerLocally() {
    _hiveLocalDatabase.deleteCustomerData();
  }
}
