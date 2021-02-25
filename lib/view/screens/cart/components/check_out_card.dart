import 'package:ShopyFast/view/screens/bottomNavScreens/profile/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../domain/models/order.dart';
import '../../../../domain/provider/cartProvider.dart';
import '../../../../utils/constants/size_config.dart';

import '../../../components/default_button.dart';
import '../../checkout/checkoutScreen.dart';

class CheckoutCard extends StatelessWidget {
  final Order order;
  CheckoutCard(this.order);

  bool _availableForOrder;
  // bool addressAvailable;

  @override
  Widget build(BuildContext context) {
    _availableForOrder = order.customer?.customerId != null &&
        order.customer.address != null &&
        order.customer.address.isNotEmpty &&
        order.customer.phoneNumber != null;
    var _checkoutButton = DefaultButton(
      text: 'Order Items',
      press: () async => onClickCheckout(context),
    );
    var goToProfileButton = RaisedButton(
      color: Theme.of(context).accentColor,
      child: Text(
        'Complete you profile',
        style: TextStyle(color: Colors.white, fontSize: 18),
      ),
      onPressed: () async => onClickProfilePage(context),
    );
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
                    style: TextStyle(
                        fontSize: 14, color: Theme.of(context).accentColor),
                    children: [
                      TextSpan(
                          text: '₹',
                          style: TextStyle(
                              fontSize: 22,
                              color: Theme.of(context).accentColor,
                              fontWeight: FontWeight.w600)),
                      TextSpan(
                        text: ' ${order.amount}',
                        style: TextStyle(
                            fontSize: 18,
                            color: Theme.of(context).accentColor,
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: getWidth(190),
                  child:
                      _availableForOrder ? _checkoutButton : goToProfileButton,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  onClickProfilePage(BuildContext context) {
    Navigator.of(context).pop(ProfileScreen.routeName);
  }

  onClickCheckout(BuildContext context) async {
    if (_availableForOrder) {
      var resCheck = await Navigator.of(context).pushNamed(
          CheckoutScreen.routeName,
          arguments: CheckoutScreenArg(order));

      if (resCheck != null && resCheck) {
        Provider.of<CartProvider>(context, listen: false).clearCartItems();
        Scaffold.of(context).showSnackBar(SnackBar(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          // backgroundColor: Theme.of(context).primaryColor,
          content: Text(
            'Order Placed Successfully !!',
            style: TextStyle(fontSize: 18),
          ),
        ));
      }
    } else
      Scaffold.of(context).showSnackBar(SnackBar(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          backgroundColor: Theme.of(context).errorColor,
          content: Text(
            'Error while placing your order',
            style: TextStyle(fontSize: 18, color: Colors.white),
          )));
  }
}
