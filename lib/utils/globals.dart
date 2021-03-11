import 'package:ShopyFast/domain/models/customer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

enum MenuState { home, categories, orders, profile }
enum IncrementDecrement { INCREMENT, DECREMENT }

var globalCustomer = FirebaseAuth.instance.currentUser;
var globalCustomerData = Customer(
  address: 'Rohini sec 13, Kolimb Aprtment House no: a/34 block b ',
  customerId: globalCustomer?.uid,
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
