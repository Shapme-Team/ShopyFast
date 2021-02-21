import 'package:ShopyFast/domain/models/Cart.dart';
import 'package:ShopyFast/domain/models/order.dart';
import 'package:ShopyFast/domain/provider/cartProvider.dart';
import 'package:ShopyFast/utils/constants/globals.dart';
import 'package:ShopyFast/utils/constants/size_config.dart';
import 'package:ShopyFast/view/screens/checkout/checkoutScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../components/default_button.dart';

class CheckoutCard extends StatelessWidget {
  final Cart cart;

  CheckoutCard(this.cart);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: getWidth(15),
        horizontal: getWidth(30),
      ),
      // height: 174,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, -15),
            blurRadius: 20,
            color: Color(0xFFDADADA).withOpacity(0.15),
          )
        ],
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text.rich(
                  TextSpan(
                    text: "Total:\n",
                    children: [
                      TextSpan(text: '₹', style: TextStyle(fontSize: 22)),
                      TextSpan(
                        text: ' ${cart.amount}',
                        style: TextStyle(fontSize: 16, color: Colors.black),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: getWidth(190),
                  child: DefaultButton(
                    text: "Check Out",
                    press: () async {
                      var resCheck = await Navigator.of(context).pushNamed(
                          CheckoutScreen.routeName,
                          arguments: CheckoutScreenArg(Order(
                              amount: cart.amount,
                              customer: globalCustomerData,
                              deliveryStatus: 'PROCESSING',
                              products: cart.product,
                              customerId: globalCustomerId)));
                      if (resCheck != null && resCheck) {
                        Provider.of<CartProvider>(context, listen: false)
                            .clearCartItems();
                        Scaffold.of(context).showSnackBar(SnackBar(
                          padding:
                              EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          backgroundColor: Theme.of(context).primaryColor,
                          content: Text(
                            'Order Placed Successfully !!',
                            style: TextStyle(fontSize: 18),
                          ),
                        ));
                      }
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
