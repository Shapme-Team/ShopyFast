import 'dart:convert';

import 'package:ShopyFast/data/core/apiClient.dart';
import 'package:ShopyFast/data/source/orderDataSource.dart';
import 'package:ShopyFast/data/source/productDataSource.dart';
import 'package:ShopyFast/domain/models/Product.dart';
import 'package:ShopyFast/domain/models/order.dart';
import 'package:ShopyFast/utils/constants/globals.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';

/*      'grocery#aata#sid': 'Atta',
        'grocery#dryfruits#sid': 'Dry Fruits',
        'grocery#ghee_vanaspati#sid': 'Ghee & Vanaspati',
        'grocery#edible_oils#sid': 'Edible Oils',
*/

main() {
  test(
    " get order  ",
    () async {
//arrange
      // var apiClient = ApiClient(Client());
      // var dataSource = OrderDataSourceApiImple(apiClient);
      var order = {
        "_id": "602e76d7dfbdf42e486572ac",
        "customerId": "dummy_customer_id",
        "customer": {
          "name": "Akash Maurya",
          "phoneNumber": 9563423456,
          "address": "Rohini sec 13, Kolimb Aprtment House no: a/34 block b "
        },
        "amount": 1306.8,
        "deliveryStatus": "PROCESSING",
        "products": [
          {
            "_id": "6026bbd76d3a99169ce0f16f",
            "productName": "Fruits",
            "description": "description is good",
            "price": 435.6,
            "quantity": 3,
            "category": "FRUITS_AND_VEGETABLE",
            "weight": 2,
            "measureUnit": "kg"
          }
        ],
        "dateTime": "2021-02-18T19:46:55.116Z",
        "__v": 0
      };
      final orderVal = Order.fromMap(order);
//assert
      final vall = orderVal != null;
//test
      expect(vall, true);
    },
  );
}
