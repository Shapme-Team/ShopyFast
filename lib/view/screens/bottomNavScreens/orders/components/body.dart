import 'package:ShopyFast/domain/models/order.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(child: _buildListView()),
      ],
    );
  }
}

void addOrders(Order dummyorder) {
  final ordersBox = Hive.box('orders');
  ordersBox.add(dummyorder);
}

void addDummyOrders(Order dummyOrder) {
  addOrders(dummyOrder);
  print(dummyOrder);
}

Widget _buildListView() {
  return WatchBoxBuilder(
    box: Hive.box('orders'),
    builder: (context, ordersBox) {
      return (ordersBox.length > 0)
          ? ListView.builder(
              itemCount: ordersBox.length,
              itemBuilder: (context, index) {
                final contact = ordersBox.getAt(index) as Order;

                return Container(
                    height: 170,
                    margin: EdgeInsets.all(10),
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.blueGrey[100],
                            blurRadius: 2.0,
                            spreadRadius: 2,
                          ),
                        ],
                        borderRadius: BorderRadius.circular(10)),
                    child: Column(
                      children: [
                        Text(
                          'Amount: ₹' + contact.amount.toString(),
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 20,
                            color: Colors.green,
                          ),
                        ),
                        Text(
                          'Status: ' + contact.deliveryStatus,
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 17,
                            color: Colors.grey,
                          ),
                        ),
                        Text(
                          'Order Id: #' + contact.orderId.toString(),
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                        Text(
                          'No of items: ' + contact.products.length.toString(),
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            ordersBox.deleteAt(index);
                          },
                        )
                      ],
                    ));
              },
            )
          : Center(
              child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('No Orders Yet try ordering something'),
                RaisedButton(
                  onPressed: () {
                    dummyOrderItem.forEach((element) {
                      addDummyOrders(element);
                      print(element);
                    });
                  },
                  child: Text('add dummy orders'),
                )
              ],
            ));
    },
  );
}
