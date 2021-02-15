import 'package:ShopyFast/domain/models/order.dart';
import 'package:flutter/material.dart';

// import 'categories.dart';
// import 'discount_banner.dart';
// import 'home_header.dart';
// import 'popular_product.dart';
// import 'special_offers.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: ListView.builder(
            shrinkWrap: true,
            itemCount: dummyOrderItem.length,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (BuildContext context, int index) {
              return Container(
                  height: 150,
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
                        'Amount: ₹' + dummyOrderItem[index].amount.toString(),
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 20,
                          color: Colors.green,
                        ),
                      ),
                      Text(
                        'Name: ' +
                            dummyOrderItem[index].customerName.toString(),
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 17,
                          color: Colors.grey,
                        ),
                      ),
                      Text(
                        'Order Id: #' +
                            dummyOrderItem[index].orderId.toString(),
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                      Text(
                        'No of items: ' +
                            dummyOrderItem[index].products.length.toString(),
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ));
            }),
      ),
    );
  }
}
