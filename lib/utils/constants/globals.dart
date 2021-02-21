import 'package:ShopyFast/domain/models/customer.dart';

enum MenuState { home, categories, orders, profile }

var globalCustomerId = 'dummy_customer_id';
var globalCustomerData = Customer(
  address: 'Rohini sec 13, Kolimb Aprtment House no: a/34 block b ',
  customerId: globalCustomerId,
  name: 'Akash Maurya',
  phoneNumber: 9563423456,
);

/*
  Provider.of<CartProvider>(context, listen: false)
                          .addOrder(Order(
                        amount: cart.amount,
                        customer: globalCustomerData,
                        deliveryStatus: 'PROCESSING',
                        products: cart.product
                      ));
*/
