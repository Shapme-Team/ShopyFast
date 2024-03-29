import 'package:ShopyFast/domain/provider/orderProvider.dart';
import 'package:ShopyFast/getit.dart';
import 'package:ShopyFast/view/components/circularLoadingWidget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../../domain/models/Product.dart';
import '../../../../domain/models/order.dart';
import '../../checkout/components/productOrderWidget.dart';

class OrderDetailScreen extends StatefulWidget {
  static String routeName = '/orderDetailScreen';
  OrderDetailScreen();

  @override
  _OrderDetailScreenState createState() => _OrderDetailScreenState();
}

class _OrderDetailScreenState extends State<OrderDetailScreen> {
  int status = 0;
  bool _isLoading = false;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    OrderDetailScreenArg arg = ModalRoute.of(context).settings.arguments;
    var order = arg.order;
    return ChangeNotifierProvider.value(
      value: getIt<OrderProvider>(),
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            elevation: 1,
            title: Text(DateFormat('dd MMM yyyy').format(order.dateTime)),
            actions: [
              Center(widthFactor: 1.4, child: Text(order.deliveryStatus))
            ],
          ),
          body: FutureBuilder(
              future: getIt<OrderProvider>().getProductOfOrder(order),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting)
                  return CircularLoadingWidget();
                else
                  return Consumer<OrderProvider>(
                    builder: (context, value, _) => Column(
                      // mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          child: SingleChildScrollView(
                              child: Container(
                            // color: Colors.grey,
                            margin: EdgeInsets.all(12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                // addressWidget(),
                                productsWidget(
                                    value.getProductsOfOrder(order.orderId)),
                                totalWidget(order.amount),
                              ],
                            ),
                          )),
                        ),
                        // statusButtons()
                      ],
                    ),
                  );
              }),
        ),
      ),
    );
  }

  Widget productsWidget(List<Product> products) => Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
            border: Border.all(width: 1, color: Colors.blueGrey),
            borderRadius: BorderRadius.circular(8)),
        child: Column(
          children: products.map((e) => ProductItemWidget(e)).toList(),
        ),
      );
  Widget totalWidget(num amount) => Container(
        padding: EdgeInsets.all(12),
        alignment: Alignment.center,
        child: Text(
          'Total : $amount Rs',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
        ),
      );

  Widget _loadingWidet = Container(
    margin: EdgeInsets.only(right: 8),
    child: Center(
      child: CircularProgressIndicator(
        backgroundColor: Colors.white,
      ),
    ),
  );
}

class OrderDetailScreenArg {
  final Order order;
  OrderDetailScreenArg(this.order);
}
