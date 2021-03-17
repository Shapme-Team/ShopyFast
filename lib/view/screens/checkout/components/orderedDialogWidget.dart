import 'package:ShopyFast/utils/constants/size_config.dart';
import 'package:ShopyFast/view/screens/bottomNavScreens/orders/orders.dart';
import 'package:ShopyFast/view/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class OrderedDialogWidgte extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Your Order is Placed Successfully !',
            style: Theme.of(context).textTheme.headline6,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: getHeight(8)),
          SvgPicture.asset(
            'assets/icons/done.svg',
            height: 50,
            // color: Colors.blue,
            // width: 50,
          ),
          SizedBox(height: getHeight(16)),
          OutlinedButton(
              onPressed: () {
                Navigator.of(context).pop(HomeScreen.routeName);
              },
              child: Text(
                'Continue shoping',
                style: TextStyle(
                    color: Theme.of(context).accentColor, fontSize: 16),
              )),
          TextButton(
              onPressed: () {
                Navigator.of(context).pop(OrdersScreen.routeName);
              },
              child: Text(
                'View order',
                style: TextStyle(
                    color: Theme.of(context).accentColor, fontSize: 16),
              ))
          // OutlinedButton(onPressed: () {}, child: Text('Done'))
        ],
      ),
    );
  }
}
