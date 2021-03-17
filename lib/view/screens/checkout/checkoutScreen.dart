import 'package:ShopyFast/domain/models/Product.dart';
import 'package:ShopyFast/domain/models/order.dart';
import 'package:ShopyFast/domain/provider/orderProvider.dart';
import 'package:ShopyFast/getit.dart';
import 'package:ShopyFast/utils/constants/size_config.dart';
import 'package:ShopyFast/view/screens/checkout/components/orderProducts.dart';
import 'package:ShopyFast/view/screens/checkout/components/orderedDialogWidget.dart';
import 'package:ShopyFast/view/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CheckoutScreen extends StatefulWidget {
  static String routeName = "/checkoutScreen";
  CheckoutScreen();
  @override
  _CheckoutScreenState createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  var f16 = const TextStyle(
    fontSize: 16,
  );
  var f18 = const TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
  );
  bool _isLoading = false;

  orderDialog(BuildContext context) async {
    return await showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          content: OrderedDialogWidgte(),
        );
      },
    );
  }

  showErrorSnackBar() {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Theme.of(context).errorColor,
        content: Text(
          'Some problem while placing your order, Try again !',
          style: TextStyle(color: Colors.white),
        )));
  }

  @override
  Widget build(BuildContext context) {
    CheckoutScreenArg screenArg = ModalRoute.of(context).settings.arguments;
    var order = screenArg.order;
    var products = screenArg.listOfProducts;
    return ChangeNotifierProvider.value(
      value: getIt<OrderProvider>(),
      builder: (context, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text('checkout'),
          ),
          body: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  buildDeliveryAddress(order.customer.address),
                  OrderProductsWidget(products),
                  buildDeliveryCharge(order.amount),
                  buildDeliveryTime(),
                  paymentMethod(),
                ],
              ),
            ),
          ),
          bottomNavigationBar: buildOrderBottomCard(context, order),
        );
      },
    );
  }

  Widget buildDeliveryAddress(String address) => Container(
      padding: EdgeInsets.all(12),
      margin: EdgeInsets.only(bottom: 12),
      decoration:
          BoxDecoration(color: Colors.blueGrey.shade100.withOpacity(.3)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(
          'Delivery to address : ',
          style: f18,
        ),
        Text(address, style: f16),
      ]));

  Widget buildDeliveryCharge(num amount) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(12),
            // margin: EdgeInsets.only(bottom: 12),
            decoration:
                BoxDecoration(color: Colors.blueGrey.shade100.withOpacity(.3)),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Basket Value', style: f16),
                    Text('Rs $amount', style: f16)
                  ],
                ),
                SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Delivery Charge', style: f16),
                    Text('Free',
                        style: TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        )),
                  ],
                ),
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(color: Theme.of(context).accentColor),
            margin: EdgeInsets.only(bottom: 12),
            padding: EdgeInsets.all(12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Total amount ',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    )),
                Text('Rs $amount',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ))
              ],
            ),
          ),
        ],
      );

  Widget buildDeliveryTime() => Container(
      padding: EdgeInsets.all(12),
      margin: EdgeInsets.only(bottom: 12),
      decoration:
          BoxDecoration(color: Colors.blueGrey.shade100.withOpacity(.3)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Delivery time : ',
            style: f18,
          ),
          Row(
            children: [
              Text(
                '40 - 50 min  ',
                style: f16,
              ),
              Container(
                  padding: EdgeInsets.all(4),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, color: Colors.white),
                  child: Text("⚡", style: f16)),
            ],
          ),
        ],
      ));

  Widget paymentMethod() => Container(
      padding: EdgeInsets.all(12),
      margin: EdgeInsets.only(bottom: 12),
      decoration:
          BoxDecoration(color: Colors.blueGrey.shade100.withOpacity(.3)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Cash On Delivery ',
            style: f18,
          ),
          Icon(
            Icons.radio_button_checked,
            color: Colors.green,
          )
        ],
      ));

  Widget buildOrderBottomCard(BuildContext context, Order order) => Container(
        padding: EdgeInsets.all(8),
        // height: 174,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 8),
          width: double.infinity,
          height: getHeight(48),
          child: ElevatedButton(
            style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all(Theme.of(context).primaryColor)),
            // shape:
            //     RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            // color: Theme.of(context).primaryColor,
            onPressed: () async {
              // var dialogResponse = await orderDialog(context);

              // // Navigator.of(context).pop(dialogResponse ?? HomeScreen.routeName);
              // Navigator.of(context).pop(dialogResponse);
              // return;
              // var resCheck = false;
              setState(() => _isLoading = true);
              // var resCheck = true;
              var resCheck =
                  await Provider.of<OrderProvider>(context, listen: false)
                      .addOrder(order);
              setState(() => _isLoading = false);
              if (resCheck) {
                var dialogResponse = await orderDialog(context);
                Navigator.of(context)
                    .pop(dialogResponse ?? HomeScreen.routeName);
              } else
                showErrorSnackBar();
            },
            child: !_isLoading
                ? Text(
                    'Place Order',
                    style: TextStyle(
                      fontSize: getWidth(18),
                      color: Colors.white,
                    ),
                  )
                : CircularProgressIndicator(),
          ),
        ),
      );
}

class CheckoutScreenArg {
  final Order order;
  final List<Product> listOfProducts;
  CheckoutScreenArg(this.order, this.listOfProducts);
}
